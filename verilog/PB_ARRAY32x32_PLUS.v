//-----------------------------------------------------------------------------
// Title         : PB_ARRAY64x64_PLUS module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : PB_ARRAY64x64_PLUS.v
// Author        : Yasuhiro NAKAHARA <nakahara@arch.cs.kumamoto-u.ac.jp>
// Created       : 30.07.2019
// Last modified : 30.07.2019
//-----------------------------------------------------------------------------
// Description :
//
//-----------------------------------------------------------------------------
// Copyright (c) 2019 by Kumamoto Univ. This model is the confidential and
// proprietary property of Kumamoto Univ. and the possession or use of this
// file requires a written license from Kumamoto Univ.
//-----------------------------------------------------------------------------
// Modification history :
//-----------------------------------------------------------------------------
module PB_ARRAY32x32_PLUS(input wire CLK,
                          input wire RSTL,
                          input wire WBUF_PURGE,
                          input wire [63:0] WBUF_I,
                          input wire WBUF_EN,
                          input wire [4:0] WBUF_EN_CTRL,
                          input wire WBUF_ALL_EN,
                          input wire WBUF_SWITCH,
                          input wire [63:0] WEIGHT,
                          input wire FC_WEIGHT_EN,
                          input wire NL_EN,
                          input wire SHIFT_MODE,
                          input wire [1:0] NL_SEL,
                          input wire MAC_EN,
                          input wire RESULT_REQ,           // Outdata request (One hot)
                          input wire [3:0] OLSB,
                          input wire RESULT_PURGE,         // Purge request of all FF
                          input wire OUTPUT_EN,
                          input wire [4:0] OUTPUT_EN_CTRL,
                          input wire I_COMPARE_MODE,
                          input wire I_COMPARE_EN,
                          input wire I_COMPARE_SWITCH,
                          input wire O_COMPARE_MODE,
                          input wire O_COMPARE_EN,
                          input wire O_COMPARE_SWITCH,
                          input wire CAL_MODE,
                          input wire CONV_FC_MODE,         //1:FC 0:CONV
                          input wire FEEDBACK_MODE,
                          input wire CONF_EN,
                          input wire I_COMPARE_REGEN,
                          input wire [1:0] NL_LOOP_SEL,
                          output [63:0] OUTPUT);

wire [1023:0] WE;
wire [63:0]  WBI, WI, OUT, CONFDATA;
wire [31:0]   WBE, OE;


PB_ARRAY32x32 pb_32x32(
//FROM SEQENCER
.CLK(CLK),
.RSTL(RSTL),
.NL_EN(NL_EN),
.WBUF_PURGE(WBUF_PURGE),
.REGSWITCH(WBUF_SWITCH),
.CONF_EN(CONF_EN),
.NL_SEL(NL_SEL),
.SHIFT_MODE(SHIFT_MODE),
.CAL_MODE(CAL_MODE),
.CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
.MAC_EN_I(MAC_EN),
.RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
.OLSB(OLSB),
.RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
.FEEDBACK_MODE(FEEDBACK_MODE),
.NL_LOOP_SEL(NL_LOOP_SEL),
//FROM PB OR EXTERNAL BLOCK
.WEIGHT_EN(WE),
.WBUF_I(WBI),
.WBUF_EN(WBE),
.CONFDATA_I(CONFDATA),
.WEIGHT(WI),
.OUTPUT_EN(OE),
//output
.OUTPUT(OUT)
);

WBUF_DECODER W1 (
.D_IN(WBUF_EN_CTRL),
.D_EN(WBUF_EN),
.WBUF_ALL_EN(WBUF_ALL_EN),
.WBUF_EN(WBE)
);

WEIGHT_DECODERx32 D1 (
.CLK(CLK),
.RSTL(RSTL),
.CONV_FC_MODE(CONV_FC_MODE),//(0:conv, 1:fc)
.D_IN(WEIGHT),
.D_EN(FC_WEIGHT_EN),
.CONF_EN(CONF_EN),
.WEIGHT_EN(WE),
.D_OUT(WI),
.CONF_O(CONFDATA)
);


COMPARATORx32 C_IN(
.CLK(CLK),
.RSTL(RSTL),
.D_IN(WBUF_I),
.D_EN(I_COMPARE_REGEN),
.SWITCH(I_COMPARE_SWITCH),
.COMPARE_EN(I_COMPARE_EN),
.COMPARE_MODE(I_COMPARE_MODE),
.D_OUT(WBI)
);

COMPARATORx32 C_OUT(
.CLK(CLK),
.RSTL(RSTL),
.D_IN(OUT),
.D_EN(OUTPUT_EN),
.SWITCH(O_COMPARE_SWITCH),
.COMPARE_EN(O_COMPARE_EN),
.COMPARE_MODE(O_COMPARE_MODE),
.D_OUT(OUTPUT)
);

OUTPUT_DECODER O1 (
.D_IN(OUTPUT_EN_CTRL),
.D_EN(OUTPUT_EN),
.OUTPUT_EN(OE)
);

endmodule