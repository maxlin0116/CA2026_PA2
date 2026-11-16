file://<WORKSPACE>/src/main/scala/cpu/Regfile.scala
### scala.reflect.internal.MissingRequirementError: object java.lang.Object in compiler mirror not found.

occurred in the presentation compiler.

presentation compiler configuration:
Scala version: 2.13.8
Classpath:
<WORKSPACE>/.bloop/root/bloop-bsp-clients-classes/classes-Metals-wrponY6HQYKbz9GV78SpCg== [exists ], <HOME>/.cache/bloop/semanticdb/com.sourcegraph.semanticdb-javac.0.12.3/semanticdb-javac-0.12.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.8/scala-library-2.13.8.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3_2.13/3.5.1/chisel3_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3-macros_2.13/3.5.1/chisel3-macros_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/chisel3-core_2.13/3.5.1/chisel3-core_2.13-3.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/scala-reflect/2.13.8/scala-reflect-2.13.8.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/lihaoyi/os-lib_2.13/0.8.0/os-lib_2.13-0.8.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/edu/berkeley/cs/firrtl_2.13/1.5.1/firrtl_2.13-1.5.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/lihaoyi/geny_2.13/0.7.0/geny_2.13-0.7.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/antlr/antlr4-runtime/4.9.3/antlr4-runtime-4.9.3.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/google/protobuf/protobuf-java/3.18.0/protobuf-java-3.18.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/scopt/scopt_2.13/3.7.1/scopt_2.13-3.7.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/net/jcazevedo/moultingyaml_2.13/0.4.2/moultingyaml_2.13-0.4.2.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-native_2.13/3.6.12/json4s-native_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-text/1.9/commons-text-1.9.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/io/github/alexarchambault/data-class_2.13/0.2.5/data-class_2.13-0.2.5.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/scala-lang/modules/scala-parallel-collections_2.13/1.0.4/scala-parallel-collections_2.13-1.0.4.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/github/nscala-time/nscala-time_2.13/2.22.0/nscala-time_2.13-2.22.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/yaml/snakeyaml/1.26/snakeyaml-1.26.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-core_2.13/3.6.12/json4s-core_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.11/commons-lang3-3.11.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/joda-time/joda-time/2.10.1/joda-time-2.10.1.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/joda/joda-convert/2.2.0/joda-convert-2.2.0.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-ast_2.13/3.6.12/json4s-ast_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/org/json4s/json4s-scalap_2.13/3.6.12/json4s-scalap_2.13-3.6.12.jar [exists ], <HOME>/.cache/coursier/v1/https/repo1.maven.org/maven2/com/thoughtworks/paranamer/paranamer/2.8/paranamer-2.8.jar [exists ]
Options:
-language:reflectiveCalls -deprecation -unchecked -feature -Xcheckinit -Yrangepos -Xplugin-require:semanticdb -release 17


action parameters:
uri: file://<WORKSPACE>/src/main/scala/cpu/Regfile.scala
text:
```scala
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