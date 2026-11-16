package cpu

import chisel3._
import chisel3.util._

/// DO NOT MODIFY THIS FILE ///
// Multiplier for the `mul` instruction (low 32 bits of rs1 * rs2).
//   cycle t   : req fires, a and b are sampled
//   cycle t+1 : busy, resp.valid = 0
//   cycle t+2 : resp.valid = 1, result held until resp fires
//   req.ready = !busy, so it returns high in the cycle after resp fires
class MulUnit extends Module {
  val io = IO(new Bundle {
    val req  = Flipped(Decoupled(new MulReq))
    val resp = Decoupled(new MulResp)
  })
  val Cycles = 3

  val busy   = RegInit(false.B)
  val cnt    = RegInit(0.U(4.W))   // cycles left until resp.valid
  val result = Reg(UInt(32.W))

  io.req.ready        := !busy
  io.resp.valid       := busy && cnt === 0.U
  io.resp.bits.result := result

  when(io.req.fire) {
    busy   := true.B
    cnt    := (Cycles - 2).U
    result := (io.req.bits.a * io.req.bits.b)(31, 0)
  }.elsewhen(io.resp.fire) {
    busy := false.B
  }.elsewhen(busy && cnt =/= 0.U) {
    cnt := cnt - 1.U
  }
}
