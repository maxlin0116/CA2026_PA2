package cpu

import chisel3._
import chiseltest._
import chiseltest.simulator.WriteVcdAnnotation
import org.scalatest.flatspec.AnyFlatSpec

import scala.io.Source

/// DO NOT MODIFY THIS FILE ///
// One run = one configuration + one program, chosen with environment variables:
//   MODE        single | stall | forward                     (default single)
//   HAS_MUL     0 | 1                                        (default 0, pipeline only)
//   LATENCY     data memory latency of the pipelined CPU     (default 1)
//   INST_FILE   program                                      (default src/test/pattern/A1.hex)
//   GOLDEN_FILE expected data memory                         (default src/test/pattern/A1_golden.hex)
//   MAX_CYCLE   timeout                                      (default 100000)

object Harness {
  val defaultMaxCycle = 100000

  def config(mode: String, hasMul: Boolean): CpuConfig = mode match {
    case "single"  => CpuConfig(SingleCycle, hasMul)
    case "stall"   => CpuConfig(Pipelined(forwarding = false), hasMul)
    case "forward" => CpuConfig(Pipelined(forwarding = true), hasMul)
    case other     => throw new IllegalArgumentException(s"MODE must be single, stall or forward (got '$other')")
  }

  // "3" -> Fixed(3). (Grading also uses latencies that change from read to read.)
  def latency(s: String): Latency =
    try Fixed(s.trim.toInt)
    catch { case _: NumberFormatException => throw new IllegalArgumentException(s"bad LATENCY '$s'") }

  def readGolden(file: String): Array[Int] = {
    val golden = Array.fill(1024)(0)
    val src = Source.fromFile(file)
    val words = try src.getLines().map(_.trim).filter(_.nonEmpty)
      .map(l => java.lang.Long.parseLong(l, 16).toInt).toArray   // unsigned hex words
    finally src.close()
    Array.copy(words, 0, golden, 0, words.length.min(1024))
    golden
  }

  case class Result(status: String, cycles: Int, mismatches: Seq[(Int, Int, Int)], lateWrites: Int) {
    def pass: Boolean = status == "PASS"
  }

  // Runs until the instruction memory outputs 0x00000000 (EOF). `cycles` is the number of
  // loop iterations, i.e. the cycle (counted from 0 after reset) in which EOF is on `inst`.
  // The pipeline is not drained.
  def run(dut: Top, golden: Array[Int], maxCycle: Int, verbose: Boolean, drain: Int = 0): Result = {
    dut.clock.setTimeout(0)
    val mem = Array.fill(1024)(0)
    var cycle = 0
    var pcPrev = -1L
    while (dut.io.inst.peekInt() != 0 && cycle < maxCycle) {
      if (dut.io.peek_write.peekBoolean()) {
        mem((dut.io.peek_addr.peekInt() >> 2).toInt & 1023) = dut.io.peek_data.peekInt().toInt
      }
      val pc = dut.io.pc.peekInt().toLong
      if (verbose && pc != pcPrev) {
        println(f"[Cycle $cycle%05d] PC = 0x$pc%08x, INST = 0x${dut.io.inst.peekInt()}%08x")
      }
      pcPrev = pc
      dut.clock.step(1)
      cycle += 1
    }
    val timeout = cycle >= maxCycle

    var late = 0
    for (_ <- 0 until drain) {
      if (dut.io.peek_write.peekBoolean()) late += 1
      dut.clock.step(1)
    }

    val mism = (0 until 1024).filter(i => mem(i) != golden(i)).map(i => (i, mem(i), golden(i)))
    val status = if (timeout) "TIMEOUT" else if (mism.nonEmpty) "FAIL" else "PASS"
    Result(status, cycle, mism, late)
  }
}

class CoreTest extends AnyFlatSpec with ChiselScalatestTester {
  val mode       = sys.env.getOrElse("MODE", "single")
  val hasMul     = sys.env.getOrElse("HAS_MUL", "0") == "1"
  val latStr     = sys.env.getOrElse("LATENCY", "1")
  val instFile   = sys.env.getOrElse("INST_FILE", "src/test/pattern/A1.hex")
  val goldenFile = sys.env.getOrElse("GOLDEN_FILE", "src/test/pattern/A1_golden.hex")
  val maxCycle   = sys.env.getOrElse("MAX_CYCLE", Harness.defaultMaxCycle.toString).toInt

  val cfg = Harness.config(mode, hasMul)
  val lat = Harness.latency(latStr)
  val program = new java.io.File(instFile).getName.stripSuffix(".hex")
  val runName = cfg.mode match {
    case SingleCycle => s"${cfg.name}_$program"
    case _           => s"${cfg.name}_${lat.name}_$program"
  }

  s"Top_$runName" should "match golden memory" in {
    test(new Top(cfg, lat, instFile)).withAnnotations(Seq(WriteVcdAnnotation)) { dut =>
      println(s"Config: $runName  (program $instFile, golden $goldenFile)")
      println("=== Start Simulation ===")
      val r = Harness.run(dut, Harness.readGolden(goldenFile), maxCycle, verbose = true)

      if (r.status == "TIMEOUT") {
        println(s"\n=== TIMEOUT: EOF not reached within $maxCycle cycles ===")
      } else {
        println("\n=== Checking Data Memory ===")
        for ((i, d, g) <- r.mismatches)
          println(f"[Mismatch @ index $i%04d] DUT = 0x$d%08x, GOLD = 0x$g%08x")
        if (r.pass) println("\n=== PASS ===")
        else println(s"\n=== FAIL ===\n${r.mismatches.length} errors found.")
      }
      println(s"[RESULT] config=$runName status=${r.status} cycles=${r.cycles}")
      assert(r.status != "TIMEOUT", s"timeout: EOF not reached within $maxCycle cycles")
      assert(r.pass, s"Data memory mismatch (${r.mismatches.length} errors)")
    }
  }
}
