package cpu

import chisel3._

// collect all control signals
class CtrlSignal extends Bundle {
    val ctrlJump = Output(Bool())
    val ctrlBranch = Output(Bool())
    val ctrlRegWrite = Output(Bool())
    val ctrlMemRead = Output(Bool())
    val ctrlMemWrite = Output(Bool())
    val ctrlALUSrc = Output(Bool())
    val ctrlALUOp = Output(UInt(5.W))
    val ctrlMemToReg = Output(Bool())
}

// collect all register addresses
class RegAddr extends Bundle {
    val rs1_addr = Output(UInt(5.W))
    val rs2_addr = Output(UInt(5.W))
    val rd_addr = Output(UInt(5.W))
}

// ALUOp values
object OP_TYPES { 
    val OP_NOP = "b00000".U
    val OP_ADD = "b00001".U
    val OP_SUB = "b00010".U
    val OP_AND = "b00011".U
    val OP_OR  = "b00100".U
    val OP_XOR = "b00101".U
    val OP_SLT = "b00110".U
    val OP_SLL = "b00111".U
    val OP_SRL = "b01000".U
    val OP_SRA = "b01001".U
    val OP_BEQ = "b01010".U
    val OP_BNE = "b01011".U
    val OP_BLT = "b01100".U
    val OP_BGE = "b01101".U
    val OP_JAL = "b01110".U
    val OP_JALR = "b01111".U
    val OP_LUI = "b10000".U
    val OP_AUIPC = "b10001".U
    val OP_MUL = "b10010".U   // mul, executed by MulUnit (ALU result is 0)
}

// ---------------- Pipeline Register Bundles ----------------
// Pipeline Register: IF to ID
class IF_ID extends Bundle {
    val pc    = Output(UInt(32.W)) // PC address of this instruction
    val inst  = Output(UInt(32.W)) // 32-bit instruction fetched from memory
    val valid = Output(Bool())     // False if flushed/bubble, true if valid instruction
}
// Pipeline Register: ID to EX
class ID_EX extends Bundle {
    val pc       = Output(UInt(32.W))      // PC address of this instruction
    val inst     = Output(UInt(32.W))      // Instruction (useful for debugging/mul)
    val ctrl     = Output(new CtrlSignal)  // Decoded control signals
    val rs1_addr = Output(UInt(5.W))       // Source register 1 address (for forwarding/hazard)
    val rs2_addr = Output(UInt(5.W))       // Source register 2 address (for forwarding/hazard)
    val rd_addr  = Output(UInt(5.W))       // Destination register address
    val rdata1   = Output(UInt(32.W))      // Value read from rs1
    val rdata2   = Output(UInt(32.W))      // Value read from rs2
    val imm      = Output(UInt(32.W))      // Sign-extended immediate
    val valid    = Output(Bool())          // Valid instruction flag
}
// Pipeline Register: EX to MEM
class EX_MEM extends Bundle {
    val ctrl       = Output(new CtrlSignal) // Control signals (ctrlRegWrite, ctrlMemRead, ctrlMemWrite, ctrlMemToReg)
    val rd_addr    = Output(UInt(5.W))      // Destination register address
    val alu_result = Output(UInt(32.W))     // Memory address or calculation result
    val wdata      = Output(UInt(32.W))     // Store data for sw (forwarded from rs2)
    val valid      = Output(Bool())         // Valid instruction flag
}
// Pipeline Register: MEM to WB
class MEM_WB extends Bundle {
    val ctrl       = Output(new CtrlSignal) // Control signals (ctrlRegWrite, ctrlMemToReg)
    val rd_addr    = Output(UInt(5.W))      // Destination register address
    val alu_result = Output(UInt(32.W))     // ALU calculation result
    val rdata      = Output(UInt(32.W))     // Data loaded from data memory (for lw)
    val valid      = Output(Bool())         // Valid instruction flag
}
