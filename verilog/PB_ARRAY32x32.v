module PB_ARRAY32x32(
//FROM SEQENCER
input wire        CLK,
input wire        RSTL,
input wire        WBUF_PURGE,
input wire        NL_EN,
input wire        REGSWITCH,
input wire        CONF_EN,
input wire [1:0]  NL_SEL,
input wire        SHIFT_MODE,
input wire        CAL_MODE,
input wire        CONV_FC_MODE, //1:FC 0:CONV
input wire        MAC_EN_I,
input wire        RESULT_REQ, // Outdata request (One hot)
input wire [3:0]  OLSB,
input wire        RESULT_PURGE, // Purge request of all FF
input wire        FEEDBACK_MODE,
input wire [1:0]  NL_LOOP_SEL,
//FROM PE OR EXTERNAL BLOCK
input wire [63:0]  WBUF_I,
input wire [31:0] WBUF_EN,
input wire [1023:0] WEIGHT_EN,
input wire [63:0]  CONFDATA_I,
input wire [63:0]  WEIGHT,
input wire [31:0] OUTPUT_EN,
output     [63:0]  OUTPUT
);

wire [63:0] nl_no_0, nl_no_1, nl_no_2, nl_no_3, nl_no_4, nl_no_5, nl_no_6, nl_no_7,
             nl_no_8, nl_no_9, nl_no_10, nl_no_11, nl_no_12, nl_no_13, nl_no_14, nl_no_15,
             nl_no_16, nl_no_17, nl_no_18, nl_no_19, nl_no_20, nl_no_21, nl_no_22, nl_no_23,
             nl_no_24, nl_no_25, nl_no_26, nl_no_27, nl_no_28, nl_no_29, nl_no_30, nl_no_31;

wire [63:0] nl_so_0, nl_so_1, nl_so_2, nl_so_3, nl_so_4, nl_so_5, nl_so_6, nl_so_7,
             nl_so_8, nl_so_9, nl_so_10, nl_so_11, nl_so_12, nl_so_13, nl_so_14, nl_so_15,
             nl_so_16, nl_so_17, nl_so_18, nl_so_19, nl_so_20, nl_so_21, nl_so_22, nl_so_23,
             nl_so_24, nl_so_25, nl_so_26, nl_so_27, nl_so_28, nl_so_29, nl_so_30, nl_so_31;



PB_ARRAY32x1 pb_32x1_0(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[31:0]),
.NL_N(nl_so_31),
.NL_S(nl_no_1),
.WBUF_I(WBUF_I[1:0]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[1:0]),
.WEIGHT(WEIGHT[1:0]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_0),
.NL_S_OUT(nl_so_0),
.OUTPUT(OUTPUT[1:0])
);

PB_ARRAY32x1 pb_32x1_1(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[63:32]),
.NL_N(nl_so_0),
.NL_S(nl_no_2),
.WBUF_I(WBUF_I[3:2]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[3:2]),
.WEIGHT(WEIGHT[3:2]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_1),
.NL_S_OUT(nl_so_1),
.OUTPUT(OUTPUT[3:2])
);

PB_ARRAY32x1 pb_32x1_2(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[95:64]),
.NL_N(nl_so_1),
.NL_S(nl_no_3),
.WBUF_I(WBUF_I[5:4]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[5:4]),
.WEIGHT(WEIGHT[5:4]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_2),
.NL_S_OUT(nl_so_2),
.OUTPUT(OUTPUT[5:4])
);

PB_ARRAY32x1 pb_32x1_3(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[127:96]),
.NL_N(nl_so_2),
.NL_S(nl_no_4),
.WBUF_I(WBUF_I[7:6]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[7:6]),
.WEIGHT(WEIGHT[7:6]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_3),
.NL_S_OUT(nl_so_3),
.OUTPUT(OUTPUT[7:6])
);

PB_ARRAY32x1 pb_32x1_4(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[159:128]),
.NL_N(nl_so_3),
.NL_S(nl_no_5),
.WBUF_I(WBUF_I[9:8]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[9:8]),
.WEIGHT(WEIGHT[9:8]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_4),
.NL_S_OUT(nl_so_4),
.OUTPUT(OUTPUT[9:8])
);

PB_ARRAY32x1 pb_32x1_5(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[191:160]),
.NL_N(nl_so_4),
.NL_S(nl_no_6),
.WBUF_I(WBUF_I[11:10]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[11:10]),
.WEIGHT(WEIGHT[11:10]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_5),
.NL_S_OUT(nl_so_5),
.OUTPUT(OUTPUT[11:10])
);

PB_ARRAY32x1 pb_32x1_6(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[223:192]),
.NL_N(nl_so_5),
.NL_S(nl_no_7),
.WBUF_I(WBUF_I[13:12]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[13:12]),
.WEIGHT(WEIGHT[13:12]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_6),
.NL_S_OUT(nl_so_6),
.OUTPUT(OUTPUT[13:12])
);

