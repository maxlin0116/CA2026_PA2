package cpu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.loadMemoryFromFile
import firrtl.annotations.MemoryLoadFileType

/// DO NOT MODIFY THIS FILE ///
// Instruction and data memories. Top picks the right ones for each configuration.

class InstMemIO extends Bundle {
  val addr = Input(UInt(32.W))
  val inst = Output(UInt(32.W))
  val pc   = Output(UInt(32.W))   // address of the word currently on `inst` (testbench only)
}

// Single-cycle: combinational read, `inst` belongs to `addr` of the same cycle.
class InstMemComb(instFile: String) extends Module {
  val io  = IO(new InstMemIO)
  val mem = Mem(1024, UInt(32.W))
  loadMemoryFromFile(mem, instFile, MemoryLoadFileType.Hex)

  io.inst := mem.read(io.addr >> 2)
  io.pc   := io.addr
}

// Pipeline: one-cycle synchronous read, `inst` in cycle t+1 belongs to `addr` of cycle t.
// While reset is high the address is forced to 0, so the first instruction (address 0) is
// on `inst` in the first cycle after reset, whatever the core drives.
class InstMemSync(instFile: String) extends Module {
  val io  = IO(new InstMemIO)
  val mem = SyncReadMem(1024, UInt(32.W))
  loadMemoryFromFile(mem, instFile, MemoryLoadFileType.Hex)

  io.inst := mem.read(Mux(reset.asBool, 0.U, io.addr >> 2))
  io.pc   := RegNext(io.addr, 0.U)
}

// Single-cycle data memory: last year's DataMem with the combinational read.
class DataMemComb extends Module {
  val io = IO(new Bundle {
    val ctrlMemRead  = Input(Bool())
    val ctrlMemWrite = Input(Bool())
    val addr         = Input(UInt(32.W))
    val data_in      = Input(UInt(32.W))
    val data_out     = Output(UInt(32.W))
    val peek         = Output(new MemPeek)
  })
  val mem   = Mem(1024, UInt(32.W))
  val index = io.addr >> 2

  when(io.ctrlMemWrite) {
    mem.write(index, io.data_in)
  }
  io.data_out   := Mux(io.ctrlMemRead, mem.read(index), 0.U)
  io.peek.write := io.ctrlMemWrite
  io.peek.addr  := io.addr
  io.peek.data  := io.data_in
}

// Pipelined data memory with a valid/ready handshake.
//  * read : req fires in cycle t -> resp.valid first high in cycle t+L, rdata held until resp fires
//  * write: takes effect in the cycle req fires, no response
//  * at most one outstanding read: req.ready = !busy || resp.fire
class DataMemHS(latency: Latency) extends Module {
  val io = IO(new Bundle {
    val req  = Flipped(Decoupled(new MemReq))
    val resp = Decoupled(new MemResp)
    val peek = Output(new MemPeek)
  })
  val mem   = SyncReadMem(1024, UInt(32.W))
  val index = io.req.bits.addr >> 2

  val busy = RegInit(false.B)    // a read is outstanding
  val cnt  = RegInit(0.U(8.W))   // cycles left until resp.valid

  io.req.ready := !busy || io.resp.fire
  val doRead  = io.req.fire && !io.req.bits.wen
  val doWrite = io.req.fire && io.req.bits.wen

  // latency of the request that fires in this cycle
  val lat: UInt = latency match {
    case Fixed(n) => n.U(9.W)
    case Random(seed, max) =>
      val state = RegInit((seed & 0xFFFF).U(16.W))
      val next  = Mux(state(0), (state >> 1) ^ 0xB400.U(16.W), state >> 1)
      when(io.req.fire) { state := next }
      1.U(9.W) + (next & (max - 1).U)
  }

  when(doWrite) {
    mem.write(index, io.req.bits.wdata)
  }
  // SyncReadMem only drives its output in the cycle after a read, so keep a copy
  val readOut = mem.read(index, doRead)
  val fresh   = RegNext(doRead, false.B)
  val held    = RegEnable(readOut, fresh)

  io.resp.valid      := busy && cnt === 0.U
  io.resp.bits.rdata := Mux(fresh, readOut, held)

  when(doRead) {
    busy := true.B
    cnt  := lat - 1.U
  }.elsewhen(io.resp.fire) {
    busy := false.B
  }.elsewhen(busy && cnt =/= 0.U) {
    cnt := cnt - 1.U
  }

  io.peek.write := doWrite
  io.peek.addr  := io.req.bits.addr
  io.peek.data  := io.req.bits.wdata
}
