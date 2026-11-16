circuit Top :
  module PCHandle :
    input clock : Clock
    input reset : UInt<1>
    input io_enable : UInt<1>
    input io_jump_flag : UInt<1>
    input io_jump_addr : UInt<32>
    output io_pc : UInt<32>

    reg pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc) @[PCHandle.scala 22:21]
    node _pc_T = add(pc, UInt<3>("h4")) @[PCHandle.scala 29:22]
    node _pc_T_1 = tail(_pc_T, 1) @[PCHandle.scala 29:22]
    node _GEN_0 = mux(io_jump_flag, io_jump_addr, _pc_T_1) @[PCHandle.scala 26:28 27:16 29:16]
    node _GEN_1 = mux(io_enable, _GEN_0, pc) @[PCHandle.scala 22:21 25:21]
    io_pc <= pc @[PCHandle.scala 33:11]
    pc <= mux(reset, UInt<1>("h0"), _GEN_1) @[PCHandle.scala 22:{21,21}]

  module Decoder :
    input clock : Clock
    input reset : UInt<1>
    input io_inst : UInt<32>
    output io_ctrl_ctrlJump : UInt<1>
    output io_ctrl_ctrlBranch : UInt<1>
    output io_ctrl_ctrlRegWrite : UInt<1>
    output io_ctrl_ctrlMemRead : UInt<1>
    output io_ctrl_ctrlMemWrite : UInt<1>
    output io_ctrl_ctrlALUSrc : UInt<1>
    output io_ctrl_ctrlALUOp : UInt<5>
    output io_ctrl_ctrlMemToReg : UInt<1>
    output io_reg_addr_rs1_addr : UInt<5>
    output io_reg_addr_rs2_addr : UInt<5>
    output io_reg_addr_rd_addr : UInt<5>
    output io_imm : UInt<32>

    node opcode = bits(io_inst, 6, 0) @[Decoder.scala 24:22]
    node funct3 = bits(io_inst, 14, 12) @[Decoder.scala 25:22]
    node funct7 = bits(io_inst, 31, 25) @[Decoder.scala 26:22]
    node _io_reg_addr_rs1_addr_T = bits(io_inst, 19, 15) @[Decoder.scala 28:33]
    node _io_reg_addr_rs2_addr_T = bits(io_inst, 24, 20) @[Decoder.scala 29:33]
    node _io_reg_addr_rd_addr_T = bits(io_inst, 11, 7) @[Decoder.scala 30:33]
    node _T = eq(UInt<6>("h33"), opcode) @[Decoder.scala 35:20]
    node _T_1 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 40:28]
    node _T_2 = eq(funct7, UInt<6>("h20")) @[Decoder.scala 42:33]
    node _T_3 = eq(funct7, UInt<1>("h1")) @[Decoder.scala 44:39]
    node _GEN_0 = mux(_T_3, UInt<5>("h12"), UInt<1>("h1")) @[Decoder.scala 44:57 45:40 47:40]
    node _GEN_1 = mux(_T_2, UInt<2>("h2"), _GEN_0) @[Decoder.scala 42:51 43:40]
    node _T_4 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 40:28]
    node _T_5 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 40:28]
    node _T_6 = eq(UInt<3>("h4"), funct3) @[Decoder.scala 40:28]
    node _T_7 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 40:28]
    node _T_8 = eq(funct7, UInt<6>("h20")) @[Decoder.scala 54:33]
    node _GEN_2 = mux(_T_8, UInt<4>("h9"), UInt<4>("h8")) @[Decoder.scala 54:51 55:40 57:40]
    node _T_9 = eq(UInt<3>("h6"), funct3) @[Decoder.scala 40:28]
    node _T_10 = eq(UInt<3>("h7"), funct3) @[Decoder.scala 40:28]
    node _ctrl_WIRE_ctrlALUOp = UInt<5>("h0") @[Decoder.scala 32:{40,40}]
    node _GEN_3 = mux(_T_10, UInt<2>("h3"), _ctrl_WIRE_ctrlALUOp) @[Decoder.scala 40:28 61:47]
    node _GEN_4 = mux(_T_9, UInt<3>("h4"), _GEN_3) @[Decoder.scala 40:28 60:47]
    node _GEN_5 = mux(_T_7, _GEN_2, _GEN_4) @[Decoder.scala 40:28]
    node _GEN_6 = mux(_T_6, UInt<3>("h5"), _GEN_5) @[Decoder.scala 40:28 52:47]
    node _GEN_7 = mux(_T_5, UInt<3>("h6"), _GEN_6) @[Decoder.scala 40:28 51:47]
    node _GEN_8 = mux(_T_4, UInt<3>("h7"), _GEN_7) @[Decoder.scala 40:28 50:47]
    node _GEN_9 = mux(_T_1, _GEN_1, _GEN_8) @[Decoder.scala 40:28]
    node _T_11 = eq(UInt<5>("h13"), opcode) @[Decoder.scala 35:20]
    node _imm_T = bits(io_inst, 31, 31) @[Decoder.scala 68:37]
    node _imm_T_1 = bits(_imm_T, 0, 0) @[Bitwise.scala 74:15]
    node _imm_T_2 = mux(_imm_T_1, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_T_3 = bits(io_inst, 31, 20) @[Decoder.scala 68:48]
    node _imm_T_4 = cat(_imm_T_2, _imm_T_3) @[Cat.scala 31:58]
    node _T_12 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 69:28]
    node _T_13 = eq(UInt<2>("h2"), funct3) @[Decoder.scala 69:28]
    node _T_14 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 69:28]
    node _T_15 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 69:28]
    node _T_16 = eq(funct7, UInt<6>("h20")) @[Decoder.scala 74:33]
    node _GEN_10 = mux(_T_16, UInt<4>("h9"), UInt<4>("h8")) @[Decoder.scala 74:51 75:40 77:40]
    node _GEN_11 = mux(_T_15, _GEN_10, _ctrl_WIRE_ctrlALUOp) @[Decoder.scala 69:28]
    node _GEN_12 = mux(_T_14, UInt<3>("h7"), _GEN_11) @[Decoder.scala 69:28 72:47]
    node _GEN_13 = mux(_T_13, UInt<3>("h6"), _GEN_12) @[Decoder.scala 69:28 71:47]
    node _GEN_14 = mux(_T_12, UInt<1>("h1"), _GEN_13) @[Decoder.scala 69:28 70:47]
    node _T_17 = eq(UInt<2>("h3"), opcode) @[Decoder.scala 35:20]
    node _imm_T_5 = bits(io_inst, 31, 31) @[Decoder.scala 89:37]
    node _imm_T_6 = bits(_imm_T_5, 0, 0) @[Bitwise.scala 74:15]
    node _imm_T_7 = mux(_imm_T_6, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_T_8 = bits(io_inst, 31, 20) @[Decoder.scala 89:48]
    node _imm_T_9 = cat(_imm_T_7, _imm_T_8) @[Cat.scala 31:58]
    node _T_18 = eq(UInt<6>("h23"), opcode) @[Decoder.scala 35:20]
    node _imm_T_10 = bits(io_inst, 31, 31) @[Decoder.scala 96:37]
    node _imm_T_11 = bits(_imm_T_10, 0, 0) @[Bitwise.scala 74:15]
    node _imm_T_12 = mux(_imm_T_11, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_T_13 = bits(io_inst, 31, 25) @[Decoder.scala 96:48]
    node _imm_T_14 = bits(io_inst, 11, 7) @[Decoder.scala 96:62]
    node imm_hi = cat(_imm_T_12, _imm_T_13) @[Cat.scala 31:58]
    node _imm_T_15 = cat(imm_hi, _imm_T_14) @[Cat.scala 31:58]
    node _T_19 = eq(UInt<7>("h63"), opcode) @[Decoder.scala 35:20]
    node _imm_T_16 = bits(io_inst, 31, 31) @[Decoder.scala 102:37]
    node _imm_T_17 = bits(_imm_T_16, 0, 0) @[Bitwise.scala 74:15]
    node _imm_T_18 = mux(_imm_T_17, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_T_19 = bits(io_inst, 7, 7) @[Decoder.scala 102:48]
    node _imm_T_20 = bits(io_inst, 30, 25) @[Decoder.scala 102:57]
    node _imm_T_21 = bits(io_inst, 11, 8) @[Decoder.scala 102:71]
    node imm_lo = cat(_imm_T_21, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_hi_hi = cat(_imm_T_18, _imm_T_19) @[Cat.scala 31:58]
    node imm_hi_1 = cat(imm_hi_hi, _imm_T_20) @[Cat.scala 31:58]
    node _imm_T_22 = cat(imm_hi_1, imm_lo) @[Cat.scala 31:58]
    node _T_20 = eq(UInt<1>("h0"), funct3) @[Decoder.scala 103:28]
    node _T_21 = eq(UInt<1>("h1"), funct3) @[Decoder.scala 103:28]
    node _T_22 = eq(UInt<3>("h4"), funct3) @[Decoder.scala 103:28]
    node _T_23 = eq(UInt<3>("h5"), funct3) @[Decoder.scala 103:28]
    node _GEN_15 = mux(_T_23, UInt<4>("hd"), _ctrl_WIRE_ctrlALUOp) @[Decoder.scala 103:28 107:47]
    node _GEN_16 = mux(_T_22, UInt<4>("hc"), _GEN_15) @[Decoder.scala 103:28 106:47]
    node _GEN_17 = mux(_T_21, UInt<4>("hb"), _GEN_16) @[Decoder.scala 103:28 105:47]
    node _GEN_18 = mux(_T_20, UInt<4>("ha"), _GEN_17) @[Decoder.scala 103:28 104:47]
    node _T_24 = eq(UInt<7>("h6f"), opcode) @[Decoder.scala 35:20]
    node _imm_T_23 = bits(io_inst, 31, 31) @[Decoder.scala 115:37]
    node _imm_T_24 = bits(_imm_T_23, 0, 0) @[Bitwise.scala 74:15]
    node _imm_T_25 = mux(_imm_T_24, UInt<12>("hfff"), UInt<12>("h0")) @[Bitwise.scala 74:12]
    node _imm_T_26 = bits(io_inst, 19, 12) @[Decoder.scala 115:48]
    node _imm_T_27 = bits(io_inst, 20, 20) @[Decoder.scala 115:62]
    node _imm_T_28 = bits(io_inst, 30, 21) @[Decoder.scala 115:72]
    node imm_lo_1 = cat(_imm_T_28, UInt<1>("h0")) @[Cat.scala 31:58]
    node imm_hi_hi_1 = cat(_imm_T_25, _imm_T_26) @[Cat.scala 31:58]
    node imm_hi_2 = cat(imm_hi_hi_1, _imm_T_27) @[Cat.scala 31:58]
    node _imm_T_29 = cat(imm_hi_2, imm_lo_1) @[Cat.scala 31:58]
    node _T_25 = eq(UInt<7>("h67"), opcode) @[Decoder.scala 35:20]
    node _imm_T_30 = bits(io_inst, 31, 31) @[Decoder.scala 122:37]
    node _imm_T_31 = bits(_imm_T_30, 0, 0) @[Bitwise.scala 74:15]
    node _imm_T_32 = mux(_imm_T_31, UInt<20>("hfffff"), UInt<20>("h0")) @[Bitwise.scala 74:12]
    node _imm_T_33 = bits(io_inst, 31, 20) @[Decoder.scala 122:48]
    node _imm_T_34 = cat(_imm_T_32, _imm_T_33) @[Cat.scala 31:58]
    node _T_26 = eq(UInt<6>("h37"), opcode) @[Decoder.scala 35:20]
    node _imm_T_35 = bits(io_inst, 31, 12) @[Decoder.scala 128:28]
    node _imm_T_36 = cat(_imm_T_35, UInt<12>("h0")) @[Cat.scala 31:58]
    node _T_27 = eq(UInt<5>("h17"), opcode) @[Decoder.scala 35:20]
    node _imm_T_37 = bits(io_inst, 31, 12) @[Decoder.scala 134:28]
    node _imm_T_38 = cat(_imm_T_37, UInt<12>("h0")) @[Cat.scala 31:58]
    node _ctrl_WIRE_ctrlRegWrite = UInt<1>("h0") @[Decoder.scala 32:{40,40}]
    node _GEN_19 = mux(_T_27, UInt<1>("h1"), _ctrl_WIRE_ctrlRegWrite) @[Decoder.scala 35:20 132:31]
    node _GEN_20 = mux(_T_27, UInt<5>("h11"), _ctrl_WIRE_ctrlALUOp) @[Decoder.scala 35:20 133:31]
    node _GEN_21 = mux(_T_27, _imm_T_38, UInt<32>("h0")) @[Decoder.scala 134:17 35:20]
    node _GEN_22 = mux(_T_26, UInt<1>("h1"), _GEN_19) @[Decoder.scala 35:20 126:31]
    node _GEN_23 = mux(_T_26, UInt<5>("h10"), _GEN_20) @[Decoder.scala 35:20 127:31]
    node _GEN_24 = mux(_T_26, _imm_T_36, _GEN_21) @[Decoder.scala 128:17 35:20]
    node _ctrl_WIRE_ctrlJump = UInt<1>("h0") @[Decoder.scala 32:{40,40}]
    node _GEN_25 = mux(_T_25, UInt<1>("h1"), _ctrl_WIRE_ctrlJump) @[Decoder.scala 35:20 119:31]
    node _GEN_26 = mux(_T_25, UInt<1>("h1"), _GEN_22) @[Decoder.scala 35:20 120:31]
    node _GEN_27 = mux(_T_25, UInt<4>("hf"), _GEN_23) @[Decoder.scala 35:20 121:31]
    node _GEN_28 = mux(_T_25, _imm_T_34, _GEN_24) @[Decoder.scala 122:17 35:20]
    node _GEN_29 = mux(_T_24, UInt<1>("h1"), _GEN_25) @[Decoder.scala 35:20 112:31]
    node _GEN_30 = mux(_T_24, UInt<1>("h1"), _GEN_26) @[Decoder.scala 35:20 113:31]
    node _GEN_31 = mux(_T_24, UInt<4>("he"), _GEN_27) @[Decoder.scala 35:20 114:31]
    node _GEN_32 = mux(_T_24, _imm_T_29, _GEN_28) @[Decoder.scala 115:17 35:20]
    node _ctrl_WIRE_ctrlBranch = UInt<1>("h0") @[Decoder.scala 32:{40,40}]
    node _GEN_33 = mux(_T_19, UInt<1>("h1"), _ctrl_WIRE_ctrlBranch) @[Decoder.scala 35:20 100:29]
    node _ctrl_WIRE_ctrlALUSrc = UInt<1>("h0") @[Decoder.scala 32:{40,40}]
    node _GEN_34 = mux(_T_19, UInt<1>("h0"), _ctrl_WIRE_ctrlALUSrc) @[Decoder.scala 35:20 101:29]
    node _GEN_35 = mux(_T_19, _imm_T_22, _GEN_32) @[Decoder.scala 102:17 35:20]
    node _GEN_36 = mux(_T_19, _GEN_18, _GEN_31) @[Decoder.scala 35:20]
    node _GEN_37 = mux(_T_19, _ctrl_WIRE_ctrlJump, _GEN_29) @[Decoder.scala 35:20]
    node _GEN_38 = mux(_T_19, _ctrl_WIRE_ctrlRegWrite, _GEN_30) @[Decoder.scala 35:20]
    node _ctrl_WIRE_ctrlMemWrite = UInt<1>("h0") @[Decoder.scala 32:{40,40}]
    node _GEN_39 = mux(_T_18, UInt<1>("h1"), _ctrl_WIRE_ctrlMemWrite) @[Decoder.scala 35:20 93:31]
    node _GEN_40 = mux(_T_18, UInt<1>("h1"), _GEN_34) @[Decoder.scala 35:20 94:31]
    node _GEN_41 = mux(_T_18, UInt<1>("h1"), _GEN_36) @[Decoder.scala 35:20 95:31]
    node _GEN_42 = mux(_T_18, _imm_T_15, _GEN_35) @[Decoder.scala 35:20 96:17]
    node _GEN_43 = mux(_T_18, _ctrl_WIRE_ctrlBranch, _GEN_33) @[Decoder.scala 35:20]
    node _GEN_44 = mux(_T_18, _ctrl_WIRE_ctrlJump, _GEN_37) @[Decoder.scala 35:20]
    node _GEN_45 = mux(_T_18, _ctrl_WIRE_ctrlRegWrite, _GEN_38) @[Decoder.scala 35:20]
    node _GEN_46 = mux(_T_17, UInt<1>("h1"), _GEN_45) @[Decoder.scala 35:20 84:31]
    node _ctrl_WIRE_ctrlMemRead = UInt<1>("h0") @[Decoder.scala 32:{40,40}]
    node _GEN_47 = mux(_T_17, UInt<1>("h1"), _ctrl_WIRE_ctrlMemRead) @[Decoder.scala 35:20 85:31]
    node _ctrl_WIRE_ctrlMemToReg = UInt<1>("h0") @[Decoder.scala 32:{40,40}]
    node _GEN_48 = mux(_T_17, UInt<1>("h1"), _ctrl_WIRE_ctrlMemToReg) @[Decoder.scala 35:20 86:31]
    node _GEN_49 = mux(_T_17, UInt<1>("h1"), _GEN_40) @[Decoder.scala 35:20 87:31]
    node _GEN_50 = mux(_T_17, UInt<1>("h1"), _GEN_41) @[Decoder.scala 35:20 88:31]
    node _GEN_51 = mux(_T_17, _imm_T_9, _GEN_42) @[Decoder.scala 35:20 89:17]
    node _GEN_52 = mux(_T_17, _ctrl_WIRE_ctrlMemWrite, _GEN_39) @[Decoder.scala 35:20]
    node _GEN_53 = mux(_T_17, _ctrl_WIRE_ctrlBranch, _GEN_43) @[Decoder.scala 35:20]
    node _GEN_54 = mux(_T_17, _ctrl_WIRE_ctrlJump, _GEN_44) @[Decoder.scala 35:20]
    node _GEN_55 = mux(_T_11, UInt<1>("h1"), _GEN_46) @[Decoder.scala 35:20 66:31]
    node _GEN_56 = mux(_T_11, UInt<1>("h1"), _GEN_49) @[Decoder.scala 35:20 67:31]
    node _GEN_57 = mux(_T_11, _imm_T_4, _GEN_51) @[Decoder.scala 35:20 68:17]
    node _GEN_58 = mux(_T_11, _GEN_14, _GEN_50) @[Decoder.scala 35:20]
    node _GEN_59 = mux(_T_11, _ctrl_WIRE_ctrlMemRead, _GEN_47) @[Decoder.scala 35:20]
    node _GEN_60 = mux(_T_11, _ctrl_WIRE_ctrlMemToReg, _GEN_48) @[Decoder.scala 35:20]
    node _GEN_61 = mux(_T_11, _ctrl_WIRE_ctrlMemWrite, _GEN_52) @[Decoder.scala 35:20]
    node _GEN_62 = mux(_T_11, _ctrl_WIRE_ctrlBranch, _GEN_53) @[Decoder.scala 35:20]
    node _GEN_63 = mux(_T_11, _ctrl_WIRE_ctrlJump, _GEN_54) @[Decoder.scala 35:20]
    node _GEN_64 = mux(_T, UInt<1>("h1"), _GEN_55) @[Decoder.scala 35:20 38:31]
    node _GEN_65 = mux(_T, UInt<1>("h0"), _GEN_56) @[Decoder.scala 35:20 39:31]
    node _GEN_66 = mux(_T, _GEN_9, _GEN_58) @[Decoder.scala 35:20]
    node _GEN_67 = mux(_T, UInt<32>("h0"), _GEN_57) @[Decoder.scala 35:20]
    node _GEN_68 = mux(_T, _ctrl_WIRE_ctrlMemRead, _GEN_59) @[Decoder.scala 35:20]
    node _GEN_69 = mux(_T, _ctrl_WIRE_ctrlMemToReg, _GEN_60) @[Decoder.scala 35:20]
    node _GEN_70 = mux(_T, _ctrl_WIRE_ctrlMemWrite, _GEN_61) @[Decoder.scala 35:20]
    node _GEN_71 = mux(_T, _ctrl_WIRE_ctrlBranch, _GEN_62) @[Decoder.scala 35:20]
    node _GEN_72 = mux(_T, _ctrl_WIRE_ctrlJump, _GEN_63) @[Decoder.scala 35:20]
    node ctrl_ctrlJump = _GEN_72
    node ctrl_ctrlBranch = _GEN_71
    node ctrl_ctrlRegWrite = _GEN_64
    node ctrl_ctrlMemRead = _GEN_68
    node ctrl_ctrlMemWrite = _GEN_70
    node ctrl_ctrlALUSrc = _GEN_65
    node ctrl_ctrlALUOp = _GEN_66
    node ctrl_ctrlMemToReg = _GEN_69
    node imm = _GEN_67
    io_ctrl_ctrlJump <= ctrl_ctrlJump @[Decoder.scala 138:13]
    io_ctrl_ctrlBranch <= ctrl_ctrlBranch @[Decoder.scala 138:13]
    io_ctrl_ctrlRegWrite <= ctrl_ctrlRegWrite @[Decoder.scala 138:13]
    io_ctrl_ctrlMemRead <= ctrl_ctrlMemRead @[Decoder.scala 138:13]
    io_ctrl_ctrlMemWrite <= ctrl_ctrlMemWrite @[Decoder.scala 138:13]
    io_ctrl_ctrlALUSrc <= ctrl_ctrlALUSrc @[Decoder.scala 138:13]
    io_ctrl_ctrlALUOp <= ctrl_ctrlALUOp @[Decoder.scala 138:13]
    io_ctrl_ctrlMemToReg <= ctrl_ctrlMemToReg @[Decoder.scala 138:13]
    io_reg_addr_rs1_addr <= _io_reg_addr_rs1_addr_T @[Decoder.scala 28:26]
    io_reg_addr_rs2_addr <= _io_reg_addr_rs2_addr_T @[Decoder.scala 29:26]
    io_reg_addr_rd_addr <= _io_reg_addr_rd_addr_T @[Decoder.scala 30:26]
    io_imm <= imm @[Decoder.scala 139:13]

  module Regfile :
    input clock : Clock
    input reset : UInt<1>
    input io_ctrlRegWrite : UInt<1>
    input io_reg_addr_rs1_addr : UInt<5>
    input io_reg_addr_rs2_addr : UInt<5>
    input io_reg_addr_rd_addr : UInt<5>
    input io_data_write : UInt<32>
    output io_data_read1 : UInt<32>
    output io_data_read2 : UInt<32>

    reg regs_0 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_0) @[Regfile.scala 23:19]
    reg regs_1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_1) @[Regfile.scala 23:19]
    reg regs_2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_2) @[Regfile.scala 23:19]
    reg regs_3 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_3) @[Regfile.scala 23:19]
    reg regs_4 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_4) @[Regfile.scala 23:19]
    reg regs_5 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_5) @[Regfile.scala 23:19]
    reg regs_6 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_6) @[Regfile.scala 23:19]
    reg regs_7 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_7) @[Regfile.scala 23:19]
    reg regs_8 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_8) @[Regfile.scala 23:19]
    reg regs_9 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_9) @[Regfile.scala 23:19]
    reg regs_10 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_10) @[Regfile.scala 23:19]
    reg regs_11 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_11) @[Regfile.scala 23:19]
    reg regs_12 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_12) @[Regfile.scala 23:19]
    reg regs_13 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_13) @[Regfile.scala 23:19]
    reg regs_14 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_14) @[Regfile.scala 23:19]
    reg regs_15 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_15) @[Regfile.scala 23:19]
    reg regs_16 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_16) @[Regfile.scala 23:19]
    reg regs_17 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_17) @[Regfile.scala 23:19]
    reg regs_18 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_18) @[Regfile.scala 23:19]
    reg regs_19 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_19) @[Regfile.scala 23:19]
    reg regs_20 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_20) @[Regfile.scala 23:19]
    reg regs_21 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_21) @[Regfile.scala 23:19]
    reg regs_22 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_22) @[Regfile.scala 23:19]
    reg regs_23 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_23) @[Regfile.scala 23:19]
    reg regs_24 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_24) @[Regfile.scala 23:19]
    reg regs_25 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_25) @[Regfile.scala 23:19]
    reg regs_26 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_26) @[Regfile.scala 23:19]
    reg regs_27 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_27) @[Regfile.scala 23:19]
    reg regs_28 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_28) @[Regfile.scala 23:19]
    reg regs_29 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_29) @[Regfile.scala 23:19]
    reg regs_30 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_30) @[Regfile.scala 23:19]
    reg regs_31 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), regs_31) @[Regfile.scala 23:19]
    node _T = eq(io_reg_addr_rs1_addr, UInt<1>("h0")) @[Regfile.scala 29:31]
    node _GEN_0 = validif(eq(UInt<1>("h0"), io_reg_addr_rs1_addr), regs_0) @[Regfile.scala 32:{23,23}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), io_reg_addr_rs1_addr), regs_1, _GEN_0) @[Regfile.scala 32:{23,23}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), io_reg_addr_rs1_addr), regs_2, _GEN_1) @[Regfile.scala 32:{23,23}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), io_reg_addr_rs1_addr), regs_3, _GEN_2) @[Regfile.scala 32:{23,23}]
    node _GEN_4 = mux(eq(UInt<3>("h4"), io_reg_addr_rs1_addr), regs_4, _GEN_3) @[Regfile.scala 32:{23,23}]
    node _GEN_5 = mux(eq(UInt<3>("h5"), io_reg_addr_rs1_addr), regs_5, _GEN_4) @[Regfile.scala 32:{23,23}]
    node _GEN_6 = mux(eq(UInt<3>("h6"), io_reg_addr_rs1_addr), regs_6, _GEN_5) @[Regfile.scala 32:{23,23}]
    node _GEN_7 = mux(eq(UInt<3>("h7"), io_reg_addr_rs1_addr), regs_7, _GEN_6) @[Regfile.scala 32:{23,23}]
    node _GEN_8 = mux(eq(UInt<4>("h8"), io_reg_addr_rs1_addr), regs_8, _GEN_7) @[Regfile.scala 32:{23,23}]
    node _GEN_9 = mux(eq(UInt<4>("h9"), io_reg_addr_rs1_addr), regs_9, _GEN_8) @[Regfile.scala 32:{23,23}]
    node _GEN_10 = mux(eq(UInt<4>("ha"), io_reg_addr_rs1_addr), regs_10, _GEN_9) @[Regfile.scala 32:{23,23}]
    node _GEN_11 = mux(eq(UInt<4>("hb"), io_reg_addr_rs1_addr), regs_11, _GEN_10) @[Regfile.scala 32:{23,23}]
    node _GEN_12 = mux(eq(UInt<4>("hc"), io_reg_addr_rs1_addr), regs_12, _GEN_11) @[Regfile.scala 32:{23,23}]
    node _GEN_13 = mux(eq(UInt<4>("hd"), io_reg_addr_rs1_addr), regs_13, _GEN_12) @[Regfile.scala 32:{23,23}]
    node _GEN_14 = mux(eq(UInt<4>("he"), io_reg_addr_rs1_addr), regs_14, _GEN_13) @[Regfile.scala 32:{23,23}]
    node _GEN_15 = mux(eq(UInt<4>("hf"), io_reg_addr_rs1_addr), regs_15, _GEN_14) @[Regfile.scala 32:{23,23}]
    node _GEN_16 = mux(eq(UInt<5>("h10"), io_reg_addr_rs1_addr), regs_16, _GEN_15) @[Regfile.scala 32:{23,23}]
    node _GEN_17 = mux(eq(UInt<5>("h11"), io_reg_addr_rs1_addr), regs_17, _GEN_16) @[Regfile.scala 32:{23,23}]
    node _GEN_18 = mux(eq(UInt<5>("h12"), io_reg_addr_rs1_addr), regs_18, _GEN_17) @[Regfile.scala 32:{23,23}]
    node _GEN_19 = mux(eq(UInt<5>("h13"), io_reg_addr_rs1_addr), regs_19, _GEN_18) @[Regfile.scala 32:{23,23}]
    node _GEN_20 = mux(eq(UInt<5>("h14"), io_reg_addr_rs1_addr), regs_20, _GEN_19) @[Regfile.scala 32:{23,23}]
    node _GEN_21 = mux(eq(UInt<5>("h15"), io_reg_addr_rs1_addr), regs_21, _GEN_20) @[Regfile.scala 32:{23,23}]
    node _GEN_22 = mux(eq(UInt<5>("h16"), io_reg_addr_rs1_addr), regs_22, _GEN_21) @[Regfile.scala 32:{23,23}]
    node _GEN_23 = mux(eq(UInt<5>("h17"), io_reg_addr_rs1_addr), regs_23, _GEN_22) @[Regfile.scala 32:{23,23}]
    node _GEN_24 = mux(eq(UInt<5>("h18"), io_reg_addr_rs1_addr), regs_24, _GEN_23) @[Regfile.scala 32:{23,23}]
    node _GEN_25 = mux(eq(UInt<5>("h19"), io_reg_addr_rs1_addr), regs_25, _GEN_24) @[Regfile.scala 32:{23,23}]
    node _GEN_26 = mux(eq(UInt<5>("h1a"), io_reg_addr_rs1_addr), regs_26, _GEN_25) @[Regfile.scala 32:{23,23}]
    node _GEN_27 = mux(eq(UInt<5>("h1b"), io_reg_addr_rs1_addr), regs_27, _GEN_26) @[Regfile.scala 32:{23,23}]
    node _GEN_28 = mux(eq(UInt<5>("h1c"), io_reg_addr_rs1_addr), regs_28, _GEN_27) @[Regfile.scala 32:{23,23}]
    node _GEN_29 = mux(eq(UInt<5>("h1d"), io_reg_addr_rs1_addr), regs_29, _GEN_28) @[Regfile.scala 32:{23,23}]
    node _GEN_30 = mux(eq(UInt<5>("h1e"), io_reg_addr_rs1_addr), regs_30, _GEN_29) @[Regfile.scala 32:{23,23}]
    node _GEN_31 = mux(eq(UInt<5>("h1f"), io_reg_addr_rs1_addr), regs_31, _GEN_30) @[Regfile.scala 32:{23,23}]
    node _regs_io_reg_addr_rs1_addr = _GEN_31 @[Regfile.scala 32:23]
    node _GEN_32 = mux(_T, UInt<1>("h0"), _regs_io_reg_addr_rs1_addr) @[Regfile.scala 29:40 30:23 32:23]
    node _T_1 = eq(io_reg_addr_rs2_addr, UInt<1>("h0")) @[Regfile.scala 36:31]
    node _GEN_33 = validif(eq(UInt<1>("h0"), io_reg_addr_rs2_addr), regs_0) @[Regfile.scala 39:{23,23}]
    node _GEN_34 = mux(eq(UInt<1>("h1"), io_reg_addr_rs2_addr), regs_1, _GEN_33) @[Regfile.scala 39:{23,23}]
    node _GEN_35 = mux(eq(UInt<2>("h2"), io_reg_addr_rs2_addr), regs_2, _GEN_34) @[Regfile.scala 39:{23,23}]
    node _GEN_36 = mux(eq(UInt<2>("h3"), io_reg_addr_rs2_addr), regs_3, _GEN_35) @[Regfile.scala 39:{23,23}]
    node _GEN_37 = mux(eq(UInt<3>("h4"), io_reg_addr_rs2_addr), regs_4, _GEN_36) @[Regfile.scala 39:{23,23}]
    node _GEN_38 = mux(eq(UInt<3>("h5"), io_reg_addr_rs2_addr), regs_5, _GEN_37) @[Regfile.scala 39:{23,23}]
    node _GEN_39 = mux(eq(UInt<3>("h6"), io_reg_addr_rs2_addr), regs_6, _GEN_38) @[Regfile.scala 39:{23,23}]
    node _GEN_40 = mux(eq(UInt<3>("h7"), io_reg_addr_rs2_addr), regs_7, _GEN_39) @[Regfile.scala 39:{23,23}]
    node _GEN_41 = mux(eq(UInt<4>("h8"), io_reg_addr_rs2_addr), regs_8, _GEN_40) @[Regfile.scala 39:{23,23}]
    node _GEN_42 = mux(eq(UInt<4>("h9"), io_reg_addr_rs2_addr), regs_9, _GEN_41) @[Regfile.scala 39:{23,23}]
    node _GEN_43 = mux(eq(UInt<4>("ha"), io_reg_addr_rs2_addr), regs_10, _GEN_42) @[Regfile.scala 39:{23,23}]
    node _GEN_44 = mux(eq(UInt<4>("hb"), io_reg_addr_rs2_addr), regs_11, _GEN_43) @[Regfile.scala 39:{23,23}]
    node _GEN_45 = mux(eq(UInt<4>("hc"), io_reg_addr_rs2_addr), regs_12, _GEN_44) @[Regfile.scala 39:{23,23}]
    node _GEN_46 = mux(eq(UInt<4>("hd"), io_reg_addr_rs2_addr), regs_13, _GEN_45) @[Regfile.scala 39:{23,23}]
    node _GEN_47 = mux(eq(UInt<4>("he"), io_reg_addr_rs2_addr), regs_14, _GEN_46) @[Regfile.scala 39:{23,23}]
    node _GEN_48 = mux(eq(UInt<4>("hf"), io_reg_addr_rs2_addr), regs_15, _GEN_47) @[Regfile.scala 39:{23,23}]
    node _GEN_49 = mux(eq(UInt<5>("h10"), io_reg_addr_rs2_addr), regs_16, _GEN_48) @[Regfile.scala 39:{23,23}]
    node _GEN_50 = mux(eq(UInt<5>("h11"), io_reg_addr_rs2_addr), regs_17, _GEN_49) @[Regfile.scala 39:{23,23}]
    node _GEN_51 = mux(eq(UInt<5>("h12"), io_reg_addr_rs2_addr), regs_18, _GEN_50) @[Regfile.scala 39:{23,23}]
    node _GEN_52 = mux(eq(UInt<5>("h13"), io_reg_addr_rs2_addr), regs_19, _GEN_51) @[Regfile.scala 39:{23,23}]
    node _GEN_53 = mux(eq(UInt<5>("h14"), io_reg_addr_rs2_addr), regs_20, _GEN_52) @[Regfile.scala 39:{23,23}]
    node _GEN_54 = mux(eq(UInt<5>("h15"), io_reg_addr_rs2_addr), regs_21, _GEN_53) @[Regfile.scala 39:{23,23}]
    node _GEN_55 = mux(eq(UInt<5>("h16"), io_reg_addr_rs2_addr), regs_22, _GEN_54) @[Regfile.scala 39:{23,23}]
    node _GEN_56 = mux(eq(UInt<5>("h17"), io_reg_addr_rs2_addr), regs_23, _GEN_55) @[Regfile.scala 39:{23,23}]
    node _GEN_57 = mux(eq(UInt<5>("h18"), io_reg_addr_rs2_addr), regs_24, _GEN_56) @[Regfile.scala 39:{23,23}]
    node _GEN_58 = mux(eq(UInt<5>("h19"), io_reg_addr_rs2_addr), regs_25, _GEN_57) @[Regfile.scala 39:{23,23}]
    node _GEN_59 = mux(eq(UInt<5>("h1a"), io_reg_addr_rs2_addr), regs_26, _GEN_58) @[Regfile.scala 39:{23,23}]
    node _GEN_60 = mux(eq(UInt<5>("h1b"), io_reg_addr_rs2_addr), regs_27, _GEN_59) @[Regfile.scala 39:{23,23}]
    node _GEN_61 = mux(eq(UInt<5>("h1c"), io_reg_addr_rs2_addr), regs_28, _GEN_60) @[Regfile.scala 39:{23,23}]
    node _GEN_62 = mux(eq(UInt<5>("h1d"), io_reg_addr_rs2_addr), regs_29, _GEN_61) @[Regfile.scala 39:{23,23}]
    node _GEN_63 = mux(eq(UInt<5>("h1e"), io_reg_addr_rs2_addr), regs_30, _GEN_62) @[Regfile.scala 39:{23,23}]
    node _GEN_64 = mux(eq(UInt<5>("h1f"), io_reg_addr_rs2_addr), regs_31, _GEN_63) @[Regfile.scala 39:{23,23}]
    node _regs_io_reg_addr_rs2_addr = _GEN_64 @[Regfile.scala 39:23]
    node _GEN_65 = mux(_T_1, UInt<1>("h0"), _regs_io_reg_addr_rs2_addr) @[Regfile.scala 36:40 37:23 39:23]
    node _T_2 = neq(io_reg_addr_rd_addr, UInt<1>("h0")) @[Regfile.scala 43:49]
    node _T_3 = and(io_ctrlRegWrite, _T_2) @[Regfile.scala 43:26]
    node _regs_io_reg_addr_rd_addr = io_data_write @[Regfile.scala 44:{35,35}]
    node _GEN_66 = mux(eq(UInt<1>("h0"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_0) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_67 = mux(eq(UInt<1>("h1"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_1) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_68 = mux(eq(UInt<2>("h2"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_2) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_69 = mux(eq(UInt<2>("h3"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_3) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_70 = mux(eq(UInt<3>("h4"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_4) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_71 = mux(eq(UInt<3>("h5"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_5) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_72 = mux(eq(UInt<3>("h6"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_6) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_73 = mux(eq(UInt<3>("h7"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_7) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_74 = mux(eq(UInt<4>("h8"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_8) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_75 = mux(eq(UInt<4>("h9"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_9) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_76 = mux(eq(UInt<4>("ha"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_10) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_77 = mux(eq(UInt<4>("hb"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_11) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_78 = mux(eq(UInt<4>("hc"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_12) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_79 = mux(eq(UInt<4>("hd"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_13) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_80 = mux(eq(UInt<4>("he"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_14) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_81 = mux(eq(UInt<4>("hf"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_15) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_82 = mux(eq(UInt<5>("h10"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_16) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_83 = mux(eq(UInt<5>("h11"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_17) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_84 = mux(eq(UInt<5>("h12"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_18) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_85 = mux(eq(UInt<5>("h13"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_19) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_86 = mux(eq(UInt<5>("h14"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_20) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_87 = mux(eq(UInt<5>("h15"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_21) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_88 = mux(eq(UInt<5>("h16"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_22) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_89 = mux(eq(UInt<5>("h17"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_23) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_90 = mux(eq(UInt<5>("h18"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_24) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_91 = mux(eq(UInt<5>("h19"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_25) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_92 = mux(eq(UInt<5>("h1a"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_26) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_93 = mux(eq(UInt<5>("h1b"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_27) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_94 = mux(eq(UInt<5>("h1c"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_28) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_95 = mux(eq(UInt<5>("h1d"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_29) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_96 = mux(eq(UInt<5>("h1e"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_30) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_97 = mux(eq(UInt<5>("h1f"), io_reg_addr_rd_addr), _regs_io_reg_addr_rd_addr, regs_31) @[Regfile.scala 23:19 44:{35,35}]
    node _GEN_98 = mux(_T_3, _GEN_66, regs_0) @[Regfile.scala 23:19 43:58]
    node _GEN_99 = mux(_T_3, _GEN_67, regs_1) @[Regfile.scala 23:19 43:58]
    node _GEN_100 = mux(_T_3, _GEN_68, regs_2) @[Regfile.scala 23:19 43:58]
    node _GEN_101 = mux(_T_3, _GEN_69, regs_3) @[Regfile.scala 23:19 43:58]
    node _GEN_102 = mux(_T_3, _GEN_70, regs_4) @[Regfile.scala 23:19 43:58]
    node _GEN_103 = mux(_T_3, _GEN_71, regs_5) @[Regfile.scala 23:19 43:58]
    node _GEN_104 = mux(_T_3, _GEN_72, regs_6) @[Regfile.scala 23:19 43:58]
    node _GEN_105 = mux(_T_3, _GEN_73, regs_7) @[Regfile.scala 23:19 43:58]
    node _GEN_106 = mux(_T_3, _GEN_74, regs_8) @[Regfile.scala 23:19 43:58]
    node _GEN_107 = mux(_T_3, _GEN_75, regs_9) @[Regfile.scala 23:19 43:58]
    node _GEN_108 = mux(_T_3, _GEN_76, regs_10) @[Regfile.scala 23:19 43:58]
    node _GEN_109 = mux(_T_3, _GEN_77, regs_11) @[Regfile.scala 23:19 43:58]
    node _GEN_110 = mux(_T_3, _GEN_78, regs_12) @[Regfile.scala 23:19 43:58]
    node _GEN_111 = mux(_T_3, _GEN_79, regs_13) @[Regfile.scala 23:19 43:58]
    node _GEN_112 = mux(_T_3, _GEN_80, regs_14) @[Regfile.scala 23:19 43:58]
    node _GEN_113 = mux(_T_3, _GEN_81, regs_15) @[Regfile.scala 23:19 43:58]
    node _GEN_114 = mux(_T_3, _GEN_82, regs_16) @[Regfile.scala 23:19 43:58]
    node _GEN_115 = mux(_T_3, _GEN_83, regs_17) @[Regfile.scala 23:19 43:58]
    node _GEN_116 = mux(_T_3, _GEN_84, regs_18) @[Regfile.scala 23:19 43:58]
    node _GEN_117 = mux(_T_3, _GEN_85, regs_19) @[Regfile.scala 23:19 43:58]
    node _GEN_118 = mux(_T_3, _GEN_86, regs_20) @[Regfile.scala 23:19 43:58]
    node _GEN_119 = mux(_T_3, _GEN_87, regs_21) @[Regfile.scala 23:19 43:58]
    node _GEN_120 = mux(_T_3, _GEN_88, regs_22) @[Regfile.scala 23:19 43:58]
    node _GEN_121 = mux(_T_3, _GEN_89, regs_23) @[Regfile.scala 23:19 43:58]
    node _GEN_122 = mux(_T_3, _GEN_90, regs_24) @[Regfile.scala 23:19 43:58]
    node _GEN_123 = mux(_T_3, _GEN_91, regs_25) @[Regfile.scala 23:19 43:58]
    node _GEN_124 = mux(_T_3, _GEN_92, regs_26) @[Regfile.scala 23:19 43:58]
    node _GEN_125 = mux(_T_3, _GEN_93, regs_27) @[Regfile.scala 23:19 43:58]
    node _GEN_126 = mux(_T_3, _GEN_94, regs_28) @[Regfile.scala 23:19 43:58]
    node _GEN_127 = mux(_T_3, _GEN_95, regs_29) @[Regfile.scala 23:19 43:58]
    node _GEN_128 = mux(_T_3, _GEN_96, regs_30) @[Regfile.scala 23:19 43:58]
    node _GEN_129 = mux(_T_3, _GEN_97, regs_31) @[Regfile.scala 23:19 43:58]
    io_data_read1 <= _GEN_32
    io_data_read2 <= _GEN_65
    regs_0 <= _GEN_98
    regs_1 <= _GEN_99
    regs_2 <= _GEN_100
    regs_3 <= _GEN_101
    regs_4 <= _GEN_102
    regs_5 <= _GEN_103
    regs_6 <= _GEN_104
    regs_7 <= _GEN_105
    regs_8 <= _GEN_106
    regs_9 <= _GEN_107
    regs_10 <= _GEN_108
    regs_11 <= _GEN_109
    regs_12 <= _GEN_110
    regs_13 <= _GEN_111
    regs_14 <= _GEN_112
    regs_15 <= _GEN_113
    regs_16 <= _GEN_114
    regs_17 <= _GEN_115
    regs_18 <= _GEN_116
    regs_19 <= _GEN_117
    regs_20 <= _GEN_118
    regs_21 <= _GEN_119
    regs_22 <= _GEN_120
    regs_23 <= _GEN_121
    regs_24 <= _GEN_122
    regs_25 <= _GEN_123
    regs_26 <= _GEN_124
    regs_27 <= _GEN_125
    regs_28 <= _GEN_126
    regs_29 <= _GEN_127
    regs_30 <= _GEN_128
    regs_31 <= _GEN_129

  module Alu :
    input clock : Clock
    input reset : UInt<1>
    output io_to_branch : UInt<1>
    output io_alu_result : UInt<32>
    output io_jump_addr : UInt<32>
    input io_src_a : UInt<32>
    input io_src_b : UInt<32>
    input io_imm : UInt<32>
    input io_pc : UInt<32>
    input io_alu_op : UInt<5>

    node _T = eq(UInt<1>("h1"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T = add(io_src_a, io_src_b) @[Alu.scala 28:36]
    node _alu_result_T_1 = tail(_alu_result_T, 1) @[Alu.scala 28:36]
    node _T_1 = eq(UInt<2>("h2"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_2 = sub(io_src_a, io_src_b) @[Alu.scala 31:36]
    node _alu_result_T_3 = tail(_alu_result_T_2, 1) @[Alu.scala 31:36]
    node _T_2 = eq(UInt<2>("h3"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_4 = and(io_src_a, io_src_b) @[Alu.scala 34:36]
    node _T_3 = eq(UInt<3>("h4"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_5 = or(io_src_a, io_src_b) @[Alu.scala 37:36]
    node _T_4 = eq(UInt<3>("h5"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_6 = xor(io_src_a, io_src_b) @[Alu.scala 40:36]
    node _T_5 = eq(UInt<3>("h7"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_7 = bits(io_src_b, 4, 0) @[Alu.scala 46:47]
    node _alu_result_T_8 = dshl(io_src_a, _alu_result_T_7) @[Alu.scala 46:36]
    node _T_6 = eq(UInt<4>("h8"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_9 = bits(io_src_b, 4, 0) @[Alu.scala 49:47]
    node _alu_result_T_10 = dshr(io_src_a, _alu_result_T_9) @[Alu.scala 49:36]
    node _T_7 = eq(UInt<4>("h9"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_11 = asSInt(io_src_a) @[Alu.scala 53:37]
    node _alu_result_T_12 = bits(io_src_b, 4, 0) @[Alu.scala 53:55]
    node _alu_result_T_13 = dshr(_alu_result_T_11, _alu_result_T_12) @[Alu.scala 53:44]
    node _alu_result_T_14 = asUInt(_alu_result_T_13) @[Alu.scala 53:63]
    node _T_8 = eq(UInt<3>("h6"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_15 = asSInt(io_src_a) @[Alu.scala 59:40]
    node _alu_result_T_16 = asSInt(io_src_b) @[Alu.scala 59:58]
    node _alu_result_T_17 = lt(_alu_result_T_15, _alu_result_T_16) @[Alu.scala 59:47]
    node _alu_result_T_18 = mux(_alu_result_T_17, UInt<1>("h1"), UInt<1>("h0")) @[Alu.scala 59:30]
    node _T_9 = eq(UInt<4>("ha"), io_alu_op) @[Alu.scala 25:23]
    node _to_branch_T = eq(io_src_a, io_src_b) @[Alu.scala 65:36]
    node _jump_addr_T = add(io_pc, io_imm) @[Alu.scala 66:32]
    node _jump_addr_T_1 = tail(_jump_addr_T, 1) @[Alu.scala 66:32]
    node _T_10 = eq(UInt<4>("hb"), io_alu_op) @[Alu.scala 25:23]
    node _to_branch_T_1 = neq(io_src_a, io_src_b) @[Alu.scala 69:36]
    node _jump_addr_T_2 = add(io_pc, io_imm) @[Alu.scala 70:32]
    node _jump_addr_T_3 = tail(_jump_addr_T_2, 1) @[Alu.scala 70:32]
    node _T_11 = eq(UInt<4>("hc"), io_alu_op) @[Alu.scala 25:23]
    node _to_branch_T_2 = asSInt(io_src_a) @[Alu.scala 74:36]
    node _to_branch_T_3 = asSInt(io_src_b) @[Alu.scala 74:54]
    node _to_branch_T_4 = lt(_to_branch_T_2, _to_branch_T_3) @[Alu.scala 74:43]
    node _jump_addr_T_4 = add(io_pc, io_imm) @[Alu.scala 75:32]
    node _jump_addr_T_5 = tail(_jump_addr_T_4, 1) @[Alu.scala 75:32]
    node _T_12 = eq(UInt<4>("hd"), io_alu_op) @[Alu.scala 25:23]
    node _to_branch_T_5 = asSInt(io_src_a) @[Alu.scala 79:36]
    node _to_branch_T_6 = asSInt(io_src_b) @[Alu.scala 79:55]
    node _to_branch_T_7 = geq(_to_branch_T_5, _to_branch_T_6) @[Alu.scala 79:43]
    node _jump_addr_T_6 = add(io_pc, io_imm) @[Alu.scala 80:32]
    node _jump_addr_T_7 = tail(_jump_addr_T_6, 1) @[Alu.scala 80:32]
    node _T_13 = eq(UInt<4>("he"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_19 = add(io_pc, UInt<3>("h4")) @[Alu.scala 85:33]
    node _alu_result_T_20 = tail(_alu_result_T_19, 1) @[Alu.scala 85:33]
    node _jump_addr_T_8 = add(io_pc, io_imm) @[Alu.scala 86:33]
    node _jump_addr_T_9 = tail(_jump_addr_T_8, 1) @[Alu.scala 86:33]
    node _T_14 = eq(UInt<4>("hf"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_21 = add(io_pc, UInt<3>("h4")) @[Alu.scala 89:33]
    node _alu_result_T_22 = tail(_alu_result_T_21, 1) @[Alu.scala 89:33]
    node _jump_addr_T_10 = add(io_src_a, io_imm) @[Alu.scala 90:37]
    node _jump_addr_T_11 = tail(_jump_addr_T_10, 1) @[Alu.scala 90:37]
    node _jump_addr_T_12 = not(UInt<32>("h1")) @[Alu.scala 90:49]
    node _jump_addr_T_13 = and(_jump_addr_T_11, _jump_addr_T_12) @[Alu.scala 90:47]
    node _T_15 = eq(UInt<5>("h10"), io_alu_op) @[Alu.scala 25:23]
    node _T_16 = eq(UInt<5>("h11"), io_alu_op) @[Alu.scala 25:23]
    node _alu_result_T_23 = add(io_pc, io_imm) @[Alu.scala 98:33]
    node _alu_result_T_24 = tail(_alu_result_T_23, 1) @[Alu.scala 98:33]
    node _T_17 = eq(UInt<5>("h12"), io_alu_op) @[Alu.scala 25:23]
    node _GEN_0 = mux(_T_17, UInt<1>("h0"), UInt<32>("h0")) @[Alu.scala 25:23 103:24]
    node _GEN_1 = mux(_T_16, _alu_result_T_24, _GEN_0) @[Alu.scala 25:23 98:24]
    node _GEN_2 = mux(_T_15, io_imm, _GEN_1) @[Alu.scala 25:23 95:24]
    node _GEN_3 = mux(_T_14, _alu_result_T_22, _GEN_2) @[Alu.scala 25:23 89:24]
    node _GEN_4 = mux(_T_14, _jump_addr_T_13, UInt<32>("h0")) @[Alu.scala 25:23 90:24]
    node _GEN_5 = mux(_T_13, _alu_result_T_20, _GEN_3) @[Alu.scala 25:23 85:24]
    node _GEN_6 = mux(_T_13, _jump_addr_T_9, _GEN_4) @[Alu.scala 25:23 86:24]
    node _GEN_7 = mux(_T_12, _to_branch_T_7, UInt<1>("h0")) @[Alu.scala 25:23 79:23]
    node _GEN_8 = mux(_T_12, _jump_addr_T_7, _GEN_6) @[Alu.scala 25:23 80:23]
    node _GEN_9 = mux(_T_12, UInt<32>("h0"), _GEN_5) @[Alu.scala 25:23]
    node _GEN_10 = mux(_T_11, _to_branch_T_4, _GEN_7) @[Alu.scala 25:23 74:23]
    node _GEN_11 = mux(_T_11, _jump_addr_T_5, _GEN_8) @[Alu.scala 25:23 75:23]
    node _GEN_12 = mux(_T_11, UInt<32>("h0"), _GEN_9) @[Alu.scala 25:23]
    node _GEN_13 = mux(_T_10, _to_branch_T_1, _GEN_10) @[Alu.scala 25:23 69:23]
    node _GEN_14 = mux(_T_10, _jump_addr_T_3, _GEN_11) @[Alu.scala 25:23 70:23]
    node _GEN_15 = mux(_T_10, UInt<32>("h0"), _GEN_12) @[Alu.scala 25:23]
    node _GEN_16 = mux(_T_9, _to_branch_T, _GEN_13) @[Alu.scala 25:23 65:23]
    node _GEN_17 = mux(_T_9, _jump_addr_T_1, _GEN_14) @[Alu.scala 25:23 66:23]
    node _GEN_18 = mux(_T_9, UInt<32>("h0"), _GEN_15) @[Alu.scala 25:23]
    node _GEN_19 = mux(_T_8, _alu_result_T_18, _GEN_18) @[Alu.scala 25:23 59:24]
    node _GEN_20 = mux(_T_8, UInt<1>("h0"), _GEN_16) @[Alu.scala 25:23]
    node _GEN_21 = mux(_T_8, UInt<32>("h0"), _GEN_17) @[Alu.scala 25:23]
    node _GEN_22 = mux(_T_7, _alu_result_T_14, _GEN_19) @[Alu.scala 25:23 53:24]
    node _GEN_23 = mux(_T_7, UInt<1>("h0"), _GEN_20) @[Alu.scala 25:23]
    node _GEN_24 = mux(_T_7, UInt<32>("h0"), _GEN_21) @[Alu.scala 25:23]
    node _GEN_25 = mux(_T_6, _alu_result_T_10, _GEN_22) @[Alu.scala 25:23 49:24]
    node _GEN_26 = mux(_T_6, UInt<1>("h0"), _GEN_23) @[Alu.scala 25:23]
    node _GEN_27 = mux(_T_6, UInt<32>("h0"), _GEN_24) @[Alu.scala 25:23]
    node _GEN_28 = mux(_T_5, _alu_result_T_8, _GEN_25) @[Alu.scala 25:23 46:24]
    node _GEN_29 = mux(_T_5, UInt<1>("h0"), _GEN_26) @[Alu.scala 25:23]
    node _GEN_30 = mux(_T_5, UInt<32>("h0"), _GEN_27) @[Alu.scala 25:23]
    node _GEN_31 = mux(_T_4, _alu_result_T_6, _GEN_28) @[Alu.scala 25:23 40:24]
    node _GEN_32 = mux(_T_4, UInt<1>("h0"), _GEN_29) @[Alu.scala 25:23]
    node _GEN_33 = mux(_T_4, UInt<32>("h0"), _GEN_30) @[Alu.scala 25:23]
    node _GEN_34 = mux(_T_3, _alu_result_T_5, _GEN_31) @[Alu.scala 25:23 37:24]
    node _GEN_35 = mux(_T_3, UInt<1>("h0"), _GEN_32) @[Alu.scala 25:23]
    node _GEN_36 = mux(_T_3, UInt<32>("h0"), _GEN_33) @[Alu.scala 25:23]
    node _GEN_37 = mux(_T_2, _alu_result_T_4, _GEN_34) @[Alu.scala 25:23 34:24]
    node _GEN_38 = mux(_T_2, UInt<1>("h0"), _GEN_35) @[Alu.scala 25:23]
    node _GEN_39 = mux(_T_2, UInt<32>("h0"), _GEN_36) @[Alu.scala 25:23]
    node _GEN_40 = mux(_T_1, _alu_result_T_3, _GEN_37) @[Alu.scala 25:23 31:24]
    node _GEN_41 = mux(_T_1, UInt<1>("h0"), _GEN_38) @[Alu.scala 25:23]
    node _GEN_42 = mux(_T_1, UInt<32>("h0"), _GEN_39) @[Alu.scala 25:23]
    node _GEN_43 = mux(_T, _alu_result_T_1, _GEN_40) @[Alu.scala 25:23 28:24]
    node _GEN_44 = mux(_T, UInt<1>("h0"), _GEN_41) @[Alu.scala 25:23]
    node _GEN_45 = mux(_T, UInt<32>("h0"), _GEN_42) @[Alu.scala 25:23]
    node to_branch = _GEN_44
    node alu_result = bits(_GEN_43, 31, 0)
    node jump_addr = _GEN_45
    io_to_branch <= to_branch @[Alu.scala 109:18]
    io_alu_result <= alu_result @[Alu.scala 108:19]
    io_jump_addr <= jump_addr @[Alu.scala 110:18]

  module SingleCycleCore :
    input clock : Clock
    input reset : UInt<1>
    output io_imem_addr : UInt<32>
    input io_imem_inst : UInt<32>
    output io_dmem_ctrlMemRead : UInt<1>
    output io_dmem_ctrlMemWrite : UInt<1>
    output io_dmem_addr : UInt<32>
    output io_dmem_data_in : UInt<32>
    input io_dmem_data_out : UInt<32>

    inst pcHandle of PCHandle @[SingleCycleCore.scala 15:24]
    inst decoder of Decoder @[SingleCycleCore.scala 16:24]
    inst regfile of Regfile @[SingleCycleCore.scala 17:24]
    inst alu of Alu @[SingleCycleCore.scala 18:24]
    node _alu_io_src_b_T = mux(decoder.io_ctrl_ctrlALUSrc, decoder.io_imm, regfile.io_data_read2) @[SingleCycleCore.scala 34:23]
    node wb_data = mux(decoder.io_ctrl_ctrlMemToReg, io_dmem_data_out, alu.io_alu_result) @[SingleCycleCore.scala 44:20]
    node _pcHandle_io_jump_flag_T = and(decoder.io_ctrl_ctrlBranch, alu.io_to_branch) @[SingleCycleCore.scala 51:56]
    node _pcHandle_io_jump_flag_T_1 = or(_pcHandle_io_jump_flag_T, decoder.io_ctrl_ctrlJump) @[SingleCycleCore.scala 51:77]
    io_imem_addr <= pcHandle.io_pc @[SingleCycleCore.scala 21:21]
    io_dmem_ctrlMemRead <= decoder.io_ctrl_ctrlMemRead @[SingleCycleCore.scala 37:24]
    io_dmem_ctrlMemWrite <= decoder.io_ctrl_ctrlMemWrite @[SingleCycleCore.scala 38:24]
    io_dmem_addr <= alu.io_alu_result @[SingleCycleCore.scala 39:24]
    io_dmem_data_in <= regfile.io_data_read2 @[SingleCycleCore.scala 40:24]
    pcHandle.clock <= clock
    pcHandle.reset <= reset
    pcHandle.io_enable <= UInt<1>("h1") @[SingleCycleCore.scala 49:25]
    pcHandle.io_jump_flag <= _pcHandle_io_jump_flag_T_1 @[SingleCycleCore.scala 51:25]
    pcHandle.io_jump_addr <= alu.io_jump_addr @[SingleCycleCore.scala 52:25]
    decoder.clock <= clock
    decoder.reset <= reset
    decoder.io_inst <= io_imem_inst @[SingleCycleCore.scala 22:21]
    regfile.clock <= clock
    regfile.reset <= reset
    regfile.io_ctrlRegWrite <= decoder.io_ctrl_ctrlRegWrite @[SingleCycleCore.scala 26:27]
    regfile.io_reg_addr_rs1_addr <= decoder.io_reg_addr_rs1_addr @[SingleCycleCore.scala 25:27]
    regfile.io_reg_addr_rs2_addr <= decoder.io_reg_addr_rs2_addr @[SingleCycleCore.scala 25:27]
    regfile.io_reg_addr_rd_addr <= decoder.io_reg_addr_rd_addr @[SingleCycleCore.scala 25:27]
    regfile.io_data_write <= wb_data @[SingleCycleCore.scala 45:25]
    alu.clock <= clock
    alu.reset <= reset
    alu.io_src_a <= regfile.io_data_read1 @[SingleCycleCore.scala 32:17]
    alu.io_src_b <= _alu_io_src_b_T @[SingleCycleCore.scala 34:17]
    alu.io_imm <= decoder.io_imm @[SingleCycleCore.scala 30:17]
    alu.io_pc <= pcHandle.io_pc @[SingleCycleCore.scala 31:17]
    alu.io_alu_op <= decoder.io_ctrl_ctrlALUOp @[SingleCycleCore.scala 29:17]

  module InstMemComb :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : UInt<32>
    output io_inst : UInt<32>
    output io_pc : UInt<32>

    mem mem : @[Memory.scala 20:16]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_inst_MPORT
      read-under-write => undefined
    node _io_inst_T = shr(io_addr, 2) @[Memory.scala 23:31]
    node _io_inst_T_1 = bits(_io_inst_T, 9, 0) @[Memory.scala 23:22]
    io_inst <= mem.io_inst_MPORT.data @[Memory.scala 23:11]
    io_pc <= io_addr @[Memory.scala 24:11]
    mem.io_inst_MPORT.addr <= _io_inst_T_1 @[Memory.scala 23:22]
    mem.io_inst_MPORT.en <= UInt<1>("h1") @[Memory.scala 23:22]
    mem.io_inst_MPORT.clk <= clock @[Memory.scala 23:22]

  module DataMemComb :
    input clock : Clock
    input reset : UInt<1>
    input io_ctrlMemRead : UInt<1>
    input io_ctrlMemWrite : UInt<1>
    input io_addr : UInt<32>
    input io_data_in : UInt<32>
    output io_data_out : UInt<32>
    output io_peek_write : UInt<1>
    output io_peek_addr : UInt<32>
    output io_peek_data : UInt<32>

    mem mem : @[Memory.scala 49:18]
      data-type => UInt<32>
      depth => 1024
      read-latency => 0
      write-latency => 1
      reader => io_data_out_MPORT
      writer => MPORT
      read-under-write => undefined
    node index = shr(io_addr, 2) @[Memory.scala 50:23]
    node _T = bits(index, 9, 0)
    node _GEN_0 = validif(io_ctrlMemWrite, _T) @[Memory.scala 52:25]
    node _GEN_1 = validif(io_ctrlMemWrite, clock) @[Memory.scala 52:25]
    node _GEN_2 = mux(io_ctrlMemWrite, UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 49:18 52:25]
    node _GEN_3 = validif(io_ctrlMemWrite, UInt<1>("h1")) @[Memory.scala 52:25]
    node _GEN_4 = validif(io_ctrlMemWrite, io_data_in) @[Memory.scala 52:25]
    node _io_data_out_T = bits(index, 9, 0) @[Memory.scala 55:48]
    node _io_data_out_T_1 = mux(io_ctrlMemRead, mem.io_data_out_MPORT.data, UInt<1>("h0")) @[Memory.scala 55:23]
    io_data_out <= _io_data_out_T_1 @[Memory.scala 55:17]
    io_peek_write <= io_ctrlMemWrite @[Memory.scala 56:17]
    io_peek_addr <= io_addr @[Memory.scala 57:17]
    io_peek_data <= io_data_in @[Memory.scala 58:17]
    mem.io_data_out_MPORT.addr <= _io_data_out_T @[Memory.scala 55:48]
    mem.io_data_out_MPORT.en <= UInt<1>("h1") @[Memory.scala 55:48]
    mem.io_data_out_MPORT.clk <= clock @[Memory.scala 55:48]
    mem.MPORT.addr <= _GEN_0
    mem.MPORT.en <= _GEN_2
    mem.MPORT.clk <= _GEN_1
    mem.MPORT.data <= _GEN_4
    mem.MPORT.mask <= _GEN_3

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_pc : UInt<32>
    output io_inst : UInt<32>
    output io_peek_write : UInt<1>
    output io_peek_addr : UInt<32>
    output io_peek_data : UInt<32>

    inst core of SingleCycleCore @[Top.scala 23:24]
    inst imem of InstMemComb @[Top.scala 24:24]
    inst dmem of DataMemComb @[Top.scala 25:24]
    io_pc <= imem.io_pc @[Top.scala 36:21]
    io_inst <= imem.io_inst @[Top.scala 37:21]
    io_peek_write <= dmem.io_peek_write @[Top.scala 38:21]
    io_peek_addr <= dmem.io_peek_addr @[Top.scala 39:21]
    io_peek_data <= dmem.io_peek_data @[Top.scala 40:21]
    core.clock <= clock
    core.reset <= reset
    core.io_imem_inst <= imem.io_inst @[Top.scala 28:25]
    core.io_dmem_data_out <= dmem.io_data_out @[Top.scala 34:29]
    imem.clock <= clock
    imem.reset <= reset
    imem.io_addr <= core.io_imem_addr @[Top.scala 27:25]
    dmem.clock <= clock
    dmem.reset <= reset
    dmem.io_ctrlMemRead <= core.io_dmem_ctrlMemRead @[Top.scala 30:28]
    dmem.io_ctrlMemWrite <= core.io_dmem_ctrlMemWrite @[Top.scala 31:28]
    dmem.io_addr <= core.io_dmem_addr @[Top.scala 32:28]
    dmem.io_data_in <= core.io_dmem_data_in @[Top.scala 33:28]
