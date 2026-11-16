package cpu

import chisel3.util.isPow2

/// DO NOT MODIFY THIS FILE ///
// Configuration of the CPU that Top builds. These are Scala values known at
// elaboration time: use a Scala `if` on them, not a Chisel `when`.

sealed trait CpuMode
case object SingleCycle extends CpuMode
case class Pipelined(forwarding: Boolean) extends CpuMode

case class CpuConfig(mode: CpuMode, hasMul: Boolean = false) {
  require(!(hasMul && mode == SingleCycle), "mul is pipeline-only")

  def name: String = (mode match {
    case SingleCycle            => "single"
    case Pipelined(false)       => "stall"
    case Pipelined(true)        => "forward"
  }) + (if (hasMul) "_mul" else "")
}

// Data memory latency of the pipelined CPU. It is chosen by the testbench and is
// deliberately NOT part of CpuConfig: your core never sees it.
sealed trait Latency { def name: String }

// every read answers after exactly n cycles
case class Fixed(n: Int) extends Latency {
  require(n >= 1 && n <= 256, "latency must be in 1..256")
  def name = s"L$n"
}

// every request (read or write, in the order they fire) steps a 16-bit Galois LFSR
// (taps 0xB400) starting from `seed`; a read answers after 1 + (state & (max - 1))
// cycles, i.e. 1..max. The same seed always gives the same sequence.
case class Random(seed: Int, max: Int) extends Latency {
  require((seed & 0xFFFF) != 0, "LFSR seed must be non-zero")
  require(isPow2(max) && max >= 1 && max <= 256, "max must be a power of two in 1..256")
  def name = f"rand${seed & 0xFFFF}%04x_$max"
}
