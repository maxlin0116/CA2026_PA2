package cpu

import chisel3._
import chisel3.util._
import cpu.OP_TYPES._

class Alu_io extends Bundle {
    val to_branch = Output(Bool())
    val alu_result = Output(UInt(32.W))
    val jump_addr = Output(UInt(32.W))
    val src_a      = Input(UInt(32.W))   // First ALU operand (usually from rs1)
    val src_b      = Input(UInt(32.W))   // Second ALU operand (from rs2 or immediate)
    val imm        = Input(UInt(32.W))   // 32-bit sign-extended immediate value from Decoder
    val pc         = Input(UInt(32.W))   // Current Program Counter (PC) of this instruction
    val alu_op     = Input(UInt(5.W))    // 5-bit ALU operation selector (from OP_TYPES)
}

class Alu extends Module {
    val io = IO(new Alu_io())

    val to_branch = WireDefault(false.B)
    val alu_result = WireDefault(0.U(32.W))
    val jump_addr = WireDefault(0.U(32.W))

    switch(io.alu_op) {
        // ---------------- Arithmetic and Logical Operations ----------------
        is(OP_ADD) {
            alu_result := io.src_a + io.src_b
        }
        is(OP_SUB) {
            alu_result := io.src_a - io.src_b
        }
        is(OP_AND) {
            alu_result := io.src_a & io.src_b
        }
        is(OP_OR) {
            alu_result := io.src_a | io.src_b
        }
        is(OP_XOR) {
            alu_result := io.src_a ^ io.src_b
        }

        // ---------------- Shift Operations ----------------
        // RISC-V specification: shift amount is given by the low 5 bits of src_b (0..31)
        is(OP_SLL) {
            alu_result := io.src_a << io.src_b(4, 0)
        }
        is(OP_SRL) {
            alu_result := io.src_a >> io.src_b(4, 0) // Logical shift right (fills with 0)
        }
        is(OP_SRA) {
            // Arithmetic shift right: cast to SInt to sign-extend, then cast back to UInt
            alu_result := (io.src_a.asSInt >> io.src_b(4, 0)).asUInt
        }

        // ---------------- Comparison Operations ----------------
        is(OP_SLT) {
            // Set Less Than (Signed comparison)
            alu_result := Mux(io.src_a.asSInt < io.src_b.asSInt, 1.U, 0.U)
        }

        // ---------------- Branch Operations ----------------
        // Branch target address is always PC + imm
        is(OP_BEQ) {
            to_branch := (io.src_a === io.src_b)
            jump_addr := io.pc + io.imm
        }
        is(OP_BNE) {
            to_branch := (io.src_a =/= io.src_b)
            jump_addr := io.pc + io.imm
        }
        is(OP_BLT) {
            // Signed less-than comparison
            to_branch := (io.src_a.asSInt < io.src_b.asSInt)
            jump_addr := io.pc + io.imm
        }
        is(OP_BGE) {
            // Signed greater-or-equal comparison
            to_branch := (io.src_a.asSInt >= io.src_b.asSInt)
            jump_addr := io.pc + io.imm
        }

        // ---------------- Jump Operations ----------------
        is(OP_JAL) {
            alu_result := io.pc + 4.U                 // Return address saved to rd
            jump_addr  := io.pc + io.imm              // Target address: PC + imm
        }
        is(OP_JALR) {
            alu_result := io.pc + 4.U                 // Return address saved to rd
            jump_addr  := (io.src_a + io.imm) & ~1.U(32.W) // Target: (rs1 + imm) with LSB cleared to 0
        }

        // ---------------- Upper Immediate Operations ----------------
        is(OP_LUI) {
            alu_result := io.imm                      // Immediate already shifted by Decoder
        }
        is(OP_AUIPC) {
            alu_result := io.pc + io.imm              // PC + (imm << 12)
        }

        // ---------------- Multiplier Operation ----------------
        is(OP_MUL) {
            alu_result := 0.U                         // Actual multiplication is handled by MulUnit
        }
    }    

    
    io.alu_result := alu_result
    io.to_branch := to_branch
    io.jump_addr := jump_addr
}
