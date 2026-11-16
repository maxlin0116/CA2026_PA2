package cpu

import chisel3._
import chisel3.util._

/// DO NOT MODIFY THIS FILE ///
// Ports between the cores and the provided memories / multiplier.
// All port bundles are defined from the CPU's point of view.

// ---------------- instruction memory (both cores) ----------------
class InstMemPort extends Bundle {
  val addr = Output(UInt(32.W))   // byte address
  val inst = Input(UInt(32.W))
}

// ---------------- data memory, single-cycle (combinational read) ----------------
// Same signals as last year's DataMem_io.
class DataMemCombPort extends Bundle {
  val ctrlMemRead  = Output(Bool())
  val ctrlMemWrite = Output(Bool())
  val addr         = Output(UInt(32.W))   // byte address
  val data_in      = Output(UInt(32.W))   // write data
  val data_out     = Input(UInt(32.W))    // read data (0 when ctrlMemRead is low)
}

// ---------------- data memory, pipelined (valid/ready handshake) ----------------
class MemReq extends Bundle {
  val addr  = UInt(32.W)   // byte address
  val wdata = UInt(32.W)
  val wen   = Bool()       // true = write, false = read
}
class MemResp extends Bundle {
  val rdata = UInt(32.W)
}
class DataMemIO extends Bundle {
  val req  = Decoupled(new MemReq)              // CPU -> memory
  val resp = Flipped(Decoupled(new MemResp))    // memory -> CPU
}

// ---------------- multiplier (hasMul) ----------------
class MulReq extends Bundle {
  val a = UInt(32.W)
  val b = UInt(32.W)
}
class MulResp extends Bundle {
  val result = UInt(32.W)
}
class MulIO extends Bundle {
  val req  = Decoupled(new MulReq)              // CPU -> multiplier
  val resp = Flipped(Decoupled(new MulResp))    // multiplier -> CPU
}

// ---------------- core I/O (fixed: Top connects to these) ----------------
class SingleCycleCoreIO extends Bundle {
  val imem = new InstMemPort
  val dmem = new DataMemCombPort
}

class PipelineCoreIO(val hasMul: Boolean) extends Bundle {
  val imem = new InstMemPort
  val dmem = new DataMemIO
  val mul  = if (hasMul) Some(new MulIO) else None
}

// write events of the data memory, for the testbench only
class MemPeek extends Bundle {
  val write = Bool()
  val addr  = UInt(32.W)
  val data  = UInt(32.W)
}
