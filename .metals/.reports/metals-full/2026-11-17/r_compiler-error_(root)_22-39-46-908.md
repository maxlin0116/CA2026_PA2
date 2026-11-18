file://<WORKSPACE>/src/main/scala/cpu/SingleCycleCore.scala
### scala.reflect.internal.MissingRequirementError: object java.lang.Object in compiler mirror not found.

occurred in the presentation compiler.

presentation compiler configuration:
Scala version: 2.13.8
Classpath:
<WORKSPACE>/.bloop/root/bloop-bsp-clients-classes/classes-Metals-vmjDlM75QPiwUH9y41XNgw== [exists ], <HOME>/.cache/bloop/semanticdb/com.sourcegraph.semanticdb-javac.0.12.3/semanticdb-javac-0.12.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.8/scala-library-2.13.8.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3_2.13/3.5.1/chisel3_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3-macros_2.13/3.5.1/chisel3-macros_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3-core_2.13/3.5.1/chisel3-core_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.8/scala-reflect-2.13.8.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.8.0/os-lib_2.13-0.8.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/firrtl_2.13/1.5.1/firrtl_2.13-1.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/lihaoyi/geny_2.13/0.7.0/geny_2.13-0.7.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.9.3/antlr4-runtime-4.9.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.18.0/protobuf-java-3.18.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/scopt/scopt_2.13/3.7.1/scopt_2.13-3.7.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/net/jcazevedo/moultingyaml_2.13/0.4.2/moultingyaml_2.13-0.4.2.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-native_2.13/3.6.12/json4s-native_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-text/1.9/commons-text-1.9.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/io/github/alexarchambault/data-class_2.13/0.2.5/data-class_2.13-0.2.5.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/1.0.4/scala-parallel-collections_2.13-1.0.4.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/nscala-time/nscala-time_2.13/2.22.0/nscala-time_2.13-2.22.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/yaml/snakeyaml/1.26/snakeyaml-1.26.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-core_2.13/3.6.12/json4s-core_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.11/commons-lang3-3.11.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/joda-time/joda-time/2.10.1/joda-time-2.10.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/joda/joda-convert/2.2.0/joda-convert-2.2.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-ast_2.13/3.6.12/json4s-ast_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-scalap_2.13/3.6.12/json4s-scalap_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.jar [exists ]
Options:
-language:reflectiveCalls -deprecation -unchecked -feature -Xcheckinit -Yrangepos -Xplugin-require:semanticdb -release 17


action parameters:
offset: 462
uri: file://<WORKSPACE>/src/main/scala/cpu/SingleCycleCore.scala
text:
```scala
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

  // 1. Instantiat@@e submodules
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