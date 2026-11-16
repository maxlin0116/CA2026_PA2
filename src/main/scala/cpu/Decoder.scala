package cpu

import chisel3._
import chisel3.util._
import cpu.OP_TYPES._

class Decoder_io extends Bundle {
    // Input: 32-bit machine instruction fetched from instruction memory
    val inst     = Input(UInt(32.W))
    // Output: Control signals for ALU, memory read/write, register write, and branches
    val ctrl     = Output(new CtrlSignal)
    // Output: Source and destination register addresses (rs1, rs2, rd) sent to Regfile
    val reg_addr = Output(new RegAddr)
    // Output: Sign-extended 32-bit immediate extracted from the instruction
    val imm      = Output(UInt(32.W))
}

class Decoder extends Module {
    // declare the input/output interface of the module
    val io = IO(new Decoder_io())

    // 1. Bit slicing: extract instruction fields according to RISC-V standard
    val inst   = io.inst
    val opcode = inst(6, 0)
    val funct3 = inst(14, 12)
    val funct7 = inst(31, 25)
    // 2. Decode register addresses and forward them to Regfile
    io.reg_addr.rs1_addr := inst(19, 15)
    io.reg_addr.rs2_addr := inst(24, 20)
    io.reg_addr.rd_addr  := inst(11, 7)
    // 3. Default control signals and immediate value (initialized to 0)
    val ctrl = WireDefault(0.U.asTypeOf(new CtrlSignal))
    val imm  = WireDefault(0.U(32.W))
    // 4. Control signal decoding and immediate generation based on opcode
    switch(opcode) {
        // R-type: add, sub, and, or, xor, slt, sll, srl, sra, mul
        is("b0110011".U) {
            ctrl.ctrlRegWrite := true.B
            ctrl.ctrlALUSrc   := false.B // Operand 2 comes from rs2
            switch(funct3) {
                is("b000".U) {
                    when(funct7 === "b0100000".U) {
                        ctrl.ctrlALUOp := OP_SUB
                    }.elsewhen(funct7 === "b0000001".U) {
                        ctrl.ctrlALUOp := OP_MUL
                    }.otherwise {
                        ctrl.ctrlALUOp := OP_ADD
                    }
                }
                is("b001".U) { ctrl.ctrlALUOp := OP_SLL }
                is("b010".U) { ctrl.ctrlALUOp := OP_SLT }
                is("b100".U) { ctrl.ctrlALUOp := OP_XOR }
                is("b101".U) {
                    when(funct7 === "b0100000".U) {
                        ctrl.ctrlALUOp := OP_SRA
                    }.otherwise {
                        ctrl.ctrlALUOp := OP_SRL
                    }
                }
                is("b110".U) { ctrl.ctrlALUOp := OP_OR }
                is("b111".U) { ctrl.ctrlALUOp := OP_AND }
            }
        }
        // I-type ALU: addi, slti, slli, srli, srai
        is("b0010011".U) {
            ctrl.ctrlRegWrite := true.B
            ctrl.ctrlALUSrc   := true.B // Operand 2 comes from immediate
            imm := Cat(Fill(20, inst(31)), inst(31, 20)) // 12-bit sign extension
            switch(funct3) {
                is("b000".U) { ctrl.ctrlALUOp := OP_ADD }
                is("b010".U) { ctrl.ctrlALUOp := OP_SLT }
                is("b001".U) { ctrl.ctrlALUOp := OP_SLL }
                is("b101".U) {
                    when(funct7 === "b0100000".U) {
                        ctrl.ctrlALUOp := OP_SRA
                    }.otherwise {
                        ctrl.ctrlALUOp := OP_SRL
                    }
                }
            }
        }
        // Load: lw
        is("b0000011".U) {
            ctrl.ctrlRegWrite := true.B
            ctrl.ctrlMemRead  := true.B
            ctrl.ctrlMemToReg := true.B // Write back data from memory to register
            ctrl.ctrlALUSrc   := true.B
            ctrl.ctrlALUOp    := OP_ADD  // Address calculation: rs1 + imm
            imm := Cat(Fill(20, inst(31)), inst(31, 20))
        }
        // Store: sw
        is("b0100011".U) {
            ctrl.ctrlMemWrite := true.B
            ctrl.ctrlALUSrc   := true.B
            ctrl.ctrlALUOp    := OP_ADD  // Address calculation: rs1 + imm
            imm := Cat(Fill(20, inst(31)), inst(31, 25), inst(11, 7))
        }
        // Branch: beq, bne, blt, bge
        is("b1100011".U) {
            ctrl.ctrlBranch := true.B
            ctrl.ctrlALUSrc := false.B // Compare rs1 and rs2
            imm := Cat(Fill(20, inst(31)), inst(7), inst(30, 25), inst(11, 8), 0.U(1.W))
            switch(funct3) {
                is("b000".U) { ctrl.ctrlALUOp := OP_BEQ }
                is("b001".U) { ctrl.ctrlALUOp := OP_BNE }
                is("b100".U) { ctrl.ctrlALUOp := OP_BLT }
                is("b101".U) { ctrl.ctrlALUOp := OP_BGE }
            }
        }
        // JAL: Jump and Link
        is("b1101111".U) {
            ctrl.ctrlJump     := true.B
            ctrl.ctrlRegWrite := true.B
            ctrl.ctrlALUOp    := OP_JAL  // Saves PC + 4 to rd
            imm := Cat(Fill(12, inst(31)), inst(19, 12), inst(20), inst(30, 21), 0.U(1.W))
        }
        // JALR: Jump and Link Register
        is("b1100111".U) {
            ctrl.ctrlJump     := true.B
            ctrl.ctrlRegWrite := true.B
            ctrl.ctrlALUOp    := OP_JALR // Saves PC + 4 to rd, jumps to (rs1 + imm) & ~1
            imm := Cat(Fill(20, inst(31)), inst(31, 20))
        }
        // LUI: Load Upper Immediate
        is("b0110111".U) {
            ctrl.ctrlRegWrite := true.B
            ctrl.ctrlALUOp    := OP_LUI  // Result is imm << 12
            imm := Cat(inst(31, 12), 0.U(12.W))
        }
        // AUIPC: Add Upper Immediate to PC
        is("b0010111".U) {
            ctrl.ctrlRegWrite := true.B
            ctrl.ctrlALUOp    := OP_AUIPC // Result is PC + (imm << 12)
            imm := Cat(inst(31, 12), 0.U(12.W))
        }
    }
    // 5. Connect internal signals to module output ports
    io.ctrl := ctrl
    io.imm  := imm
}
