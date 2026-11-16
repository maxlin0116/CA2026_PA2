file://<WORKSPACE>/src/main/scala/cpu/PipelineCore.scala
### scala.reflect.internal.MissingRequirementError: object java.lang.Object in compiler mirror not found.

occurred in the presentation compiler.

presentation compiler configuration:
Scala version: 2.13.8
Classpath:
<WORKSPACE>/.bloop/root/bloop-bsp-clients-classes/classes-Metals-C7mmXuyfRKi7TC8hak1Dag== [exists ], <HOME>/.cache/bloop/semanticdb/com.sourcegraph.semanticdb-javac.0.12.3/semanticdb-javac-0.12.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.8/scala-library-2.13.8.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3_2.13/3.5.1/chisel3_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3-macros_2.13/3.5.1/chisel3-macros_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3-core_2.13/3.5.1/chisel3-core_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.8/scala-reflect-2.13.8.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.8.0/os-lib_2.13-0.8.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/firrtl_2.13/1.5.1/firrtl_2.13-1.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/lihaoyi/geny_2.13/0.7.0/geny_2.13-0.7.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.9.3/antlr4-runtime-4.9.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.18.0/protobuf-java-3.18.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/scopt/scopt_2.13/3.7.1/scopt_2.13-3.7.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/net/jcazevedo/moultingyaml_2.13/0.4.2/moultingyaml_2.13-0.4.2.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-native_2.13/3.6.12/json4s-native_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-text/1.9/commons-text-1.9.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/io/github/alexarchambault/data-class_2.13/0.2.5/data-class_2.13-0.2.5.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/1.0.4/scala-parallel-collections_2.13-1.0.4.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/nscala-time/nscala-time_2.13/2.22.0/nscala-time_2.13-2.22.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/yaml/snakeyaml/1.26/snakeyaml-1.26.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-core_2.13/3.6.12/json4s-core_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.11/commons-lang3-3.11.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/joda-time/joda-time/2.10.1/joda-time-2.10.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/joda/joda-convert/2.2.0/joda-convert-2.2.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-ast_2.13/3.6.12/json4s-ast_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-scalap_2.13/3.6.12/json4s-scalap_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.jar [exists ]
Options:
-language:reflectiveCalls -deprecation -unchecked -feature -Xcheckinit -Yrangepos -Xplugin-require:semanticdb -release 17


