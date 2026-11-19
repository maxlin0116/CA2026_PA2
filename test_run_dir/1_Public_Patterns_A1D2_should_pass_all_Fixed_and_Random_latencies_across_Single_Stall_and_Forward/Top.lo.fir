circuit Top :
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

  module PipelineCore :
    input clock : Clock
    input reset : UInt<1>
    output io_imem_addr : UInt<32>
    input io_imem_inst : UInt<32>
    input io_dmem_req_ready : UInt<1>
    output io_dmem_req_valid : UInt<1>
    output io_dmem_req_bits_addr : UInt<32>
    output io_dmem_req_bits_wdata : UInt<32>
    output io_dmem_req_bits_wen : UInt<1>
    output io_dmem_resp_ready : UInt<1>
    input io_dmem_resp_valid : UInt<1>
    input io_dmem_resp_bits_rdata : UInt<32>
    input io_mul_req_ready : UInt<1>
    output io_mul_req_valid : UInt<1>
    output io_mul_req_bits_a : UInt<32>
    output io_mul_req_bits_b : UInt<32>
    output io_mul_resp_ready : UInt<1>
    input io_mul_resp_valid : UInt<1>
    input io_mul_resp_bits_result : UInt<32>

    inst decoder of Decoder @[PipelineCore.scala 20:23]
    inst regfile of Regfile @[PipelineCore.scala 21:23]
    inst alu of Alu @[PipelineCore.scala 22:23]
    reg reg_IF_ID_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_IF_ID_pc) @[PipelineCore.scala 25:27]
    reg reg_IF_ID_inst : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_IF_ID_inst) @[PipelineCore.scala 25:27]
    reg reg_IF_ID_valid : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_IF_ID_valid) @[PipelineCore.scala 25:27]
    reg reg_ID_EX_pc : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_pc) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_inst : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_inst) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_ctrl_ctrlJump : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_ctrl_ctrlJump) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_ctrl_ctrlBranch : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_ctrl_ctrlBranch) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_ctrl_ctrlRegWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_ctrl_ctrlRegWrite) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_ctrl_ctrlMemRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_ctrl_ctrlMemRead) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_ctrl_ctrlMemWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_ctrl_ctrlMemWrite) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_ctrl_ctrlALUSrc : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_ctrl_ctrlALUSrc) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_ctrl_ctrlALUOp : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_ctrl_ctrlALUOp) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_ctrl_ctrlMemToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_ctrl_ctrlMemToReg) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_rs1_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_rs1_addr) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_rs2_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_rs2_addr) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_rd_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_rd_addr) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_rdata1 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_rdata1) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_rdata2 : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_rdata2) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_imm : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_imm) @[PipelineCore.scala 26:27]
    reg reg_ID_EX_valid : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_ID_EX_valid) @[PipelineCore.scala 26:27]
    reg reg_EX_MEM_ctrl_ctrlJump : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_ctrl_ctrlJump) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_ctrl_ctrlBranch : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_ctrl_ctrlBranch) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_ctrl_ctrlRegWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_ctrl_ctrlRegWrite) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_ctrl_ctrlMemRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_ctrl_ctrlMemRead) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_ctrl_ctrlMemWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_ctrl_ctrlMemWrite) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_ctrl_ctrlALUSrc : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_ctrl_ctrlALUSrc) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_ctrl_ctrlALUOp : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_ctrl_ctrlALUOp) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_ctrl_ctrlMemToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_ctrl_ctrlMemToReg) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_rd_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_rd_addr) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_alu_result : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_alu_result) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_wdata : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_wdata) @[PipelineCore.scala 27:27]
    reg reg_EX_MEM_valid : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_EX_MEM_valid) @[PipelineCore.scala 27:27]
    reg reg_MEM_WB_ctrl_ctrlJump : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_ctrl_ctrlJump) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_ctrl_ctrlBranch : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_ctrl_ctrlBranch) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_ctrl_ctrlRegWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_ctrl_ctrlRegWrite) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_ctrl_ctrlMemRead : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_ctrl_ctrlMemRead) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_ctrl_ctrlMemWrite : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_ctrl_ctrlMemWrite) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_ctrl_ctrlALUSrc : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_ctrl_ctrlALUSrc) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_ctrl_ctrlALUOp : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_ctrl_ctrlALUOp) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_ctrl_ctrlMemToReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_ctrl_ctrlMemToReg) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_rd_addr : UInt<5>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_rd_addr) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_alu_result : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_alu_result) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_rdata : UInt<32>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_rdata) @[PipelineCore.scala 28:27]
    reg reg_MEM_WB_valid : UInt<1>, clock with :
      reset => (UInt<1>("h0"), reg_MEM_WB_valid) @[PipelineCore.scala 28:27]
    reg pc_IF : UInt<32>, clock with :
      reset => (UInt<1>("h0"), pc_IF) @[PipelineCore.scala 42:22]
    node _pc_IF_T = add(pc_IF, UInt<3>("h4")) @[PipelineCore.scala 54:27]
    node _pc_IF_T_1 = tail(_pc_IF_T, 1) @[PipelineCore.scala 54:27]
    node _io_imem_addr_T = add(pc_IF, UInt<3>("h4")) @[PipelineCore.scala 55:27]
    node _io_imem_addr_T_1 = tail(_io_imem_addr_T, 1) @[PipelineCore.scala 55:27]
    node is_mem_read = and(reg_EX_MEM_valid, reg_EX_MEM_ctrl_ctrlMemRead) @[PipelineCore.scala 248:38]
    node _stall_MEM_T = eq(io_dmem_resp_valid, UInt<1>("h0")) @[PipelineCore.scala 252:31]
    node _stall_MEM_T_1 = and(is_mem_read, _stall_MEM_T) @[PipelineCore.scala 252:28]
    node stall_MEM = _stall_MEM_T_1 @[PipelineCore.scala 252:13 34:23]
    node _is_dmem_op_T = or(reg_ID_EX_ctrl_ctrlMemRead, reg_ID_EX_ctrl_ctrlMemWrite) @[PipelineCore.scala 184:67]
    node is_dmem_op = and(reg_ID_EX_valid, _is_dmem_op_T) @[PipelineCore.scala 184:36]
    reg dmem_req_fired : UInt<1>, clock with :
      reset => (UInt<1>("h0"), dmem_req_fired) @[PipelineCore.scala 183:31]
    node _stall_dmem_req_T = eq(dmem_req_fired, UInt<1>("h0")) @[PipelineCore.scala 229:41]
    node _stall_dmem_req_T_1 = and(is_dmem_op, _stall_dmem_req_T) @[PipelineCore.scala 229:38]
    node _stall_dmem_req_T_2 = eq(io_dmem_req_ready, UInt<1>("h0")) @[PipelineCore.scala 229:60]
    node stall_dmem_req = and(_stall_dmem_req_T_1, _stall_dmem_req_T_2) @[PipelineCore.scala 229:57]
    node _is_mul_T = eq(reg_ID_EX_ctrl_ctrlALUOp, UInt<5>("h12")) @[PipelineCore.scala 199:61]
    node is_mul = and(reg_ID_EX_valid, _is_mul_T) @[PipelineCore.scala 199:32]
    node _T_40 = and(io_mul_resp_ready, io_mul_resp_valid) @[Decoupled.scala 50:35]
    node _GEN_75 = mux(_T_40, UInt<1>("h0"), UInt<1>("h1")) @[PipelineCore.scala 220:27 222:20 224:20]
    node _GEN_77 = mux(is_mul, _GEN_75, UInt<1>("h0")) @[PipelineCore.scala 219:18]
    node stall_mul = _GEN_77
    node stall_EX_internal = or(stall_dmem_req, stall_mul) @[PipelineCore.scala 230:42]
    node _stall_EX_T = or(stall_MEM, stall_EX_internal) @[PipelineCore.scala 253:26]
    node stall_EX = _stall_EX_T @[PipelineCore.scala 253:13 33:23]
    node _ex_is_load_T = and(reg_ID_EX_valid, reg_ID_EX_ctrl_ctrlMemRead) @[PipelineCore.scala 90:38]
    node _ex_is_load_T_1 = neq(reg_ID_EX_rd_addr, UInt<1>("h0")) @[PipelineCore.scala 90:90]
    node ex_is_load = and(_ex_is_load_T, _ex_is_load_T_1) @[PipelineCore.scala 90:68]
    node id_opcode = bits(reg_IF_ID_inst, 6, 0) @[PipelineCore.scala 78:33]
    node _id_rs1_used_T = eq(id_opcode, UInt<6>("h37")) @[PipelineCore.scala 81:52]
    node _id_rs1_used_T_1 = eq(id_opcode, UInt<5>("h17")) @[PipelineCore.scala 81:82]
    node _id_rs1_used_T_2 = or(_id_rs1_used_T, _id_rs1_used_T_1) @[PipelineCore.scala 81:69]
    node _id_rs1_used_T_3 = eq(id_opcode, UInt<7>("h6f")) @[PipelineCore.scala 81:112]
    node _id_rs1_used_T_4 = or(_id_rs1_used_T_2, _id_rs1_used_T_3) @[PipelineCore.scala 81:99]
    node _id_rs1_used_T_5 = eq(_id_rs1_used_T_4, UInt<1>("h0")) @[PipelineCore.scala 81:40]
    node id_rs1_used = and(reg_IF_ID_valid, _id_rs1_used_T_5) @[PipelineCore.scala 81:37]
    node _load_use_hazard_T = eq(reg_ID_EX_rd_addr, decoder.io_reg_addr_rs1_addr) @[PipelineCore.scala 91:76]
    node _load_use_hazard_T_1 = and(id_rs1_used, _load_use_hazard_T) @[PipelineCore.scala 91:55]
    node _id_rs2_used_T = eq(id_opcode, UInt<6>("h33")) @[PipelineCore.scala 82:51]
    node _id_rs2_used_T_1 = or(_id_rs2_used_T, decoder.io_ctrl_ctrlMemWrite) @[PipelineCore.scala 82:68]
    node _id_rs2_used_T_2 = or(_id_rs2_used_T_1, decoder.io_ctrl_ctrlBranch) @[PipelineCore.scala 82:100]
    node id_rs2_used = and(reg_IF_ID_valid, _id_rs2_used_T_2) @[PipelineCore.scala 82:37]
    node _load_use_hazard_T_2 = eq(reg_ID_EX_rd_addr, decoder.io_reg_addr_rs2_addr) @[PipelineCore.scala 91:125]
    node _load_use_hazard_T_3 = and(id_rs2_used, _load_use_hazard_T_2) @[PipelineCore.scala 91:104]
    node _load_use_hazard_T_4 = or(_load_use_hazard_T_1, _load_use_hazard_T_3) @[PipelineCore.scala 91:88]
    node load_use_hazard = and(ex_is_load, _load_use_hazard_T_4) @[PipelineCore.scala 91:38]
    node _GEN_10 = mux(load_use_hazard, UInt<1>("h1"), UInt<1>("h0")) @[PipelineCore.scala 92:27 93:20]
    node stall_hazard = _GEN_10
    node _stall_ID_T = or(stall_EX, stall_hazard) @[PipelineCore.scala 254:26]
    node stall_ID = _stall_ID_T @[PipelineCore.scala 254:13 32:23]
    node stall_IF = stall_ID @[PipelineCore.scala 255:13 31:23]
    node _GEN_0 = mux(stall_IF, pc_IF, _pc_IF_T_1) @[PipelineCore.scala 50:24 51:18 54:18]
    node _GEN_1 = mux(stall_IF, pc_IF, _io_imem_addr_T_1) @[PipelineCore.scala 50:24 52:18 55:18]
    node ex_is_jump = and(reg_ID_EX_valid, reg_ID_EX_ctrl_ctrlJump) @[PipelineCore.scala 177:38]
    node _ex_is_branch_T = and(reg_ID_EX_valid, reg_ID_EX_ctrl_ctrlBranch) @[PipelineCore.scala 178:38]
    node ex_is_branch = and(_ex_is_branch_T, alu.io_to_branch) @[PipelineCore.scala 178:67]
    node _jump_flag_T = or(ex_is_jump, ex_is_branch) @[PipelineCore.scala 179:28]
    node _jump_flag_T_1 = eq(stall_MEM, UInt<1>("h0")) @[PipelineCore.scala 179:48]
    node _jump_flag_T_2 = and(_jump_flag_T, _jump_flag_T_1) @[PipelineCore.scala 179:45]
    node jump_flag = _jump_flag_T_2 @[PipelineCore.scala 179:13 44:23]
    node jump_addr = alu.io_jump_addr @[PipelineCore.scala 180:13 45:23]
    node _GEN_2 = mux(jump_flag, jump_addr, _GEN_0) @[PipelineCore.scala 47:19 48:18]
    node _GEN_3 = mux(jump_flag, jump_addr, _GEN_1) @[PipelineCore.scala 47:19 49:18]
    node _T = eq(stall_ID, UInt<1>("h0")) @[PipelineCore.scala 61:14]
    node _GEN_4 = mux(_T, pc_IF, reg_IF_ID_pc) @[PipelineCore.scala 61:25 62:21 25:27]
    node _GEN_5 = mux(_T, io_imem_inst, reg_IF_ID_inst) @[PipelineCore.scala 61:25 63:21 25:27]
    node _GEN_6 = mux(_T, UInt<1>("h1"), reg_IF_ID_valid) @[PipelineCore.scala 61:25 64:21 25:27]
    node flush_IF_ID = jump_flag @[PipelineCore.scala 257:15 36:25]
    node _reg_IF_ID_WIRE_1_valid = UInt<1>("h0") @[PipelineCore.scala 60:{30,30}]
    node _GEN_7 = mux(flush_IF_ID, _reg_IF_ID_WIRE_1_valid, _GEN_6) @[PipelineCore.scala 59:21 60:15]
    node _reg_IF_ID_WIRE_1_inst = UInt<32>("h0") @[PipelineCore.scala 60:{30,30}]
    node _GEN_8 = mux(flush_IF_ID, _reg_IF_ID_WIRE_1_inst, _GEN_5) @[PipelineCore.scala 59:21 60:15]
    node _reg_IF_ID_WIRE_1_pc = UInt<32>("h0") @[PipelineCore.scala 60:{30,30}]
    node _GEN_9 = mux(flush_IF_ID, _reg_IF_ID_WIRE_1_pc, _GEN_4) @[PipelineCore.scala 59:21 60:15]
    node _T_1 = and(reg_MEM_WB_valid, reg_MEM_WB_ctrl_ctrlRegWrite) @[PipelineCore.scala 114:27]
    node _T_2 = neq(reg_MEM_WB_rd_addr, UInt<1>("h0")) @[PipelineCore.scala 114:82]
    node _T_3 = and(_T_1, _T_2) @[PipelineCore.scala 114:59]
    node _T_4 = eq(reg_MEM_WB_rd_addr, decoder.io_reg_addr_rs1_addr) @[PipelineCore.scala 114:114]
    node _T_5 = and(_T_3, _T_4) @[PipelineCore.scala 114:91]
    node _wb_data_T = mux(reg_MEM_WB_ctrl_ctrlMemToReg, reg_MEM_WB_rdata, reg_MEM_WB_alu_result) @[PipelineCore.scala 274:17]
    node wb_data = _wb_data_T @[PipelineCore.scala 108:21 274:11]
    node _GEN_11 = mux(_T_5, wb_data, regfile.io_data_read1) @[PipelineCore.scala 114:127 115:17]
    node _T_6 = and(reg_MEM_WB_valid, reg_MEM_WB_ctrl_ctrlRegWrite) @[PipelineCore.scala 117:27]
    node _T_7 = neq(reg_MEM_WB_rd_addr, UInt<1>("h0")) @[PipelineCore.scala 117:82]
    node _T_8 = and(_T_6, _T_7) @[PipelineCore.scala 117:59]
    node _T_9 = eq(reg_MEM_WB_rd_addr, decoder.io_reg_addr_rs2_addr) @[PipelineCore.scala 117:114]
    node _T_10 = and(_T_8, _T_9) @[PipelineCore.scala 117:91]
    node _GEN_12 = mux(_T_10, wb_data, regfile.io_data_read2) @[PipelineCore.scala 117:127 118:17]
    node _T_11 = eq(stall_EX, UInt<1>("h0")) @[PipelineCore.scala 125:14]
    node _T_12 = eq(reg_IF_ID_valid, UInt<1>("h0")) @[PipelineCore.scala 126:26]
    node _T_13 = or(stall_hazard, _T_12) @[PipelineCore.scala 126:23]
    node _reg_ID_EX_WIRE_2_valid = UInt<1>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_13 = mux(_T_13, _reg_ID_EX_WIRE_2_valid, UInt<1>("h1")) @[PipelineCore.scala 126:44 127:17 138:26]
    node _reg_ID_EX_WIRE_2_imm = UInt<32>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_14 = mux(_T_13, _reg_ID_EX_WIRE_2_imm, decoder.io_imm) @[PipelineCore.scala 126:44 127:17 137:26]
    node _reg_ID_EX_WIRE_2_rdata2 = UInt<32>("h0") @[PipelineCore.scala 127:{32,32}]
    node id_rdata2 = _GEN_12
    node _GEN_15 = mux(_T_13, _reg_ID_EX_WIRE_2_rdata2, id_rdata2) @[PipelineCore.scala 126:44 127:17 136:26]
    node _reg_ID_EX_WIRE_2_rdata1 = UInt<32>("h0") @[PipelineCore.scala 127:{32,32}]
    node id_rdata1 = _GEN_11
    node _GEN_16 = mux(_T_13, _reg_ID_EX_WIRE_2_rdata1, id_rdata1) @[PipelineCore.scala 126:44 127:17 135:26]
    node _reg_ID_EX_WIRE_2_rd_addr = UInt<5>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_17 = mux(_T_13, _reg_ID_EX_WIRE_2_rd_addr, decoder.io_reg_addr_rd_addr) @[PipelineCore.scala 126:44 127:17 134:26]
    node _reg_ID_EX_WIRE_2_rs2_addr = UInt<5>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_18 = mux(_T_13, _reg_ID_EX_WIRE_2_rs2_addr, decoder.io_reg_addr_rs2_addr) @[PipelineCore.scala 126:44 127:17 133:26]
    node _reg_ID_EX_WIRE_2_rs1_addr = UInt<5>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_19 = mux(_T_13, _reg_ID_EX_WIRE_2_rs1_addr, decoder.io_reg_addr_rs1_addr) @[PipelineCore.scala 126:44 127:17 132:26]
    node _reg_ID_EX_WIRE_2_ctrl_ctrlMemToReg = UInt<1>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_20 = mux(_T_13, _reg_ID_EX_WIRE_2_ctrl_ctrlMemToReg, decoder.io_ctrl_ctrlMemToReg) @[PipelineCore.scala 126:44 127:17 131:26]
    node _reg_ID_EX_WIRE_2_ctrl_ctrlALUOp = UInt<5>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_21 = mux(_T_13, _reg_ID_EX_WIRE_2_ctrl_ctrlALUOp, decoder.io_ctrl_ctrlALUOp) @[PipelineCore.scala 126:44 127:17 131:26]
    node _reg_ID_EX_WIRE_2_ctrl_ctrlALUSrc = UInt<1>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_22 = mux(_T_13, _reg_ID_EX_WIRE_2_ctrl_ctrlALUSrc, decoder.io_ctrl_ctrlALUSrc) @[PipelineCore.scala 126:44 127:17 131:26]
    node _reg_ID_EX_WIRE_2_ctrl_ctrlMemWrite = UInt<1>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_23 = mux(_T_13, _reg_ID_EX_WIRE_2_ctrl_ctrlMemWrite, decoder.io_ctrl_ctrlMemWrite) @[PipelineCore.scala 126:44 127:17 131:26]
    node _reg_ID_EX_WIRE_2_ctrl_ctrlMemRead = UInt<1>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_24 = mux(_T_13, _reg_ID_EX_WIRE_2_ctrl_ctrlMemRead, decoder.io_ctrl_ctrlMemRead) @[PipelineCore.scala 126:44 127:17 131:26]
    node _reg_ID_EX_WIRE_2_ctrl_ctrlRegWrite = UInt<1>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_25 = mux(_T_13, _reg_ID_EX_WIRE_2_ctrl_ctrlRegWrite, decoder.io_ctrl_ctrlRegWrite) @[PipelineCore.scala 126:44 127:17 131:26]
    node _reg_ID_EX_WIRE_2_ctrl_ctrlBranch = UInt<1>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_26 = mux(_T_13, _reg_ID_EX_WIRE_2_ctrl_ctrlBranch, decoder.io_ctrl_ctrlBranch) @[PipelineCore.scala 126:44 127:17 131:26]
    node _reg_ID_EX_WIRE_2_ctrl_ctrlJump = UInt<1>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_27 = mux(_T_13, _reg_ID_EX_WIRE_2_ctrl_ctrlJump, decoder.io_ctrl_ctrlJump) @[PipelineCore.scala 126:44 127:17 131:26]
    node _reg_ID_EX_WIRE_2_inst = UInt<32>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_28 = mux(_T_13, _reg_ID_EX_WIRE_2_inst, reg_IF_ID_inst) @[PipelineCore.scala 126:44 127:17 130:26]
    node _reg_ID_EX_WIRE_2_pc = UInt<32>("h0") @[PipelineCore.scala 127:{32,32}]
    node _GEN_29 = mux(_T_13, _reg_ID_EX_WIRE_2_pc, reg_IF_ID_pc) @[PipelineCore.scala 126:44 127:17 129:26]
    node _GEN_30 = mux(_T_11, _GEN_13, reg_ID_EX_valid) @[PipelineCore.scala 125:25 26:27]
    node _GEN_31 = mux(_T_11, _GEN_14, reg_ID_EX_imm) @[PipelineCore.scala 125:25 26:27]
    node _GEN_32 = mux(_T_11, _GEN_15, reg_ID_EX_rdata2) @[PipelineCore.scala 125:25 26:27]
    node _GEN_33 = mux(_T_11, _GEN_16, reg_ID_EX_rdata1) @[PipelineCore.scala 125:25 26:27]
    node _GEN_34 = mux(_T_11, _GEN_17, reg_ID_EX_rd_addr) @[PipelineCore.scala 125:25 26:27]
    node _GEN_35 = mux(_T_11, _GEN_18, reg_ID_EX_rs2_addr) @[PipelineCore.scala 125:25 26:27]
    node _GEN_36 = mux(_T_11, _GEN_19, reg_ID_EX_rs1_addr) @[PipelineCore.scala 125:25 26:27]
    node _GEN_37 = mux(_T_11, _GEN_20, reg_ID_EX_ctrl_ctrlMemToReg) @[PipelineCore.scala 125:25 26:27]
    node _GEN_38 = mux(_T_11, _GEN_21, reg_ID_EX_ctrl_ctrlALUOp) @[PipelineCore.scala 125:25 26:27]
    node _GEN_39 = mux(_T_11, _GEN_22, reg_ID_EX_ctrl_ctrlALUSrc) @[PipelineCore.scala 125:25 26:27]
    node _GEN_40 = mux(_T_11, _GEN_23, reg_ID_EX_ctrl_ctrlMemWrite) @[PipelineCore.scala 125:25 26:27]
    node _GEN_41 = mux(_T_11, _GEN_24, reg_ID_EX_ctrl_ctrlMemRead) @[PipelineCore.scala 125:25 26:27]
    node _GEN_42 = mux(_T_11, _GEN_25, reg_ID_EX_ctrl_ctrlRegWrite) @[PipelineCore.scala 125:25 26:27]
    node _GEN_43 = mux(_T_11, _GEN_26, reg_ID_EX_ctrl_ctrlBranch) @[PipelineCore.scala 125:25 26:27]
    node _GEN_44 = mux(_T_11, _GEN_27, reg_ID_EX_ctrl_ctrlJump) @[PipelineCore.scala 125:25 26:27]
    node _GEN_45 = mux(_T_11, _GEN_28, reg_ID_EX_inst) @[PipelineCore.scala 125:25 26:27]
    node _GEN_46 = mux(_T_11, _GEN_29, reg_ID_EX_pc) @[PipelineCore.scala 125:25 26:27]
    node flush_ID_EX = jump_flag @[PipelineCore.scala 258:15 37:25]
    node _reg_ID_EX_WIRE_1_valid = UInt<1>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_47 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_valid, _GEN_30) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_imm = UInt<32>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_48 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_imm, _GEN_31) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_rdata2 = UInt<32>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_49 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_rdata2, _GEN_32) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_rdata1 = UInt<32>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_50 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_rdata1, _GEN_33) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_rd_addr = UInt<5>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_51 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_rd_addr, _GEN_34) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_rs2_addr = UInt<5>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_52 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_rs2_addr, _GEN_35) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_rs1_addr = UInt<5>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_53 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_rs1_addr, _GEN_36) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_ctrl_ctrlMemToReg = UInt<1>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_54 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_ctrl_ctrlMemToReg, _GEN_37) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_ctrl_ctrlALUOp = UInt<5>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_55 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_ctrl_ctrlALUOp, _GEN_38) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_ctrl_ctrlALUSrc = UInt<1>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_56 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_ctrl_ctrlALUSrc, _GEN_39) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_ctrl_ctrlMemWrite = UInt<1>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_57 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_ctrl_ctrlMemWrite, _GEN_40) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_ctrl_ctrlMemRead = UInt<1>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_58 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_ctrl_ctrlMemRead, _GEN_41) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_ctrl_ctrlRegWrite = UInt<1>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_59 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_ctrl_ctrlRegWrite, _GEN_42) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_ctrl_ctrlBranch = UInt<1>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_60 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_ctrl_ctrlBranch, _GEN_43) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_ctrl_ctrlJump = UInt<1>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_61 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_ctrl_ctrlJump, _GEN_44) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_inst = UInt<32>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_62 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_inst, _GEN_45) @[PipelineCore.scala 123:21 124:15]
    node _reg_ID_EX_WIRE_1_pc = UInt<32>("h0") @[PipelineCore.scala 124:{30,30}]
    node _GEN_63 = mux(flush_ID_EX, _reg_ID_EX_WIRE_1_pc, _GEN_46) @[PipelineCore.scala 123:21 124:15]
    node _T_14 = and(reg_EX_MEM_valid, reg_EX_MEM_ctrl_ctrlRegWrite) @[PipelineCore.scala 150:27]
    node _T_15 = neq(reg_EX_MEM_rd_addr, UInt<1>("h0")) @[PipelineCore.scala 150:82]
    node _T_16 = and(_T_14, _T_15) @[PipelineCore.scala 150:59]
    node _T_17 = eq(reg_EX_MEM_rd_addr, reg_ID_EX_rs1_addr) @[PipelineCore.scala 150:114]
    node _T_18 = and(_T_16, _T_17) @[PipelineCore.scala 150:91]
    node _forward_a_T = mux(reg_EX_MEM_ctrl_ctrlMemToReg, io_dmem_resp_bits_rdata, reg_EX_MEM_alu_result) @[PipelineCore.scala 151:23]
    node _T_19 = and(reg_MEM_WB_valid, reg_MEM_WB_ctrl_ctrlRegWrite) @[PipelineCore.scala 152:33]
    node _T_20 = neq(reg_MEM_WB_rd_addr, UInt<1>("h0")) @[PipelineCore.scala 152:88]
    node _T_21 = and(_T_19, _T_20) @[PipelineCore.scala 152:65]
    node _T_22 = eq(reg_MEM_WB_rd_addr, reg_ID_EX_rs1_addr) @[PipelineCore.scala 152:120]
    node _T_23 = and(_T_21, _T_22) @[PipelineCore.scala 152:97]
    node _GEN_64 = mux(_T_23, wb_data, reg_ID_EX_rdata1) @[PipelineCore.scala 152:145 153:17]
    node _GEN_65 = mux(_T_18, _forward_a_T, _GEN_64) @[PipelineCore.scala 150:139 151:17]
    node _T_24 = and(reg_EX_MEM_valid, reg_EX_MEM_ctrl_ctrlRegWrite) @[PipelineCore.scala 157:27]
    node _T_25 = neq(reg_EX_MEM_rd_addr, UInt<1>("h0")) @[PipelineCore.scala 157:82]
    node _T_26 = and(_T_24, _T_25) @[PipelineCore.scala 157:59]
    node _T_27 = eq(reg_EX_MEM_rd_addr, reg_ID_EX_rs2_addr) @[PipelineCore.scala 157:114]
    node _T_28 = and(_T_26, _T_27) @[PipelineCore.scala 157:91]
    node _forward_b_T = mux(reg_EX_MEM_ctrl_ctrlMemToReg, io_dmem_resp_bits_rdata, reg_EX_MEM_alu_result) @[PipelineCore.scala 158:23]
    node _T_29 = and(reg_MEM_WB_valid, reg_MEM_WB_ctrl_ctrlRegWrite) @[PipelineCore.scala 159:33]
    node _T_30 = neq(reg_MEM_WB_rd_addr, UInt<1>("h0")) @[PipelineCore.scala 159:88]
    node _T_31 = and(_T_29, _T_30) @[PipelineCore.scala 159:65]
    node _T_32 = eq(reg_MEM_WB_rd_addr, reg_ID_EX_rs2_addr) @[PipelineCore.scala 159:120]
    node _T_33 = and(_T_31, _T_32) @[PipelineCore.scala 159:97]
    node _GEN_66 = mux(_T_33, wb_data, reg_ID_EX_rdata2) @[PipelineCore.scala 159:145 160:17]
    node _GEN_67 = mux(_T_28, _forward_b_T, _GEN_66) @[PipelineCore.scala 157:139 158:17]
    node _T_34 = eq(flush_ID_EX, UInt<1>("h0")) @[PipelineCore.scala 164:10]
    node _T_35 = and(_T_34, stall_EX) @[PipelineCore.scala 164:23]
    node forward_a = _GEN_65
    node _GEN_68 = mux(_T_35, forward_a, _GEN_50) @[PipelineCore.scala 164:36 165:24]
    node forward_b = _GEN_67
    node _GEN_69 = mux(_T_35, forward_b, _GEN_49) @[PipelineCore.scala 164:36 166:24]
    node _alu_io_src_b_T = mux(reg_ID_EX_ctrl_ctrlALUSrc, reg_ID_EX_imm, forward_b) @[PipelineCore.scala 174:23]
    node _io_dmem_req_valid_T = eq(dmem_req_fired, UInt<1>("h0")) @[PipelineCore.scala 186:42]
    node _io_dmem_req_valid_T_1 = and(is_dmem_op, _io_dmem_req_valid_T) @[PipelineCore.scala 186:39]
    node _io_dmem_req_valid_T_2 = eq(stall_MEM, UInt<1>("h0")) @[PipelineCore.scala 186:61]
    node _io_dmem_req_valid_T_3 = and(_io_dmem_req_valid_T_1, _io_dmem_req_valid_T_2) @[PipelineCore.scala 186:58]
    node _T_36 = and(io_dmem_req_ready, io_dmem_req_valid) @[Decoupled.scala 50:35]
    node _GEN_70 = mux(_T_36, UInt<1>("h1"), dmem_req_fired) @[PipelineCore.scala 191:26 192:20 183:31]
    node _T_37 = eq(stall_EX, UInt<1>("h0")) @[PipelineCore.scala 194:8]
    node _GEN_71 = mux(_T_37, UInt<1>("h0"), _GEN_70) @[PipelineCore.scala 194:19 195:20]
    reg mul_req_fired : UInt<1>, clock with :
      reset => (UInt<1>("h0"), mul_req_fired) @[PipelineCore.scala 204:32]
    node _io_mul_req_valid_T = eq(mul_req_fired, UInt<1>("h0")) @[PipelineCore.scala 207:33]
    node _io_mul_req_valid_T_1 = and(is_mul, _io_mul_req_valid_T) @[PipelineCore.scala 207:30]
    node _io_mul_resp_ready_T = eq(stall_MEM, UInt<1>("h0")) @[PipelineCore.scala 210:23]
    node _T_38 = and(io_mul_req_ready, io_mul_req_valid) @[Decoupled.scala 50:35]
    node _GEN_72 = mux(_T_38, UInt<1>("h1"), mul_req_fired) @[PipelineCore.scala 212:24 213:21 204:32]
    node _T_39 = eq(stall_EX, UInt<1>("h0")) @[PipelineCore.scala 215:10]
    node _GEN_73 = mux(_T_39, UInt<1>("h0"), _GEN_72) @[PipelineCore.scala 215:21 216:21]
    node _GEN_74 = mux(_T_40, io_mul_resp_bits_result, UInt<32>("h0")) @[PipelineCore.scala 220:27 221:20]
    node _GEN_76 = mux(is_mul, _GEN_74, UInt<32>("h0")) @[PipelineCore.scala 219:18]
    node _T_41 = eq(stall_MEM, UInt<1>("h0")) @[PipelineCore.scala 233:8]
    node _T_42 = eq(reg_ID_EX_valid, UInt<1>("h0")) @[PipelineCore.scala 234:31]
    node _T_43 = or(stall_EX_internal, _T_42) @[PipelineCore.scala 234:28]
    node mul_result = _GEN_76
    node _reg_EX_MEM_alu_result_T = mux(is_mul, mul_result, alu.io_alu_result) @[PipelineCore.scala 239:35]
    node _reg_EX_MEM_WIRE_1_valid = UInt<1>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_78 = mux(_T_43, _reg_EX_MEM_WIRE_1_valid, UInt<1>("h1")) @[PipelineCore.scala 234:49 235:18 241:29]
    node _reg_EX_MEM_WIRE_1_wdata = UInt<32>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_79 = mux(_T_43, _reg_EX_MEM_WIRE_1_wdata, forward_b) @[PipelineCore.scala 234:49 235:18 240:29]
    node _reg_EX_MEM_WIRE_1_alu_result = UInt<32>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_80 = mux(_T_43, _reg_EX_MEM_WIRE_1_alu_result, _reg_EX_MEM_alu_result_T) @[PipelineCore.scala 234:49 235:18 239:29]
    node _reg_EX_MEM_WIRE_1_rd_addr = UInt<5>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_81 = mux(_T_43, _reg_EX_MEM_WIRE_1_rd_addr, reg_ID_EX_rd_addr) @[PipelineCore.scala 234:49 235:18 238:29]
    node _reg_EX_MEM_WIRE_1_ctrl_ctrlMemToReg = UInt<1>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_82 = mux(_T_43, _reg_EX_MEM_WIRE_1_ctrl_ctrlMemToReg, reg_ID_EX_ctrl_ctrlMemToReg) @[PipelineCore.scala 234:49 235:18 237:29]
    node _reg_EX_MEM_WIRE_1_ctrl_ctrlALUOp = UInt<5>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_83 = mux(_T_43, _reg_EX_MEM_WIRE_1_ctrl_ctrlALUOp, reg_ID_EX_ctrl_ctrlALUOp) @[PipelineCore.scala 234:49 235:18 237:29]
    node _reg_EX_MEM_WIRE_1_ctrl_ctrlALUSrc = UInt<1>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_84 = mux(_T_43, _reg_EX_MEM_WIRE_1_ctrl_ctrlALUSrc, reg_ID_EX_ctrl_ctrlALUSrc) @[PipelineCore.scala 234:49 235:18 237:29]
    node _reg_EX_MEM_WIRE_1_ctrl_ctrlMemWrite = UInt<1>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_85 = mux(_T_43, _reg_EX_MEM_WIRE_1_ctrl_ctrlMemWrite, reg_ID_EX_ctrl_ctrlMemWrite) @[PipelineCore.scala 234:49 235:18 237:29]
    node _reg_EX_MEM_WIRE_1_ctrl_ctrlMemRead = UInt<1>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_86 = mux(_T_43, _reg_EX_MEM_WIRE_1_ctrl_ctrlMemRead, reg_ID_EX_ctrl_ctrlMemRead) @[PipelineCore.scala 234:49 235:18 237:29]
    node _reg_EX_MEM_WIRE_1_ctrl_ctrlRegWrite = UInt<1>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_87 = mux(_T_43, _reg_EX_MEM_WIRE_1_ctrl_ctrlRegWrite, reg_ID_EX_ctrl_ctrlRegWrite) @[PipelineCore.scala 234:49 235:18 237:29]
    node _reg_EX_MEM_WIRE_1_ctrl_ctrlBranch = UInt<1>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_88 = mux(_T_43, _reg_EX_MEM_WIRE_1_ctrl_ctrlBranch, reg_ID_EX_ctrl_ctrlBranch) @[PipelineCore.scala 234:49 235:18 237:29]
    node _reg_EX_MEM_WIRE_1_ctrl_ctrlJump = UInt<1>("h0") @[PipelineCore.scala 235:{33,33}]
    node _GEN_89 = mux(_T_43, _reg_EX_MEM_WIRE_1_ctrl_ctrlJump, reg_ID_EX_ctrl_ctrlJump) @[PipelineCore.scala 234:49 235:18 237:29]
    node _GEN_90 = mux(_T_41, _GEN_78, reg_EX_MEM_valid) @[PipelineCore.scala 233:20 27:27]
    node _GEN_91 = mux(_T_41, _GEN_79, reg_EX_MEM_wdata) @[PipelineCore.scala 233:20 27:27]
    node _GEN_92 = mux(_T_41, _GEN_80, reg_EX_MEM_alu_result) @[PipelineCore.scala 233:20 27:27]
    node _GEN_93 = mux(_T_41, _GEN_81, reg_EX_MEM_rd_addr) @[PipelineCore.scala 233:20 27:27]
    node _GEN_94 = mux(_T_41, _GEN_82, reg_EX_MEM_ctrl_ctrlMemToReg) @[PipelineCore.scala 233:20 27:27]
    node _GEN_95 = mux(_T_41, _GEN_83, reg_EX_MEM_ctrl_ctrlALUOp) @[PipelineCore.scala 233:20 27:27]
    node _GEN_96 = mux(_T_41, _GEN_84, reg_EX_MEM_ctrl_ctrlALUSrc) @[PipelineCore.scala 233:20 27:27]
    node _GEN_97 = mux(_T_41, _GEN_85, reg_EX_MEM_ctrl_ctrlMemWrite) @[PipelineCore.scala 233:20 27:27]
    node _GEN_98 = mux(_T_41, _GEN_86, reg_EX_MEM_ctrl_ctrlMemRead) @[PipelineCore.scala 233:20 27:27]
    node _GEN_99 = mux(_T_41, _GEN_87, reg_EX_MEM_ctrl_ctrlRegWrite) @[PipelineCore.scala 233:20 27:27]
    node _GEN_100 = mux(_T_41, _GEN_88, reg_EX_MEM_ctrl_ctrlBranch) @[PipelineCore.scala 233:20 27:27]
    node _GEN_101 = mux(_T_41, _GEN_89, reg_EX_MEM_ctrl_ctrlJump) @[PipelineCore.scala 233:20 27:27]
    node _reg_MEM_WB_WIRE_1_valid = UInt<1>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_102 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_valid, reg_EX_MEM_valid) @[PipelineCore.scala 261:19 262:16 268:27]
    node _reg_MEM_WB_WIRE_1_rdata = UInt<32>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_103 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_rdata, io_dmem_resp_bits_rdata) @[PipelineCore.scala 261:19 262:16 267:27]
    node _reg_MEM_WB_WIRE_1_alu_result = UInt<32>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_104 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_alu_result, reg_EX_MEM_alu_result) @[PipelineCore.scala 261:19 262:16 266:27]
    node _reg_MEM_WB_WIRE_1_rd_addr = UInt<5>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_105 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_rd_addr, reg_EX_MEM_rd_addr) @[PipelineCore.scala 261:19 262:16 265:27]
    node _reg_MEM_WB_WIRE_1_ctrl_ctrlMemToReg = UInt<1>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_106 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_ctrl_ctrlMemToReg, reg_EX_MEM_ctrl_ctrlMemToReg) @[PipelineCore.scala 261:19 262:16 264:27]
    node _reg_MEM_WB_WIRE_1_ctrl_ctrlALUOp = UInt<5>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_107 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_ctrl_ctrlALUOp, reg_EX_MEM_ctrl_ctrlALUOp) @[PipelineCore.scala 261:19 262:16 264:27]
    node _reg_MEM_WB_WIRE_1_ctrl_ctrlALUSrc = UInt<1>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_108 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_ctrl_ctrlALUSrc, reg_EX_MEM_ctrl_ctrlALUSrc) @[PipelineCore.scala 261:19 262:16 264:27]
    node _reg_MEM_WB_WIRE_1_ctrl_ctrlMemWrite = UInt<1>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_109 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_ctrl_ctrlMemWrite, reg_EX_MEM_ctrl_ctrlMemWrite) @[PipelineCore.scala 261:19 262:16 264:27]
    node _reg_MEM_WB_WIRE_1_ctrl_ctrlMemRead = UInt<1>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_110 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_ctrl_ctrlMemRead, reg_EX_MEM_ctrl_ctrlMemRead) @[PipelineCore.scala 261:19 262:16 264:27]
    node _reg_MEM_WB_WIRE_1_ctrl_ctrlRegWrite = UInt<1>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_111 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_ctrl_ctrlRegWrite, reg_EX_MEM_ctrl_ctrlRegWrite) @[PipelineCore.scala 261:19 262:16 264:27]
    node _reg_MEM_WB_WIRE_1_ctrl_ctrlBranch = UInt<1>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_112 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_ctrl_ctrlBranch, reg_EX_MEM_ctrl_ctrlBranch) @[PipelineCore.scala 261:19 262:16 264:27]
    node _reg_MEM_WB_WIRE_1_ctrl_ctrlJump = UInt<1>("h0") @[PipelineCore.scala 262:{31,31}]
    node _GEN_113 = mux(stall_MEM, _reg_MEM_WB_WIRE_1_ctrl_ctrlJump, reg_EX_MEM_ctrl_ctrlJump) @[PipelineCore.scala 261:19 262:16 264:27]
    node _regfile_io_ctrlRegWrite_T = and(reg_MEM_WB_valid, reg_MEM_WB_ctrl_ctrlRegWrite) @[PipelineCore.scala 276:51]
    node _reg_IF_ID_WIRE_pc = UInt<32>("h0") @[PipelineCore.scala 25:{40,40}]
    node _reg_IF_ID_WIRE_inst = UInt<32>("h0") @[PipelineCore.scala 25:{40,40}]
    node _reg_IF_ID_WIRE_valid = UInt<1>("h0") @[PipelineCore.scala 25:{40,40}]
    node _reg_ID_EX_WIRE_pc = UInt<32>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_inst = UInt<32>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_ctrl_ctrlJump = UInt<1>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_ctrl_ctrlBranch = UInt<1>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_ctrl_ctrlRegWrite = UInt<1>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_ctrl_ctrlMemRead = UInt<1>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_ctrl_ctrlMemWrite = UInt<1>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_ctrl_ctrlALUSrc = UInt<1>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_ctrl_ctrlALUOp = UInt<5>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_ctrl_ctrlMemToReg = UInt<1>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_rs1_addr = UInt<5>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_rs2_addr = UInt<5>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_rd_addr = UInt<5>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_rdata1 = UInt<32>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_rdata2 = UInt<32>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_imm = UInt<32>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_ID_EX_WIRE_valid = UInt<1>("h0") @[PipelineCore.scala 26:{40,40}]
    node _reg_EX_MEM_WIRE_ctrl_ctrlJump = UInt<1>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_ctrl_ctrlBranch = UInt<1>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_ctrl_ctrlRegWrite = UInt<1>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_ctrl_ctrlMemRead = UInt<1>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_ctrl_ctrlMemWrite = UInt<1>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_ctrl_ctrlALUSrc = UInt<1>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_ctrl_ctrlALUOp = UInt<5>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_ctrl_ctrlMemToReg = UInt<1>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_rd_addr = UInt<5>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_alu_result = UInt<32>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_wdata = UInt<32>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_EX_MEM_WIRE_valid = UInt<1>("h0") @[PipelineCore.scala 27:{40,40}]
    node _reg_MEM_WB_WIRE_ctrl_ctrlJump = UInt<1>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_ctrl_ctrlBranch = UInt<1>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_ctrl_ctrlRegWrite = UInt<1>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_ctrl_ctrlMemRead = UInt<1>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_ctrl_ctrlMemWrite = UInt<1>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_ctrl_ctrlALUSrc = UInt<1>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_ctrl_ctrlALUOp = UInt<5>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_ctrl_ctrlMemToReg = UInt<1>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_rd_addr = UInt<5>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_alu_result = UInt<32>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_rdata = UInt<32>("h0") @[PipelineCore.scala 28:{40,40}]
    node _reg_MEM_WB_WIRE_valid = UInt<1>("h0") @[PipelineCore.scala 28:{40,40}]
    io_imem_addr <= _GEN_3
    io_dmem_req_valid <= _io_dmem_req_valid_T_3 @[PipelineCore.scala 186:25]
    io_dmem_req_bits_addr <= alu.io_alu_result @[PipelineCore.scala 187:25]
    io_dmem_req_bits_wdata <= forward_b @[PipelineCore.scala 188:25]
    io_dmem_req_bits_wen <= reg_ID_EX_ctrl_ctrlMemWrite @[PipelineCore.scala 189:25]
    io_dmem_resp_ready <= UInt<1>("h1") @[PipelineCore.scala 250:22]
    io_mul_req_valid <= _io_mul_req_valid_T_1 @[PipelineCore.scala 207:20]
    io_mul_req_bits_a <= forward_a @[PipelineCore.scala 208:20]
    io_mul_req_bits_b <= forward_b @[PipelineCore.scala 209:20]
    io_mul_resp_ready <= _io_mul_resp_ready_T @[PipelineCore.scala 210:20]
    decoder.clock <= clock
    decoder.reset <= reset
    decoder.io_inst <= reg_IF_ID_inst @[PipelineCore.scala 70:19]
    regfile.clock <= clock
    regfile.reset <= reset
    regfile.io_ctrlRegWrite <= _regfile_io_ctrlRegWrite_T @[PipelineCore.scala 276:31]
    regfile.io_reg_addr_rs1_addr <= decoder.io_reg_addr_rs1_addr @[PipelineCore.scala 73:32]
    regfile.io_reg_addr_rs2_addr <= decoder.io_reg_addr_rs2_addr @[PipelineCore.scala 74:32]
    regfile.io_reg_addr_rd_addr <= reg_MEM_WB_rd_addr @[PipelineCore.scala 277:31]
    regfile.io_data_write <= wb_data @[PipelineCore.scala 278:31]
    alu.clock <= clock
    alu.reset <= reset
    alu.io_src_a <= forward_a @[PipelineCore.scala 173:17]
    alu.io_src_b <= _alu_io_src_b_T @[PipelineCore.scala 174:17]
    alu.io_imm <= reg_ID_EX_imm @[PipelineCore.scala 171:17]
    alu.io_pc <= reg_ID_EX_pc @[PipelineCore.scala 172:17]
    alu.io_alu_op <= reg_ID_EX_ctrl_ctrlALUOp @[PipelineCore.scala 170:17]
    reg_IF_ID_pc <= mux(reset, _reg_IF_ID_WIRE_pc, _GEN_9) @[PipelineCore.scala 25:{27,27}]
    reg_IF_ID_inst <= mux(reset, _reg_IF_ID_WIRE_inst, _GEN_8) @[PipelineCore.scala 25:{27,27}]
    reg_IF_ID_valid <= mux(reset, _reg_IF_ID_WIRE_valid, _GEN_7) @[PipelineCore.scala 25:{27,27}]
    reg_ID_EX_pc <= mux(reset, _reg_ID_EX_WIRE_pc, _GEN_63) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_inst <= mux(reset, _reg_ID_EX_WIRE_inst, _GEN_62) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_ctrl_ctrlJump <= mux(reset, _reg_ID_EX_WIRE_ctrl_ctrlJump, _GEN_61) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_ctrl_ctrlBranch <= mux(reset, _reg_ID_EX_WIRE_ctrl_ctrlBranch, _GEN_60) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_ctrl_ctrlRegWrite <= mux(reset, _reg_ID_EX_WIRE_ctrl_ctrlRegWrite, _GEN_59) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_ctrl_ctrlMemRead <= mux(reset, _reg_ID_EX_WIRE_ctrl_ctrlMemRead, _GEN_58) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_ctrl_ctrlMemWrite <= mux(reset, _reg_ID_EX_WIRE_ctrl_ctrlMemWrite, _GEN_57) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_ctrl_ctrlALUSrc <= mux(reset, _reg_ID_EX_WIRE_ctrl_ctrlALUSrc, _GEN_56) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_ctrl_ctrlALUOp <= mux(reset, _reg_ID_EX_WIRE_ctrl_ctrlALUOp, _GEN_55) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_ctrl_ctrlMemToReg <= mux(reset, _reg_ID_EX_WIRE_ctrl_ctrlMemToReg, _GEN_54) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_rs1_addr <= mux(reset, _reg_ID_EX_WIRE_rs1_addr, _GEN_53) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_rs2_addr <= mux(reset, _reg_ID_EX_WIRE_rs2_addr, _GEN_52) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_rd_addr <= mux(reset, _reg_ID_EX_WIRE_rd_addr, _GEN_51) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_rdata1 <= mux(reset, _reg_ID_EX_WIRE_rdata1, _GEN_68) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_rdata2 <= mux(reset, _reg_ID_EX_WIRE_rdata2, _GEN_69) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_imm <= mux(reset, _reg_ID_EX_WIRE_imm, _GEN_48) @[PipelineCore.scala 26:{27,27}]
    reg_ID_EX_valid <= mux(reset, _reg_ID_EX_WIRE_valid, _GEN_47) @[PipelineCore.scala 26:{27,27}]
    reg_EX_MEM_ctrl_ctrlJump <= mux(reset, _reg_EX_MEM_WIRE_ctrl_ctrlJump, _GEN_101) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_ctrl_ctrlBranch <= mux(reset, _reg_EX_MEM_WIRE_ctrl_ctrlBranch, _GEN_100) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_ctrl_ctrlRegWrite <= mux(reset, _reg_EX_MEM_WIRE_ctrl_ctrlRegWrite, _GEN_99) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_ctrl_ctrlMemRead <= mux(reset, _reg_EX_MEM_WIRE_ctrl_ctrlMemRead, _GEN_98) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_ctrl_ctrlMemWrite <= mux(reset, _reg_EX_MEM_WIRE_ctrl_ctrlMemWrite, _GEN_97) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_ctrl_ctrlALUSrc <= mux(reset, _reg_EX_MEM_WIRE_ctrl_ctrlALUSrc, _GEN_96) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_ctrl_ctrlALUOp <= mux(reset, _reg_EX_MEM_WIRE_ctrl_ctrlALUOp, _GEN_95) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_ctrl_ctrlMemToReg <= mux(reset, _reg_EX_MEM_WIRE_ctrl_ctrlMemToReg, _GEN_94) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_rd_addr <= mux(reset, _reg_EX_MEM_WIRE_rd_addr, _GEN_93) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_alu_result <= mux(reset, _reg_EX_MEM_WIRE_alu_result, _GEN_92) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_wdata <= mux(reset, _reg_EX_MEM_WIRE_wdata, _GEN_91) @[PipelineCore.scala 27:{27,27}]
    reg_EX_MEM_valid <= mux(reset, _reg_EX_MEM_WIRE_valid, _GEN_90) @[PipelineCore.scala 27:{27,27}]
    reg_MEM_WB_ctrl_ctrlJump <= mux(reset, _reg_MEM_WB_WIRE_ctrl_ctrlJump, _GEN_113) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_ctrl_ctrlBranch <= mux(reset, _reg_MEM_WB_WIRE_ctrl_ctrlBranch, _GEN_112) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_ctrl_ctrlRegWrite <= mux(reset, _reg_MEM_WB_WIRE_ctrl_ctrlRegWrite, _GEN_111) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_ctrl_ctrlMemRead <= mux(reset, _reg_MEM_WB_WIRE_ctrl_ctrlMemRead, _GEN_110) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_ctrl_ctrlMemWrite <= mux(reset, _reg_MEM_WB_WIRE_ctrl_ctrlMemWrite, _GEN_109) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_ctrl_ctrlALUSrc <= mux(reset, _reg_MEM_WB_WIRE_ctrl_ctrlALUSrc, _GEN_108) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_ctrl_ctrlALUOp <= mux(reset, _reg_MEM_WB_WIRE_ctrl_ctrlALUOp, _GEN_107) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_ctrl_ctrlMemToReg <= mux(reset, _reg_MEM_WB_WIRE_ctrl_ctrlMemToReg, _GEN_106) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_rd_addr <= mux(reset, _reg_MEM_WB_WIRE_rd_addr, _GEN_105) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_alu_result <= mux(reset, _reg_MEM_WB_WIRE_alu_result, _GEN_104) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_rdata <= mux(reset, _reg_MEM_WB_WIRE_rdata, _GEN_103) @[PipelineCore.scala 28:{27,27}]
    reg_MEM_WB_valid <= mux(reset, _reg_MEM_WB_WIRE_valid, _GEN_102) @[PipelineCore.scala 28:{27,27}]
    pc_IF <= mux(reset, UInt<32>("h0"), _GEN_2) @[PipelineCore.scala 42:{22,22}]
    dmem_req_fired <= mux(reset, UInt<1>("h0"), _GEN_71) @[PipelineCore.scala 183:{31,31}]
    mul_req_fired <= mux(reset, UInt<1>("h0"), _GEN_73) @[PipelineCore.scala 204:{32,32}]

  module InstMemSync :
    input clock : Clock
    input reset : UInt<1>
    input io_addr : UInt<32>
    output io_inst : UInt<32>
    output io_pc : UInt<32>

    mem mem : @[Memory.scala 32:24]
      data-type => UInt<32>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => io_inst_MPORT
      read-under-write => undefined
    node _io_inst_T = asUInt(reset) @[Memory.scala 35:33]
    node _io_inst_T_1 = shr(io_addr, 2) @[Memory.scala 35:54]
    node _io_inst_T_2 = mux(_io_inst_T, UInt<1>("h0"), _io_inst_T_1) @[Memory.scala 35:26]
    node _GEN_0 = validif(UInt<1>("h1"), _io_inst_T_2) @[Memory.scala 35:{22,22}]
    node _io_inst_WIRE = _GEN_0 @[Memory.scala 35:22]
    node _io_inst_T_3 = or(_io_inst_WIRE, UInt<10>("h0")) @[Memory.scala 35:22]
    node _io_inst_T_4 = bits(_io_inst_T_3, 9, 0) @[Memory.scala 35:22]
    node _GEN_1 = mux(UInt<1>("h1"), UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 35:{22,22} 32:24]
    node _GEN_2 = validif(UInt<1>("h1"), _io_inst_T_4) @[Memory.scala 35:{22,22}]
    node _GEN_3 = validif(UInt<1>("h1"), clock) @[Memory.scala 35:{22,22}]
    reg io_pc_REG : UInt<32>, clock with :
      reset => (UInt<1>("h0"), io_pc_REG) @[Memory.scala 36:21]
    io_inst <= mem.io_inst_MPORT.data @[Memory.scala 35:11]
    io_pc <= io_pc_REG @[Memory.scala 36:11]
    mem.io_inst_MPORT.addr <= _GEN_2
    mem.io_inst_MPORT.en <= _GEN_1
    mem.io_inst_MPORT.clk <= _GEN_3
    io_pc_REG <= mux(reset, UInt<1>("h0"), io_addr) @[Memory.scala 36:{21,21,21}]

  module DataMemHS :
    input clock : Clock
    input reset : UInt<1>
    output io_req_ready : UInt<1>
    input io_req_valid : UInt<1>
    input io_req_bits_addr : UInt<32>
    input io_req_bits_wdata : UInt<32>
    input io_req_bits_wen : UInt<1>
    input io_resp_ready : UInt<1>
    output io_resp_valid : UInt<1>
    output io_resp_bits_rdata : UInt<32>
    output io_peek_write : UInt<1>
    output io_peek_addr : UInt<32>
    output io_peek_data : UInt<32>

    mem mem : @[Memory.scala 71:26]
      data-type => UInt<32>
      depth => 1024
      read-latency => 1
      write-latency => 1
      reader => readOut
      writer => MPORT
      read-under-write => undefined
    node index = shr(io_req_bits_addr, 2) @[Memory.scala 72:32]
    reg busy : UInt<1>, clock with :
      reset => (UInt<1>("h0"), busy) @[Memory.scala 74:21]
    reg cnt : UInt<8>, clock with :
      reset => (UInt<1>("h0"), cnt) @[Memory.scala 75:21]
    node _io_req_ready_T = eq(busy, UInt<1>("h0")) @[Memory.scala 77:19]
    node _io_req_ready_T_1 = and(io_resp_ready, io_resp_valid) @[Decoupled.scala 50:35]
    node _io_req_ready_T_2 = or(_io_req_ready_T, _io_req_ready_T_1) @[Memory.scala 77:25]
    node _doRead_T = and(io_req_ready, io_req_valid) @[Decoupled.scala 50:35]
    node _doRead_T_1 = eq(io_req_bits_wen, UInt<1>("h0")) @[Memory.scala 78:32]
    node doRead = and(_doRead_T, _doRead_T_1) @[Memory.scala 78:29]
    node _doWrite_T = and(io_req_ready, io_req_valid) @[Decoupled.scala 50:35]
    node doWrite = and(_doWrite_T, io_req_bits_wen) @[Memory.scala 79:29]
    reg lat_state : UInt<16>, clock with :
      reset => (UInt<1>("h0"), lat_state) @[Memory.scala 85:26]
    node _lat_next_T = bits(lat_state, 0, 0) @[Memory.scala 86:28]
    node _lat_next_T_1 = shr(lat_state, 1) @[Memory.scala 86:40]
    node _lat_next_T_2 = xor(_lat_next_T_1, UInt<16>("hb400")) @[Memory.scala 86:46]
    node _lat_next_T_3 = shr(lat_state, 1) @[Memory.scala 86:70]
    node lat_next = mux(_lat_next_T, _lat_next_T_2, _lat_next_T_3) @[Memory.scala 86:22]
    node _lat_T = and(io_req_ready, io_req_valid) @[Decoupled.scala 50:35]
    node _GEN_0 = mux(_lat_T, lat_next, lat_state) @[Memory.scala 87:25 85:26 87:33]
    node _lat_T_1 = and(lat_next, UInt<8>("hff")) @[Memory.scala 88:24]
    node _lat_T_2 = add(UInt<9>("h1"), _lat_T_1) @[Memory.scala 88:16]
    node lat = tail(_lat_T_2, 1) @[Memory.scala 88:16]
    node _T = bits(index, 9, 0)
    node _GEN_1 = validif(doWrite, _T) @[Memory.scala 91:17]
    node _GEN_2 = validif(doWrite, clock) @[Memory.scala 91:17]
    node _GEN_3 = mux(doWrite, UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 91:17 71:26]
    node _GEN_4 = validif(doWrite, UInt<1>("h1")) @[Memory.scala 91:17]
    node _GEN_5 = validif(doWrite, io_req_bits_wdata) @[Memory.scala 91:17]
    node _GEN_6 = validif(doRead, index) @[Memory.scala 95:{25,25}]
    node _readOut_WIRE = _GEN_6 @[Memory.scala 95:25]
    node _readOut_T = or(_readOut_WIRE, UInt<10>("h0")) @[Memory.scala 95:25]
    node _readOut_T_1 = bits(_readOut_T, 9, 0) @[Memory.scala 95:25]
    node _GEN_7 = mux(doRead, UInt<1>("h1"), UInt<1>("h0")) @[Memory.scala 95:{25,25} 71:26]
    node _GEN_8 = validif(doRead, _readOut_T_1) @[Memory.scala 95:{25,25}]
    node _GEN_9 = validif(doRead, clock) @[Memory.scala 95:{25,25}]
    reg fresh : UInt<1>, clock with :
      reset => (UInt<1>("h0"), fresh) @[Memory.scala 96:24]
    reg held : UInt<32>, clock with :
      reset => (UInt<1>("h0"), held) @[Reg.scala 16:16]
    node _GEN_10 = mux(fresh, mem.readOut.data, held) @[Reg.scala 16:16 17:{18,22}]
    node _io_resp_valid_T = eq(cnt, UInt<1>("h0")) @[Memory.scala 99:37]
    node _io_resp_valid_T_1 = and(busy, _io_resp_valid_T) @[Memory.scala 99:30]
    node _io_resp_bits_rdata_T = mux(fresh, mem.readOut.data, held) @[Memory.scala 100:28]
    node _cnt_T = sub(lat, UInt<1>("h1")) @[Memory.scala 104:17]
    node _cnt_T_1 = tail(_cnt_T, 1) @[Memory.scala 104:17]
    node _T_1 = and(io_resp_ready, io_resp_valid) @[Decoupled.scala 50:35]
    node _T_2 = neq(cnt, UInt<1>("h0")) @[Memory.scala 107:26]
    node _T_3 = and(busy, _T_2) @[Memory.scala 107:19]
    node _cnt_T_2 = sub(cnt, UInt<1>("h1")) @[Memory.scala 108:16]
    node _cnt_T_3 = tail(_cnt_T_2, 1) @[Memory.scala 108:16]
    node _GEN_11 = mux(_T_3, _cnt_T_3, cnt) @[Memory.scala 107:35 108:9 75:21]
    node _GEN_12 = mux(_T_1, UInt<1>("h0"), busy) @[Memory.scala 105:28 106:10 74:21]
    node _GEN_13 = mux(_T_1, cnt, _GEN_11) @[Memory.scala 105:28 75:21]
    node _GEN_14 = mux(doRead, UInt<1>("h1"), _GEN_12) @[Memory.scala 102:16 103:10]
    node _GEN_15 = mux(doRead, _cnt_T_1, _GEN_13) @[Memory.scala 102:16 104:10]
    io_req_ready <= _io_req_ready_T_2 @[Memory.scala 77:16]
    io_resp_valid <= _io_resp_valid_T_1 @[Memory.scala 99:22]
    io_resp_bits_rdata <= _io_resp_bits_rdata_T @[Memory.scala 100:22]
    io_peek_write <= doWrite @[Memory.scala 111:17]
    io_peek_addr <= io_req_bits_addr @[Memory.scala 112:17]
    io_peek_data <= io_req_bits_wdata @[Memory.scala 113:17]
    mem.readOut.addr <= _GEN_8
    mem.readOut.en <= _GEN_7
    mem.readOut.clk <= _GEN_9
    mem.MPORT.addr <= _GEN_1
    mem.MPORT.en <= _GEN_3
    mem.MPORT.clk <= _GEN_2
    mem.MPORT.data <= _GEN_5
    mem.MPORT.mask <= _GEN_4
    busy <= mux(reset, UInt<1>("h0"), _GEN_14) @[Memory.scala 74:{21,21}]
    cnt <= bits(mux(reset, UInt<8>("h0"), _GEN_15), 7, 0) @[Memory.scala 75:{21,21}]
    lat_state <= mux(reset, UInt<16>("hffff"), _GEN_0) @[Memory.scala 85:{26,26}]
    fresh <= mux(reset, UInt<1>("h0"), doRead) @[Memory.scala 96:{24,24,24}]
    held <= _GEN_10

  module MulUnit :
    input clock : Clock
    input reset : UInt<1>
    output io_req_ready : UInt<1>
    input io_req_valid : UInt<1>
    input io_req_bits_a : UInt<32>
    input io_req_bits_b : UInt<32>
    input io_resp_ready : UInt<1>
    output io_resp_valid : UInt<1>
    output io_resp_bits_result : UInt<32>

    reg busy : UInt<1>, clock with :
      reset => (UInt<1>("h0"), busy) @[MulUnit.scala 19:23]
    reg cnt : UInt<4>, clock with :
      reset => (UInt<1>("h0"), cnt) @[MulUnit.scala 20:23]
    reg result : UInt<32>, clock with :
      reset => (UInt<1>("h0"), result) @[MulUnit.scala 21:19]
    node _io_req_ready_T = eq(busy, UInt<1>("h0")) @[MulUnit.scala 23:26]
    node _io_resp_valid_T = eq(cnt, UInt<1>("h0")) @[MulUnit.scala 24:38]
    node _io_resp_valid_T_1 = and(busy, _io_resp_valid_T) @[MulUnit.scala 24:31]
    node _T = and(io_req_ready, io_req_valid) @[Decoupled.scala 50:35]
    node _result_T = mul(io_req_bits_a, io_req_bits_b) @[MulUnit.scala 30:30]
    node _result_T_1 = bits(_result_T, 31, 0) @[MulUnit.scala 30:46]
    node _T_1 = and(io_resp_ready, io_resp_valid) @[Decoupled.scala 50:35]
    node _T_2 = neq(cnt, UInt<1>("h0")) @[MulUnit.scala 33:26]
    node _T_3 = and(busy, _T_2) @[MulUnit.scala 33:19]
    node _cnt_T = sub(cnt, UInt<1>("h1")) @[MulUnit.scala 34:16]
    node _cnt_T_1 = tail(_cnt_T, 1) @[MulUnit.scala 34:16]
    node _GEN_0 = mux(_T_3, _cnt_T_1, cnt) @[MulUnit.scala 20:23 33:35 34:9]
    node _GEN_1 = mux(_T_1, UInt<1>("h0"), busy) @[MulUnit.scala 31:28 32:10 19:23]
    node _GEN_2 = mux(_T_1, cnt, _GEN_0) @[MulUnit.scala 20:23 31:28]
    node _GEN_3 = mux(_T, UInt<1>("h1"), _GEN_1) @[MulUnit.scala 27:21 28:12]
    node _GEN_4 = mux(_T, UInt<1>("h1"), _GEN_2) @[MulUnit.scala 27:21 29:12]
    node _GEN_5 = mux(_T, _result_T_1, result) @[MulUnit.scala 27:21 30:12 21:19]
    io_req_ready <= _io_req_ready_T @[MulUnit.scala 23:23]
    io_resp_valid <= _io_resp_valid_T_1 @[MulUnit.scala 24:23]
    io_resp_bits_result <= result @[MulUnit.scala 25:23]
    busy <= mux(reset, UInt<1>("h0"), _GEN_3) @[MulUnit.scala 19:{23,23}]
    cnt <= mux(reset, UInt<4>("h0"), _GEN_4) @[MulUnit.scala 20:{23,23}]
    result <= _GEN_5

  module Top :
    input clock : Clock
    input reset : UInt<1>
    output io_pc : UInt<32>
    output io_inst : UInt<32>
    output io_peek_write : UInt<1>
    output io_peek_addr : UInt<32>
    output io_peek_data : UInt<32>

    inst core of PipelineCore @[Top.scala 43:24]
    inst imem of InstMemSync @[Top.scala 44:24]
    inst dmem of DataMemHS @[Top.scala 45:24]
    inst mul of MulUnit @[Top.scala 54:25]
    io_pc <= imem.io_pc @[Top.scala 59:21]
    io_inst <= imem.io_inst @[Top.scala 60:21]
    io_peek_write <= dmem.io_peek_write @[Top.scala 61:21]
    io_peek_addr <= dmem.io_peek_addr @[Top.scala 62:21]
    io_peek_data <= dmem.io_peek_data @[Top.scala 63:21]
    core.clock <= clock
    core.reset <= reset
    core.io_imem_inst <= imem.io_inst @[Top.scala 48:25]
    core.io_dmem_req_ready <= dmem.io_req_ready @[Top.scala 50:25]
    core.io_dmem_resp_valid <= dmem.io_resp_valid @[Top.scala 51:25]
    core.io_dmem_resp_bits_rdata <= dmem.io_resp_bits_rdata @[Top.scala 51:25]
    core.io_mul_req_ready <= mul.io_req_ready @[Top.scala 55:26]
    core.io_mul_resp_valid <= mul.io_resp_valid @[Top.scala 56:30]
    core.io_mul_resp_bits_result <= mul.io_resp_bits_result @[Top.scala 56:30]
    imem.clock <= clock
    imem.reset <= reset
    imem.io_addr <= core.io_imem_addr @[Top.scala 47:25]
    dmem.clock <= clock
    dmem.reset <= reset
    dmem.io_req_valid <= core.io_dmem_req_valid @[Top.scala 50:25]
    dmem.io_req_bits_addr <= core.io_dmem_req_bits_addr @[Top.scala 50:25]
    dmem.io_req_bits_wdata <= core.io_dmem_req_bits_wdata @[Top.scala 50:25]
    dmem.io_req_bits_wen <= core.io_dmem_req_bits_wen @[Top.scala 50:25]
    dmem.io_resp_ready <= core.io_dmem_resp_ready @[Top.scala 51:25]
    mul.clock <= clock
    mul.reset <= reset
    mul.io_req_valid <= core.io_mul_req_valid @[Top.scala 55:26]
    mul.io_req_bits_a <= core.io_mul_req_bits_a @[Top.scala 55:26]
    mul.io_req_bits_b <= core.io_mul_req_bits_b @[Top.scala 55:26]
    mul.io_resp_ready <= core.io_mul_resp_ready @[Top.scala 56:30]
