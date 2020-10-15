module PB_ARRAY16x1(
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
//FROM PE OR EXTERNAL BLOCK
input wire [31:0] NL_N,
input wire [1:0]  NL_E,
input wire [1:0]  NL_W,
input wire [31:0] NL_S,
input wire [1:0]  WBUF_I,
input wire [15:0] WBUF_EN,
input wire [15:0] WEIGHT_EN,
input wire [1:0]  CONFDATA_I,
input wire [1:0]  WEIGHT,
input wire [15:0] OUTPUT_EN,
output     [31:0] NL_N_OUT,
output     [1:0]  NL_E_OUT,
output     [1:0]  NL_W_OUT,
output     [31:0] NL_S_OUT,
output     [1:0]  OUTPUT,
output     [1:0]  CONFDATA_O
);
wire [1:0] conf_0_1, conf_1_2, conf_2_3, conf_3_4, conf_4_5, conf_5_6, conf_6_7, conf_7_8, conf_8_9, conf_9_10, conf_10_11, conf_11_12, conf_12_13, conf_13_14, conf_14_15;
wire [1:0] nl_0_1, nl_1_2, nl_2_3, nl_3_4, nl_4_5, nl_5_6, nl_6_7, nl_7_8, nl_8_9, nl_9_10, nl_10_11, nl_11_12, nl_12_13, nl_13_14, nl_14_15;
wire [1:0] nl_o_0, nl_o_1, nl_o_2, nl_o_3, nl_o_4, nl_o_5, nl_o_6, nl_o_7, nl_o_8, nl_o_9, nl_o_10, nl_o_11, nl_o_12, nl_o_13, nl_o_14, nl_o_15;

assign NL_N_OUT = {nl_o_0, nl_o_1, nl_o_2, nl_o_3, nl_o_4, nl_o_5, nl_o_6, nl_o_7, nl_o_8, nl_o_9, nl_o_10, nl_o_11, nl_o_12, nl_o_13, nl_o_14, nl_o_15};
assign NL_S_OUT = {nl_o_0, nl_o_1, nl_o_2, nl_o_3, nl_o_4, nl_o_5, nl_o_6, nl_o_7, nl_o_8, nl_o_9, nl_o_10, nl_o_11, nl_o_12, nl_o_13, nl_o_14, nl_o_15};
assign NL_E_OUT = nl_o_15;
assign NL_W_OUT = nl_o_0;

