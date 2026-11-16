package cpu

import chisel3._
import chisel3.util._

/// DO NOT MODIFY THIS FILE ///
// What the testbench sees. Every signal comes from the provided memories,
// not from your core.
class TopIO extends Bundle {
  val pc   = Output(UInt(32.W))   // address of the word on `inst`
  val inst = Output(UInt(32.W))   // instruction memory output
  // data memory write events
  val peek_write = Output(Bool())
  val peek_addr  = Output(UInt(32.W))
  val peek_data  = Output(UInt(32.W))
}

class Top(cfg: CpuConfig, lat: Latency, instFile: String) extends Module {
  val io = IO(new TopIO)

  cfg.mode match {
    case SingleCycle =>
      val core = Module(new SingleCycleCore)
      val imem = Module(new InstMemComb(instFile))
      val dmem = Module(new DataMemComb)

      imem.io.addr      := core.io.imem.addr
      core.io.imem.inst := imem.io.inst

      dmem.io.ctrlMemRead  := core.io.dmem.ctrlMemRead
      dmem.io.ctrlMemWrite := core.io.dmem.ctrlMemWrite
      dmem.io.addr         := core.io.dmem.addr
      dmem.io.data_in      := core.io.dmem.data_in
      core.io.dmem.data_out := dmem.io.data_out

      io.pc         := imem.io.pc
      io.inst       := imem.io.inst
      io.peek_write := dmem.io.peek.write
      io.peek_addr  := dmem.io.peek.addr
      io.peek_data  := dmem.io.peek.data

    case Pipelined(forwarding) =>
      val core = Module(new PipelineCore(forwarding, cfg.hasMul))
      val imem = Module(new InstMemSync(instFile))
      val dmem = Module(new DataMemHS(lat))

      imem.io.addr      := core.io.imem.addr
      core.io.imem.inst := imem.io.inst

      dmem.io.req       <> core.io.dmem.req
      core.io.dmem.resp <> dmem.io.resp

      if (cfg.hasMul) {
        val mul = Module(new MulUnit)
        mul.io.req       <> core.io.mul.get.req
        core.io.mul.get.resp <> mul.io.resp
      }

      io.pc         := imem.io.pc
      io.inst       := imem.io.inst
      io.peek_write := dmem.io.peek.write
      io.peek_addr  := dmem.io.peek.addr
      io.peek_data  := dmem.io.peek.data
  }
}