action parameters:
offset: 634
uri: file://<WORKSPACE>/src/main/scala/cpu/PipelineCore.scala
text:
```scala
package cpu

import chisel3._
import chisel3.util._
import cpu.OP_TYPES._

// Five-stage pipelined RV32I core. One source file for every pipelined configuration:
//   forwarding : Scala Boolean, use `if (forwarding)` (not `when`) to choose the hardware
//   hasMul     : Scala Boolean, true when `mul` is supported; then io.mul exists (io.mul.get)
// The I/O is fixed (Top connects to it, see Interfaces.scala):
//   io.imem : instruction memory, one-cycle synchronous read
//             (the address you send in cycle t is the instruction you get in cycle t+1;
//              in the first cycle after reset you always get the instr@@uction at address 0)
//   io.dmem : data memory with valid/ready handshake, latency NOT fixed
//   io.mul  : multiplier with valid/ready handshake (only when hasMul)
class PipelineCore(forwarding: Boolean, hasMul: Boolean) extends Module {
  val io = IO(new PipelineCoreIO(hasMul))

  // ---------------- Submodules ----------------
  val decoder = Module(new Decoder)
  val regfile = Module(new Regfile)
  val alu     = Module(new Alu)

  // ---------------- Pipeline Registers ----------------
  val reg_IF_ID  = RegInit(0.U.asTypeOf(new IF_ID))
  val reg_ID_EX  = RegInit(0.U.asTypeOf(new ID_EX))
  val reg_EX_MEM = RegInit(0.U.asTypeOf(new EX_MEM))
  val reg_MEM_WB = RegInit(0.U.asTypeOf(new MEM_WB))

  // ---------------- Stall & Flush Signals ----------------
  val stall_IF  = Wire(Bool())
  val stall_ID  = Wire(Bool())
  val stall_EX  = Wire(Bool())
  val stall_MEM = Wire(Bool())

  val flush_IF_ID = Wire(Bool())
  val flush_ID_EX = Wire(Bool())

  // =========================================================================
  // 1. Instruction Fetch Stage (IF)
  // =========================================================================
  val pc_IF = RegInit(0.U(32.W))

  val jump_flag = Wire(Bool())
  val jump_addr = Wire(UInt(32.W))

  when(jump_flag) {
    pc_IF        := jump_addr
    io.imem.addr := jump_addr
  }.elsewhen(stall_IF) {
    pc_IF        := pc_IF
    io.imem.addr := pc_IF
  }.otherwise {
    pc_IF        := pc_IF + 4.U
    io.imem.addr := pc_IF + 4.U
  }

  // IF/ID Pipeline Register Update
  when(flush_IF_ID) {
    reg_IF_ID := 0.U.asTypeOf(new IF_ID)
  }.elsewhen(!stall_ID) {
    reg_IF_ID.pc    := pc_IF
    reg_IF_ID.inst  := io.imem.inst
    reg_IF_ID.valid := true.B
  }

  // =========================================================================
  // 2. Instruction Decode Stage (ID)
  // =========================================================================
  decoder.io.inst := reg_IF_ID.inst

  // Read register file
  regfile.io.reg_addr.rs1_addr := decoder.io.reg_addr.rs1_addr
  regfile.io.reg_addr.rs2_addr := decoder.io.reg_addr.rs2_addr

  val id_rs1 = decoder.io.reg_addr.rs1_addr
  val id_rs2 = decoder.io.reg_addr.rs2_addr
  val id_opcode = reg_IF_ID.inst(6, 0)

  // Identify whether rs1 and rs2 are read by the current instruction
  val id_rs1_used = reg_IF_ID.valid && !(id_opcode === "b0110111".U || id_opcode === "b0010111".U || id_opcode === "b1101111".U)
  val id_rs2_used = reg_IF_ID.valid && (id_opcode === "b0110011".U || decoder.io.ctrl.ctrlMemWrite || decoder.io.ctrl.ctrlBranch)

  // Hazard Detection Unit in ID stage
  val stall_hazard = WireDefault(false.B)

  if (forwarding) {
    // Load-Use Hazard Detection:
    // If instruction in EX is a load, and its destination matches rs1 or rs2 in ID
    val ex_is_load = reg_ID_EX.valid && reg_ID_EX.ctrl.ctrlMemRead && (reg_ID_EX.rd_addr =/= 0.U)
    val load_use_hazard = ex_is_load && ((id_rs1_used && reg_ID_EX.rd_addr === id_rs1) || (id_rs2_used && reg_ID_EX.rd_addr === id_rs2))
    when(load_use_hazard) {
      stall_hazard := true.B
    }
  } else {
    // Stall-only mode: stall on any RAW dependency in EX, MEM, or WB
    val ex_hazard  = reg_ID_EX.valid && reg_ID_EX.ctrl.ctrlRegWrite && (reg_ID_EX.rd_addr =/= 0.U) &&
                     ((id_rs1_used && reg_ID_EX.rd_addr === id_rs1) || (id_rs2_used && reg_ID_EX.rd_addr === id_rs2))
    val mem_hazard = reg_EX_MEM.valid && reg_EX_MEM.ctrl.ctrlRegWrite && (reg_EX_MEM.rd_addr =/= 0.U) &&
                     ((id_rs1_used && reg_EX_MEM.rd_addr === id_rs1) || (id_rs2_used && reg_EX_MEM.rd_addr === id_rs2))
    val wb_hazard  = reg_MEM_WB.valid && reg_MEM_WB.ctrl.ctrlRegWrite && (reg_MEM_WB.rd_addr =/= 0.U) &&
                     ((id_rs1_used && reg_MEM_WB.rd_addr === id_rs1) || (id_rs2_used && reg_MEM_WB.rd_addr === id_rs2))
    when(ex_hazard || mem_hazard || wb_hazard) {
      stall_hazard := true.B
    }
  }

  // ID/EX Pipeline Register Update
  when(flush_ID_EX) {
    reg_ID_EX := 0.U.asTypeOf(new ID_EX)
  }.elsewhen(!stall_EX) {
    when(stall_hazard || !reg_IF_ID.valid) {
      reg_ID_EX := 0.U.asTypeOf(new ID_EX)
    }.otherwise {
      reg_ID_EX.pc       := reg_IF_ID.pc
      reg_ID_EX.inst     := reg_IF_ID.inst
      reg_ID_EX.ctrl     := decoder.io.ctrl
      reg_ID_EX.rs1_addr := id_rs1
      reg_ID_EX.rs2_addr := id_rs2
      reg_ID_EX.rd_addr  := decoder.io.reg_addr.rd_addr
      reg_ID_EX.rdata1   := regfile.io.data_read1
      reg_ID_EX.rdata2   := regfile.io.data_read2
      reg_ID_EX.imm      := decoder.io.imm
      reg_ID_EX.valid    := true.B
    }
  }

  // =========================================================================
  // 3. Execution Stage (EX)
  // =========================================================================
  val forward_a = WireDefault(reg_ID_EX.rdata1)
  val forward_b = WireDefault(reg_ID_EX.rdata2)

  val wb_data = Wire(UInt(32.W)) // Defined in WB stage

  if (forwarding) {
    // Forwarding to operand A (rs1)
    when(reg_EX_MEM.valid && reg_EX_MEM.ctrl.ctrlRegWrite && (reg_EX_MEM.rd_addr =/= 0.U) && (reg_EX_MEM.rd_addr === reg_ID_EX.rs1_addr)) {
      forward_a := Mux(reg_EX_MEM.ctrl.ctrlMemToReg, io.dmem.resp.bits.rdata, reg_EX_MEM.alu_result)
    }.elsewhen(reg_MEM_WB.valid && reg_MEM_WB.ctrl.ctrlRegWrite && (reg_MEM_WB.rd_addr =/= 0.U) && (reg_MEM_WB.rd_addr === reg_ID_EX.rs1_addr)) {
      forward_a := wb_data
    }

    // Forwarding to operand B (rs2)
    when(reg_EX_MEM.valid && reg_EX_MEM.ctrl.ctrlRegWrite && (reg_EX_MEM.rd_addr =/= 0.U) && (reg_EX_MEM.rd_addr === reg_ID_EX.rs2_addr)) {
      forward_b := Mux(reg_EX_MEM.ctrl.ctrlMemToReg, io.dmem.resp.bits.rdata, reg_EX_MEM.alu_result)
    }.elsewhen(reg_MEM_WB.valid && reg_MEM_WB.ctrl.ctrlRegWrite && (reg_MEM_WB.rd_addr =/= 0.U) && (reg_MEM_WB.rd_addr === reg_ID_EX.rs2_addr)) {
      forward_b := wb_data
    }
  }

  alu.io.alu_op := reg_ID_EX.ctrl.ctrlALUOp
  alu.io.imm    := reg_ID_EX.imm
  alu.io.pc     := reg_ID_EX.pc
  alu.io.src_a  := forward_a
  alu.io.src_b  := Mux(reg_ID_EX.ctrl.ctrlALUSrc, reg_ID_EX.imm, forward_b)

  // Branch and Jump Resolution in EX
  val ex_is_jump   = reg_ID_EX.valid && reg_ID_EX.ctrl.ctrlJump
  val ex_is_branch = reg_ID_EX.valid && reg_ID_EX.ctrl.ctrlBranch && alu.io.to_branch
  jump_flag := (ex_is_jump || ex_is_branch) && !stall_MEM
  jump_addr := alu.io.jump_addr

  // Data Memory Request in EX
  val dmem_req_fired = RegInit(false.B)
  val is_dmem_op = reg_ID_EX.valid && (reg_ID_EX.ctrl.ctrlMemRead || reg_ID_EX.ctrl.ctrlMemWrite)

  io.dmem.req.valid     := is_dmem_op && !dmem_req_fired
  io.dmem.req.bits.addr := alu.io.alu_result
  io.dmem.req.bits.wdata:= forward_b
  io.dmem.req.bits.wen  := reg_ID_EX.ctrl.ctrlMemWrite

  when(io.dmem.req.fire) {
    dmem_req_fired := true.B
  }
  when(!stall_EX) {
    dmem_req_fired := false.B
  }

  // Multiplier Unit in EX (if hasMul)
  val is_mul = reg_ID_EX.valid && (reg_ID_EX.ctrl.ctrlALUOp === OP_MUL)
  val mul_result = WireDefault(0.U(32.W))
  val stall_mul  = WireDefault(false.B)

  if (hasMul) {
    val mul_req_fired = RegInit(false.B)
    val mul = io.mul.get

    mul.req.valid  := is_mul && !mul_req_fired
    mul.req.bits.a := forward_a
    mul.req.bits.b := forward_b
    mul.resp.ready := true.B

    when(mul.req.fire) {
      mul_req_fired := true.B
    }
    when(!stall_EX) {
      mul_req_fired := false.B
    }

    when(is_mul) {
      when(mul.resp.fire) {
        mul_result := mul.resp.bits.result
        stall_mul  := false.B
      }.otherwise {
        stall_mul  := true.B
      }
    }
  }

  val stall_dmem_req    = is_dmem_op && !dmem_req_fired && !io.dmem.req.ready
  val stall_EX_internal = stall_dmem_req || stall_mul

  // EX/MEM Pipeline Register Update
  when(!stall_MEM) {
    when(stall_EX_internal || !reg_ID_EX.valid) {
      reg_EX_MEM := 0.U.asTypeOf(new EX_MEM)
    }.otherwise {
      reg_EX_MEM.ctrl       := reg_ID_EX.ctrl
      reg_EX_MEM.rd_addr    := reg_ID_EX.rd_addr
      reg_EX_MEM.alu_result := Mux(is_mul, mul_result, alu.io.alu_result)
      reg_EX_MEM.wdata      := forward_b
      reg_EX_MEM.valid      := true.B
    }
  }

  // =========================================================================
  // 4. Memory Access Stage (MEM)
  // =========================================================================
  val is_mem_read = reg_EX_MEM.valid && reg_EX_MEM.ctrl.ctrlMemRead

  io.dmem.resp.ready := true.B

  stall_MEM := is_mem_read && !io.dmem.resp.valid
  stall_EX  := stall_MEM || stall_EX_internal
  stall_ID  := stall_EX  || stall_hazard
  stall_IF  := stall_ID

  flush_IF_ID := jump_flag
  flush_ID_EX := jump_flag

  // MEM/WB Pipeline Register Update
  when(stall_MEM) {
    reg_MEM_WB := 0.U.asTypeOf(new MEM_WB)
  }.otherwise {
    reg_MEM_WB.ctrl       := reg_EX_MEM.ctrl
    reg_MEM_WB.rd_addr    := reg_EX_MEM.rd_addr
    reg_MEM_WB.alu_result := reg_EX_MEM.alu_result
    reg_MEM_WB.rdata      := io.dmem.resp.bits.rdata
    reg_MEM_WB.valid      := reg_EX_MEM.valid
  }

  // =========================================================================
  // 5. Write Back Stage (WB)
  // =========================================================================
  wb_data := Mux(reg_MEM_WB.ctrl.ctrlMemToReg, reg_MEM_WB.rdata, reg_MEM_WB.alu_result)

  regfile.io.ctrlRegWrite     := reg_MEM_WB.valid && reg_MEM_WB.ctrl.ctrlRegWrite
  regfile.io.reg_addr.rd_addr := reg_MEM_WB.rd_addr
  regfile.io.data_write       := wb_data
}
```