PB_ARRAY32x1 pb_32x1_7(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[255:224]),
.NL_N(nl_so_6),
.NL_S(nl_no_8),
.WBUF_I(WBUF_I[15:14]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[15:14]),
.WEIGHT(WEIGHT[15:14]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_7),
.NL_S_OUT(nl_so_7),
.OUTPUT(OUTPUT[15:14])
);

PB_ARRAY32x1 pb_32x1_8(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[287:256]),
.NL_N(nl_so_7),
.NL_S(nl_no_9),
.WBUF_I(WBUF_I[17:16]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[17:16]),
.WEIGHT(WEIGHT[17:16]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_8),
.NL_S_OUT(nl_so_8),
.OUTPUT(OUTPUT[17:16])
);

PB_ARRAY32x1 pb_32x1_9(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[319:288]),
.NL_N(nl_so_8),
.NL_S(nl_no_10),
.WBUF_I(WBUF_I[19:18]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[19:18]),
.WEIGHT(WEIGHT[19:18]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_9),
.NL_S_OUT(nl_so_9),
.OUTPUT(OUTPUT[19:18])
);

PB_ARRAY32x1 pb_32x1_10(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[351:320]),
.NL_N(nl_so_9),
.NL_S(nl_no_11),
.WBUF_I(WBUF_I[21:20]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[21:20]),
.WEIGHT(WEIGHT[21:20]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_10),
.NL_S_OUT(nl_so_10),
.OUTPUT(OUTPUT[21:20])
);

PB_ARRAY32x1 pb_32x1_11(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[383:352]),
.NL_N(nl_so_10),
.NL_S(nl_no_12),
.WBUF_I(WBUF_I[23:22]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[23:22]),
.WEIGHT(WEIGHT[23:22]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_11),
.NL_S_OUT(nl_so_11),
.OUTPUT(OUTPUT[23:22])
);

PB_ARRAY32x1 pb_32x1_12(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[415:384]),
.NL_N(nl_so_11),
.NL_S(nl_no_13),
.WBUF_I(WBUF_I[25:24]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[25:24]),
.WEIGHT(WEIGHT[25:24]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_12),
.NL_S_OUT(nl_so_12),
.OUTPUT(OUTPUT[25:24])
);

PB_ARRAY32x1 pb_32x1_13(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[447:416]),
.NL_N(nl_so_12),
.NL_S(nl_no_14),
.WBUF_I(WBUF_I[27:26]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[27:26]),
.WEIGHT(WEIGHT[27:26]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_13),
.NL_S_OUT(nl_so_13),
.OUTPUT(OUTPUT[27:26])
);

PB_ARRAY32x1 pb_32x1_14(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[479:448]),
.NL_N(nl_so_13),
.NL_S(nl_no_15),
.WBUF_I(WBUF_I[29:28]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[29:28]),
.WEIGHT(WEIGHT[29:28]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_14),
.NL_S_OUT(nl_so_14),
.OUTPUT(OUTPUT[29:28])
);

PB_ARRAY32x1 pb_32x1_15(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[511:480]),
.NL_N(nl_so_14),
.NL_S(nl_no_16),
.WBUF_I(WBUF_I[31:30]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[31:30]),
.WEIGHT(WEIGHT[31:30]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_15),
.NL_S_OUT(nl_so_15),
.OUTPUT(OUTPUT[31:30])
);

PB_ARRAY32x1 pb_32x1_16(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[543:512]),
.NL_N(nl_so_15),
.NL_S(nl_no_17),
.WBUF_I(WBUF_I[33:32]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[33:32]),
.WEIGHT(WEIGHT[33:32]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_16),
.NL_S_OUT(nl_so_16),
.OUTPUT(OUTPUT[33:32])
);

PB_ARRAY32x1 pb_32x1_17(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[575:544]),
.NL_N(nl_so_16),
.NL_S(nl_no_18),
.WBUF_I(WBUF_I[35:34]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[35:34]),
.WEIGHT(WEIGHT[35:34]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_17),
.NL_S_OUT(nl_so_17),
.OUTPUT(OUTPUT[35:34])
);

PB_ARRAY32x1 pb_32x1_18(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[607:576]),
.NL_N(nl_so_17),
.NL_S(nl_no_19),
.WBUF_I(WBUF_I[37:36]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[37:36]),
.WEIGHT(WEIGHT[37:36]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_18),
.NL_S_OUT(nl_so_18),
.OUTPUT(OUTPUT[37:36])
);

PB_ARRAY32x1 pb_32x1_19(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[639:608]),
.NL_N(nl_so_18),
.NL_S(nl_no_20),
.WBUF_I(WBUF_I[39:38]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[39:38]),
.WEIGHT(WEIGHT[39:38]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_19),
.NL_S_OUT(nl_so_19),
.OUTPUT(OUTPUT[39:38])
);

