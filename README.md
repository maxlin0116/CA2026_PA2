# CA2026 PA2: RISC-V CPU in Chisel

## Versions

| Tool | Version |
|---|---|
| JDK | 17 |
| sbt | 1.8.0 (`project/build.properties`) |
| Scala | 2.13.8 |
| Chisel | 3.5.1 |
| chiseltest | 0.5.1 (treadle simulator) |

## Files

Under `src/main/scala/cpu/`:

| File | Status | Contents |
| --- | --- | --- |
| `CpuConfig.scala` | DO NOT MODIFY | `CpuConfig`, `CpuMode`, `Latency` |
| `Interfaces.scala` | DO NOT MODIFY | port bundles (memories, multiplier, core I/O) |
| `Memory.scala` | DO NOT MODIFY | `InstMemComb`, `InstMemSync`, `DataMemComb`, `DataMemHS` |
| `MulUnit.scala` | DO NOT MODIFY | 3-cycle multiplier |
| `Top.scala` | DO NOT MODIFY | builds core + memories for a configuration |
| `SingleCycleCore.scala` | you implement | single-cycle CPU |
| `PipelineCore.scala` | you implement | five-stage pipelined CPU |
| `Alu.scala`, `Decoder.scala`, `PCHandle.scala`, `Regfile.scala`, `Bundles.scala` | helpers | modify freely |

Under `src/test/`:

| Path | Status | Contents |
| --- | --- | --- |
| `scala/cpu/CoreTest.scala` | DO NOT MODIFY | testbench |
| `pattern/` | provided | A1..D2 programs, golden data memories and listings (`.txt`) |

`SingleCycleCore.scala` and `PipelineCore.scala` contain `???` so that the project compiles before you
write them. Elaborating a core that still has `???` throws `NotImplementedError`. Remove the line when you
implement the core. If you only do one of the two cores, leave the other one as it is.

## Running

One run = one configuration + one program:

```bash
sbt test                                                         # single-cycle, A1
MODE=forward LATENCY=3 INST_FILE=src/test/pattern/B1.hex GOLDEN_FILE=src/test/pattern/B1_golden.hex sbt test
MODE=stall HAS_MUL=1 LATENCY=1 sbt test
```

| Variable | Values | Default | Meaning |
|---|---|---|---|
| `MODE` | `single`, `stall`, `forward` | `single` | `SingleCycle`, `Pipelined(forwarding = false)`, `Pipelined(forwarding = true)` |
| `HAS_MUL` | `0`, `1` | `0` | `hasMul` (pipeline only) |
| `LATENCY` | integer ≥ 1 | `1` | data memory latency (pipeline only; public tests use 1 and 3) |
| `INST_FILE` | path | `src/test/pattern/A1.hex` | program |
| `GOLDEN_FILE` | path | `src/test/pattern/A1_golden.hex` | expected data memory |
| `MAX_CYCLE` | integer | `100000` | timeout |

The last line of a run is

```
[RESULT] config=forward_L3_B1 status=PASS cycles=48
```

`status` is `PASS`, `FAIL` (data memory differs from the golden file) or `TIMEOUT` (EOF was not reached
within `MAX_CYCLE` cycles). Waveforms: `test_run_dir/Top_<config>_should_match_golden_memory/Top.vcd`.

## Cycle count and end of program

- A program ends with 4 `nop`s (`00000013`) followed by the all-zero word `00000000` (EOF).
- The testbench stops in the first cycle in which the instruction memory outputs `00000000`.
  For the pipelined core this is the cycle in which EOF is in ID. The pipeline is **not** drained
  afterwards. The 4 `nop`s give the last store time to reach memory.
- The **cycle count** is the number of cycles counted from the first cycle after reset (cycle 0) up to,
  not including, that cycle. Equivalently it is the index of the cycle in which EOF appears.
  For the single-cycle core it equals the number of executed instructions.
- Correctness is checked only through the data memory. The testbench records every write performed by the
  data memory module (`peek_*` in `Top`, taken from the memory, not from your core) and compares all
  1024 words with the golden file. Registers and memory start undefined; the programs never read a
  register or a memory word before writing it.

## Pattern format

- `X.hex`: one 32-bit instruction per line, hex without `0x`. Line *i* is byte address 4*i*.
- `X_golden.hex`: one 32-bit word per line. Line *i* is data memory word *i* (byte address 4*i*).
  Missing lines are 0.

## Instruction memory

| Core | Read | Timing |
|---|---|---|
| single-cycle | combinational | `inst` belongs to `addr` of the same cycle |
| pipeline | synchronous, 1 cycle | `inst` in cycle t+1 belongs to `addr` of cycle t |

For the pipeline, the instruction at address 0 is on `inst` in cycle 0 (the first cycle after reset)
whatever address your core drives during reset; from then on `inst` in cycle t+1 belongs to the `addr`
you send in cycle t.

## Data memory of the pipelined CPU: handshake

`req.ready = !busy || resp.fire`. A fire is a cycle in which `valid && ready`.

- **Read**: request fires in cycle t, `resp.valid` first high in cycle t+L, `rdata` and `resp.valid` held
  until the response fires.
- **Write**: takes effect in the cycle in which the request fires, no response.
- At most one outstanding read; a new request can fire in the cycle in which the previous response fires.
- Your `resp.ready` must not depend combinationally on `req.ready` (that would be a combinational loop).
- Each `lw` / `sw` must send exactly one request.

> **The latency L is not a constant.** The public tests use L = 1 and L = 3, the grading tests also use
> latencies that change from one read to the next. Your core cannot see L. Always wait for `resp.valid`.

Timing diagrams (read with L = 1 and L = 3, write) are in the assignment description, section
"Data Memory (Pipelined CPU)".

## Multiplier (`hasMul = true`)

`mul rd, rs1, rs2` (funct7 `0000001`, funct3 `000`, opcode `0110011`): `rd = (rs1 * rs2)[31:0]`.
`req.ready = !busy`: it returns high in the cycle after the response fires.

Timing diagrams (result taken at once, and result held while the CPU cannot take it) are in the assignment
description, section "The `mul` Instruction".