#### Error stacktrace:

```
scala.reflect.internal.MissingRequirementError$.notFound(MissingRequirementError.scala:24)
	scala.reflect.internal.Mirrors$RootsBase.$anonfun$getModuleOrClass$6(Mirrors.scala:63)
	scala.reflect.internal.Mirrors$RootsBase.getModuleOrClass(Mirrors.scala:63)
	scala.reflect.internal.Mirrors$RootsBase.getModuleOrClass(Mirrors.scala:55)
	scala.reflect.internal.Mirrors$RootsBase.getRequiredClass(Mirrors.scala:55)
	scala.reflect.internal.Definitions$DefinitionsClass.ObjectClass$lzycompute(Definitions.scala:293)
	scala.reflect.internal.Definitions$DefinitionsClass.ObjectClass(Definitions.scala:293)
	scala.reflect.internal.Definitions$DefinitionsClass.init(Definitions.scala:1654)
	scala.tools.nsc.Global$Run.<init>(Global.scala:1249)
	scala.tools.nsc.interactive.Global$TyperRun.<init>(Global.scala:1352)
	scala.tools.nsc.interactive.Global.newTyperRun(Global.scala:1375)
	scala.tools.nsc.interactive.Global.<init>(Global.scala:294)
	scala.meta.internal.pc.MetalsGlobal.<init>(MetalsGlobal.scala:42)
	scala.meta.internal.pc.ScalaPresentationCompiler.newCompiler(ScalaPresentationCompiler.scala:514)
```
#### Short summary: 

scala.reflect.internal.MissingRequirementError: object java.lang.Object in compiler mirror not found.