PB_ARRAY32x1 pb_32x1_20(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[671:640]),
.NL_N(nl_so_19),
.NL_S(nl_no_21),
.WBUF_I(WBUF_I[41:40]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[41:40]),
.WEIGHT(WEIGHT[41:40]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_20),
.NL_S_OUT(nl_so_20),
.OUTPUT(OUTPUT[41:40])
);

PB_ARRAY32x1 pb_32x1_21(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[703:672]),
.NL_N(nl_so_20),
.NL_S(nl_no_22),
.WBUF_I(WBUF_I[43:42]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[43:42]),
.WEIGHT(WEIGHT[43:42]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_21),
.NL_S_OUT(nl_so_21),
.OUTPUT(OUTPUT[43:42])
);

PB_ARRAY32x1 pb_32x1_22(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[735:704]),
.NL_N(nl_so_21),
.NL_S(nl_no_23),
.WBUF_I(WBUF_I[45:44]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[45:44]),
.WEIGHT(WEIGHT[45:44]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_22),
.NL_S_OUT(nl_so_22),
.OUTPUT(OUTPUT[45:44])
);

PB_ARRAY32x1 pb_32x1_23(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[767:736]),
.NL_N(nl_so_22),
.NL_S(nl_no_24),
.WBUF_I(WBUF_I[47:46]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[47:46]),
.WEIGHT(WEIGHT[47:46]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_23),
.NL_S_OUT(nl_so_23),
.OUTPUT(OUTPUT[47:46])
);

PB_ARRAY32x1 pb_32x1_24(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[799:768]),
.NL_N(nl_so_23),
.NL_S(nl_no_25),
.WBUF_I(WBUF_I[49:48]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[49:48]),
.WEIGHT(WEIGHT[49:48]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_24),
.NL_S_OUT(nl_so_24),
.OUTPUT(OUTPUT[49:48])
);

PB_ARRAY32x1 pb_32x1_25(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[831:800]),
.NL_N(nl_so_24),
.NL_S(nl_no_26),
.WBUF_I(WBUF_I[51:50]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[51:50]),
.WEIGHT(WEIGHT[51:50]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_25),
.NL_S_OUT(nl_so_25),
.OUTPUT(OUTPUT[51:50])
);

PB_ARRAY32x1 pb_32x1_26(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[863:832]),
.NL_N(nl_so_25),
.NL_S(nl_no_27),
.WBUF_I(WBUF_I[53:52]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[53:52]),
.WEIGHT(WEIGHT[53:52]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_26),
.NL_S_OUT(nl_so_26),
.OUTPUT(OUTPUT[53:52])
);

PB_ARRAY32x1 pb_32x1_27(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[895:864]),
.NL_N(nl_so_26),
.NL_S(nl_no_28),
.WBUF_I(WBUF_I[55:54]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[55:54]),
.WEIGHT(WEIGHT[55:54]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_27),
.NL_S_OUT(nl_so_27),
.OUTPUT(OUTPUT[55:54])
);

PB_ARRAY32x1 pb_32x1_28(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[927:896]),
.NL_N(nl_so_27),
.NL_S(nl_no_29),
.WBUF_I(WBUF_I[57:56]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[57:56]),
.WEIGHT(WEIGHT[57:56]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_28),
.NL_S_OUT(nl_so_28),
.OUTPUT(OUTPUT[57:56])
);

PB_ARRAY32x1 pb_32x1_29(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[959:928]),
.NL_N(nl_so_28),
.NL_S(nl_no_30),
.WBUF_I(WBUF_I[59:58]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[59:58]),
.WEIGHT(WEIGHT[59:58]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_29),
.NL_S_OUT(nl_so_29),
.OUTPUT(OUTPUT[59:58])
);

PB_ARRAY32x1 pb_32x1_30(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[991:960]),
.NL_N(nl_so_29),
.NL_S(nl_no_31),
.WBUF_I(WBUF_I[61:60]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[61:60]),
.WEIGHT(WEIGHT[61:60]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_30),
.NL_S_OUT(nl_so_30),
.OUTPUT(OUTPUT[61:60])
);

PB_ARRAY32x1 pb_32x1_31(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(REGSWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN_I),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
//FROM PE OR EXTERNAL BLOCK
.WEIGHT_EN(WEIGHT_EN[1023:992]),
.NL_N(nl_so_30),
.NL_S(nl_no_0),
.WBUF_I(WBUF_I[63:62]),
.WBUF_EN(WBUF_EN),
.CONFDATA_I(CONFDATA_I[63:62]),
.WEIGHT(WEIGHT[63:62]),
.OUTPUT_EN(OUTPUT_EN),
//output
.NL_N_OUT(nl_no_31),
.NL_S_OUT(nl_so_31),
.OUTPUT(OUTPUT[63:62])
);


endmodule
