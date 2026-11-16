package cpu

import chisel3._
import chisel3.util._

// Single-cycle RV32I core.
// The I/O is fixed (Top connects to it, see Interfaces.scala):
//   io.imem : instruction memory, combinational read (inst belongs to addr of the same cycle)
//   io.dmem : data memory, combinational read (data_out belongs to addr of the same cycle)
// The PC starts at 0 after reset.
class SingleCycleCore extends Module {
  val io = IO(new SingleCycleCoreIO)

  // 1. Instantiate submodules
  val pcHandle = Module(new PCHandle)
  val decoder  = Module(new Decoder)
  val regfile  = Module(new Regfile)
  val alu      = Module(new Alu)

  // 2. Instruction Fetch (IF)
  io.imem.addr      := pcHandle.io.pc
  decoder.io.inst   := io.imem.inst

  // 3. Instruction Decode & Register Read (ID)
  regfile.io.reg_addr     := decoder.io.reg_addr
  regfile.io.ctrlRegWrite := decoder.io.ctrl.ctrlRegWrite

  // 4. Execution & ALU Operand Selection (EX)
  alu.io.alu_op := decoder.io.ctrl.ctrlALUOp
  alu.io.imm    := decoder.io.imm
  alu.io.pc     := pcHandle.io.pc
  alu.io.src_a  := regfile.io.data_read1
  // Select second operand: rs2 data or immediate value
  alu.io.src_b  := Mux(decoder.io.ctrl.ctrlALUSrc, decoder.io.imm, regfile.io.data_read2)

  // 5. Data Memory Access (MEM)
  io.dmem.ctrlMemRead  := decoder.io.ctrl.ctrlMemRead
  io.dmem.ctrlMemWrite := decoder.io.ctrl.ctrlMemWrite
  io.dmem.addr         := alu.io.alu_result
  io.dmem.data_in      := regfile.io.data_read2

  // 6. Write Back (WB)
  // Select writeback data: memory data (lw) or ALU calculation result
  val wb_data = Mux(decoder.io.ctrl.ctrlMemToReg, io.dmem.data_out, alu.io.alu_result)
  regfile.io.data_write := wb_data

  // 7. Next PC Logic
  // Single-cycle core never stalls, so enable is always true
  pcHandle.io.enable    := true.B
  // Jump if it's an unconditional jump (JAL, JALR) or a taken branch (BEQ, BNE, BLT, BGE)
  pcHandle.io.jump_flag := (decoder.io.ctrl.ctrlBranch && alu.io.to_branch) || decoder.io.ctrl.ctrlJump
  pcHandle.io.jump_addr := alu.io.jump_addr
}