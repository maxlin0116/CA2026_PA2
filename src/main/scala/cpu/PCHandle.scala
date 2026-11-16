package cpu

import chisel3._
import chisel3.util._

class PCHandle_io extends Bundle {
    // ---------------- Inputs ----------------
    // Enable PC update. When false (e.g., during pipeline stall), PC holds its value.
    val enable    = Input(Bool())
    // High when a branch is taken or an unconditional jump (JAL, JALR) occurs.
    val jump_flag = Input(Bool())
    // Target address to jump to when jump_flag is high.
    val jump_addr = Input(UInt(32.W))
    // ---------------- Outputs ----------------
    // Current 32-bit Program Counter value sent to instruction memory and datapath.
    val pc        = Output(UInt(32.W))
}

class PCHandle extends Module {
    val io = IO(new PCHandle_io())  

    val pc = RegInit(UInt(32.W), 0.U) 
    
    // Update PC on the rising clock edge when enable is asserted
    when(io.enable) {
        when(io.jump_flag) {
            pc := io.jump_addr // Branch taken or Jump: update to target address
        }.otherwise {
            pc := pc + 4.U     // Sequential execution: next instruction is at PC + 4 bytes
        }
    }
    // Connect internal PC register to module output port
    io.pc := pc
}