PB PB0(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[31:30]),
  .NL_E(nl_o_1),
  .NL_W(NL_W),
  .NL_S(NL_S[31:30]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[0]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(CONFDATA_I), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[0]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[0]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_0_1),
  .NL_OUT(nl_o_0),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB1(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[29:28]),
  .NL_E(nl_o_2),
  .NL_W(nl_o_0),
  .NL_S(NL_S[29:28]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[1]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_0_1), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[1]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[1]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_1_2),
  .NL_OUT(nl_o_1),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB2(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[27:26]),
  .NL_E(nl_o_3),
  .NL_W(nl_o_1),
  .NL_S(NL_S[27:26]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[2]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_1_2), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[2]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[2]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_2_3),
  .NL_OUT(nl_o_2),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB3(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[25:24]),
  .NL_E(nl_o_4),
  .NL_W(nl_o_2),
  .NL_S(NL_S[25:24]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[3]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_2_3), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[3]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[3]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_3_4),
  .NL_OUT(nl_o_3),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB4(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[23:22]),
  .NL_E(nl_o_5),
  .NL_W(nl_o_3),
  .NL_S(NL_S[23:22]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[4]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_3_4), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[4]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[4]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_4_5),
  .NL_OUT(nl_o_4),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB5(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[21:20]),
  .NL_E(nl_o_6),
  .NL_W(nl_o_4),
  .NL_S(NL_S[21:20]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[5]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_4_5), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[5]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[5]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_5_6),
  .NL_OUT(nl_o_5),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB6(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[19:18]),
  .NL_E(nl_o_7),
  .NL_W(nl_o_5),
  .NL_S(NL_S[19:18]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[6]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_5_6), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[6]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[6]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_6_7),
  .NL_OUT(nl_o_6),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB7(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[17:16]),
  .NL_E(nl_o_8),
  .NL_W(nl_o_6),
  .NL_S(NL_S[17:16]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[7]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_6_7), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[7]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[7]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_7_8),
  .NL_OUT(nl_o_7),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB8(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[15:14]),
  .NL_E(nl_o_9),
  .NL_W(nl_o_7),
  .NL_S(NL_S[15:14]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[8]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_7_8), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[8]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[8]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_8_9),
  .NL_OUT(nl_o_8),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB9(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[13:12]),
  .NL_E(nl_o_10),
  .NL_W(nl_o_8),
  .NL_S(NL_S[13:12]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[9]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_8_9), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[9]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[9]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_9_10),
  .NL_OUT(nl_o_9),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB10(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[11:10]),
  .NL_E(nl_o_11),
  .NL_W(nl_o_9),
  .NL_S(NL_S[11:10]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[10]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_9_10), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[10]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[10]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_10_11),
  .NL_OUT(nl_o_10),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB11(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[9:8]),
  .NL_E(nl_o_12),
  .NL_W(nl_o_10),
  .NL_S(NL_S[9:8]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[11]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_10_11), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[11]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[11]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_11_12),
  .NL_OUT(nl_o_11),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB12(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[7:6]),
  .NL_E(nl_o_13),
  .NL_W(nl_o_11),
  .NL_S(NL_S[7:6]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[12]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_11_12), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[12]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[12]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_12_13),
  .NL_OUT(nl_o_12),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB13(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[5:4]),
  .NL_E(nl_o_14),
  .NL_W(nl_o_12),
  .NL_S(NL_S[5:4]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[13]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_12_13), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[13]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[13]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_13_14),
  .NL_OUT(nl_o_13),
  //pb
  .OUTPUT(OUTPUT)
);


PB PB14(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[3:2]),
  .NL_E(nl_o_15),
  .NL_W(nl_o_13),
  .NL_S(NL_S[3:2]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[14]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_13_14), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[14]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[14]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(conf_14_15),
  .NL_OUT(nl_o_14),
  //pb
  .OUTPUT(OUTPUT)
);

PB PB15(
  //ctrl signal for all PB
  .CLK(CLK),
  .RSTL(RSTL),
  //input_ctrl
  .WBUF_PURGE(WBUF_PURGE),
  .NL_N(NL_N[1:0]),
  .NL_E(NL_E),
  .NL_W(nl_o_14),
  .NL_S(NL_S[1:0]),
  .NL_EN(NL_EN),
  .WBUF_I(WBUF_I),
  .WBUF_EN(WBUF_EN[15]),
  .REGSWITCH(REGSWITCH),
  .CONFDATA_I(conf_14_15), 
  .CONF_EN(CONF_EN),
  .NL_SEL(NL_SEL),
  .SHIFT_MODE(SHIFT_MODE),
  //WEIGHT_ctrl
  .WEIGHT(WEIGHT),
  .WEIGHT_EN(WEIGHT_EN[15]),
  .CAL_MODE(CAL_MODE),
  .CONV_FC_MODE(CONV_FC_MODE),
  .MAC_EN_I(MAC_EN_I),
  //output_ctrl
  .OUTPUT_EN(OUTPUT_EN[15]),
  //mac
  .RESULT_REQ(RESULT_REQ),
  .OLSB(OLSB),
  .RESULT_PURGE(RESULT_PURGE),
  //pb
  .FEEDBACK_MODE(FEEDBACK_MODE),
  //input_ctrl
  .CONFDATA_O(CONFDATA_O),
  .NL_OUT(nl_o_15),
  //pb
  .OUTPUT(OUTPUT)
);

endmodule
