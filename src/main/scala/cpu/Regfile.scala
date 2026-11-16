package cpu

import chisel3._
import chisel3.util._

class Regfile_io extends Bundle {
    // Control signal: Enable writing to destination register rd
    val ctrlRegWrite = Input(Bool())
    // Input: 5-bit register addresses (rs1, rs2, rd) from Decoder
    val reg_addr     = Input(new RegAddr)
    // Input: 32-bit data to be written into register rd (from ALU or Data Memory)
    val data_write   = Input(UInt(32.W))
    // Output: 32-bit data read from source register rs1
    val data_read1   = Output(UInt(32.W))
    // Output: 32-bit data read from source register rs2
    val data_read2   = Output(UInt(32.W))
}

class Regfile extends Module {
    val io = IO(new Regfile_io())

    // declare 32 registers each 32 bits
    val regs = Reg(Vec(32, UInt(32.W)))

    // ---------------- Read Port 1 ----------------
    // 1. Register x0 is hardwired to 0
    // 2. Internal forwarding: if writing to rd in the same cycle and rd == rs1, forward data_write directly
    // 3. Otherwise, read data from the register array
    when(io.reg_addr.rs1_addr === 0.U) {
        io.data_read1 := 0.U
    }.otherwise {
        io.data_read1 := regs(io.reg_addr.rs1_addr)
    }
    // ---------------- Read Port 2 ----------------
    // Same logic for read port 2 (rs2)
    when(io.reg_addr.rs2_addr === 0.U) {
        io.data_read2 := 0.U
    }.otherwise {
        io.data_read2 := regs(io.reg_addr.rs2_addr)
    }
    // ---------------- Write Port ----------------
    // Write data at the rising clock edge when ctrlRegWrite is asserted and rd is not x0
    when(io.ctrlRegWrite && io.reg_addr.rd_addr =/= 0.U) {
        regs(io.reg_addr.rd_addr) := io.data_write
    }
}
