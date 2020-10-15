module PB_ARRAY32x1(
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
input wire [63:0] NL_N,
input wire [63:0] NL_S,
input wire [1:0]  WBUF_I,
input wire [31:0] WBUF_EN,
input wire [31:0] WEIGHT_EN,
input wire [1:0]  CONFDATA_I,
input wire [1:0]  WEIGHT,
input wire [31:0] OUTPUT_EN,
output     [63:0] NL_N_OUT,
output     [63:0] NL_S_OUT,
output     [1:0]  OUTPUT
);

wire [1:0]  conf_00_01;
wire [31:0] nl_no_00, nl_no_01;
wire [1:0]  nl_eo_00, nl_eo_01;
wire [1:0]  nl_wo_00, nl_wo_01;
wire [31:0] nl_so_00, nl_so_01;

assign NL_N_OUT = {nl_no_00, nl_no_01};
assign NL_S_OUT = {nl_so_00, nl_so_01};

PB_ARRAY16x1 pb_16x1_00(
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
.WEIGHT_EN(WEIGHT_EN[15:0]),
.NL_N(NL_N[63:32]),
.NL_E(nl_wo_01),
.NL_W(2'b0),
.NL_S(NL_S[63:32]),
.WBUF_I(WBUF_I[1:0]),
.WBUF_EN(WBUF_EN[15:0]),
.CONFDATA_I(CONFDATA_I[1:0]),
.WEIGHT(WEIGHT[1:0]),
.OUTPUT_EN(OUTPUT_EN[15:0]),
//output
.NL_N_OUT(nl_no_00),
.NL_E_OUT(nl_eo_00),
.NL_W_OUT(nl_wo_00),
.NL_S_OUT(nl_so_00),
.OUTPUT(OUTPUT[1:0]),
.CONFDATA_O(conf_00_01)
);

PB_ARRAY16x1 pb_16x1_01(
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
.WEIGHT_EN(WEIGHT_EN[31:16]),
.NL_N(NL_N[31:0]),
.NL_E(2'b0),
.NL_W(nl_eo_00),
.NL_S(NL_S[31:0]),
.WBUF_I(WBUF_I[1:0]),
.WBUF_EN(WBUF_EN[31:16]),
.CONFDATA_I(conf_00_01),
.WEIGHT(WEIGHT[1:0]),
.OUTPUT_EN(OUTPUT_EN[31:16]),
//output
.NL_N_OUT(nl_no_01),
.NL_E_OUT(nl_eo_01),
.NL_W_OUT(nl_wo_01),
.NL_S_OUT(nl_so_01),
.OUTPUT(OUTPUT[1:0]),
.CONFDATA_O()
);

endmodule