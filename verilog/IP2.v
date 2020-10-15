//-----------------------------------------------------------------------------
// Title         : TOP module of ReNa DPU process
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : IP2.v
// Author        : Qian ZHAO <cho@ai.kyutech.ac.jp>
//                 Yasuhiro NAKAHARA <nakahara@arch.cs.kumamoto-u.ac.jp>
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
module IP2(input CLK,
           input RSTL,
           input PURGE,
           input DPU_START,
            input DPU_RESTART,
           input [127:0] S_AXIS_I_TDATA,
           input S_AXIS_I_TLAST,
           input S_AXIS_I_TVALID,
           input [63:0] S_AXIS_W_TDATA,
           input S_AXIS_W_TLAST,
           input S_AXIS_W_TVALID,
           input [63:0] S_AXIS_X_TDATA,
           input S_AXIS_X_TLAST,
           input S_AXIS_X_TVALID,
           input M_AXIS_X_TREADY,
           output DPU_BUSY,
           output S_AXIS_I_TREADY,
           output S_AXIS_W_TREADY,
           output S_AXIS_X_TREADY,
           output [63:0] M_AXIS_X_TDATA,
           output M_AXIS_X_TLAST,
           output M_AXIS_X_TVALID);
    
    wire         MEMI_BUSY, MEMW_BUSY, MEMX_BUSY;
    wire [127:0] DI;
    wire [63:0]  DW, DX;
    wire [13:0]  WADDRI, WADDRW, WADDRX0;
    wire [13:0]  RADDRX0;
    wire         WCEBI, WCEBW, WCEBX0, WCEBX1;
    wire         RCEBX0, RCEBX1;
    wire [63:0] RX;
    
    //PB ARRAY wire
    wire [255:0] QI;
    wire [63:0] WBUF_I, WEIGHT, OUTPUT;
    wire [5:0]   WBUF_EN_CTRL, OUTPUT_EN_CTRL;
    wire [3:0]   OLSB;
    wire [1:0]   NL_SEL, NL_LOOP_SEL;
    wire WBUF_PURGE, WBUF_EN, WBUF_ALL_EN, WBUF_SWITCH, FC_WEIGHT_EN, NL_EN, SHIFT_MODE, MAC_EN,
    RESULT_REQ, RESULT_PURGE, OUTPUT_EN, I_COMPARE_MODE, I_COMPARE_EN, I_COMPARE_SWITCH,
    O_COMPARE_MODE, O_COMPARE_EN, O_COMPARE_SWITCH, CAL_MODE, CONV_FC_MODE, FEEDBACK_MODE, CONF_EN, I_COMPARE_REGEN;
    
    //Others wire
    wire [15:0]  RADDRX1, RADDRW, RADDRI, WADDRX1;
    wire BANKI, BANKX, BANKW;
    wire CTRL_STARTI, SEQ_STARTW, SEQ_STARTX, SEQ_STARTX_OUT;
    wire SEQ_LOAD_I, SEQ_FIN;
    
    PB_ARRAY32x32_PLUS pb_array_plus_0(
    .CLK(CLK),
    .RSTL(RSTL),
    .WBUF_PURGE(WBUF_PURGE),
    .WBUF_I(WBUF_I),
    .WBUF_EN(WBUF_EN),
    .WBUF_EN_CTRL(WBUF_EN_CTRL[4:0]),
    .WBUF_ALL_EN(WBUF_ALL_EN),
    .WBUF_SWITCH(WBUF_SWITCH),
    .WEIGHT(WEIGHT),
    .FC_WEIGHT_EN(FC_WEIGHT_EN),
    .NL_EN(NL_EN),
    .SHIFT_MODE(SHIFT_MODE),
    .NL_SEL(NL_SEL),
    .MAC_EN(MAC_EN),
    .RESULT_REQ(RESULT_REQ), // Outdata request (One hot)
    .OLSB(OLSB),
    .RESULT_PURGE(RESULT_PURGE), // Purge request of all FF
    .OUTPUT_EN(OUTPUT_EN),
    .OUTPUT_EN_CTRL(OUTPUT_EN_CTRL[4:0]),
    .I_COMPARE_MODE(I_COMPARE_MODE),
    .I_COMPARE_EN(I_COMPARE_EN),
    .I_COMPARE_SWITCH(I_COMPARE_SWITCH),
    .O_COMPARE_MODE(O_COMPARE_MODE),
    .O_COMPARE_EN(O_COMPARE_EN),
    .O_COMPARE_SWITCH(O_COMPARE_SWITCH),
    .CAL_MODE(CAL_MODE),
    .CONV_FC_MODE(CONV_FC_MODE), //1:FC 0:CONV
    .FEEDBACK_MODE(FEEDBACK_MODE),
    .CONF_EN(CONF_EN),
    .I_COMPARE_REGEN(I_COMPARE_REGEN),
    .NL_LOOP_SEL(NL_LOOP_SEL),
    .OUTPUT(OUTPUT)
    );
    
    SEQUENCER sequencer_0(
    .CLK(CLK),
    .RSTL(RSTL),
    .PURGE(SEQ_PURGE),
    //MEM BUSY
    .MBUSYW(MEMW_BUSY),
    .MBUSYXI(MEMX_BUSY),
    .MBUSYXO(MEMX_BUSY_OUT),
    //MEM Control for I
    .QI(QI),
    .RADDRI(RADDRI),
    .RCEBI(RCEBI),
    //MEM ADDR for X,W
    .RADDRX(RADDRX1),
    .RADDRW(RADDRW),
    .WADDRX(WADDRX1),
    //CTRL pins
    .BANKX(BANKX),
    .BANKW(BANKW),
    .RCEBX(RCEBX1),
    .WCEBX(WCEBX1),
    .RCEBW(RCEBW),
    .REQW(REQW),
    .WBUF_PURGE(WBUF_PURGE),
    .WBUF_EN(WBUF_EN),
    .WBUF_EN_CTRL(WBUF_EN_CTRL),
    .WBUF_ALL_EN(WBUF_ALL_EN),
    .WBUF_SWITCH(WBUF_SWITCH),
    .FC_WEIGHT_EN(FC_WEIGHT_EN),
    .NL_EN(NL_EN),
    .SHIFT_MODE(SHIFT_MODE),
    .NL_SEL(NL_SEL),
    .MAC_EN(MAC_EN),
    .RESULT_REQ(RESULT_REQ),
    .OLSB(OLSB),
    .RESULT_PURGE(RESULT_PURGE),
    .OUTPUT_EN(OUTPUT_EN),
    .OUTPUT_EN_CTRL(OUTPUT_EN_CTRL),
    .I_COMPARE_EN(I_COMPARE_EN),
    .I_COMPARE_MODE(I_COMPARE_MODE),
    .I_COMPARE_SWITCH(I_COMPARE_SWITCH),
    .O_COMPARE_EN(O_COMPARE_EN),
    .O_COMPARE_MODE(O_COMPARE_MODE),
    .O_COMPARE_SWITCH(O_COMPARE_SWITCH),
    .CAL_MODE(CAL_MODE),
    .CONV_FC_MODE(CONV_FC_MODE),
    .FEEDBACK_MODE(FEEDBACK_MODE),
    .CONF_EN(CONF_EN),
    .I_COMPARE_REGEN(I_COMPARE_REGEN),
    .NL_LOOP_SEL(NL_LOOP_SEL),
    .SEQ_LOAD_I(SEQ_LOAD_I),
    .SEQ_FIN(SEQ_FIN),
    .SEQ_STARTW(SEQ_STARTW),
    .SEQ_STARTX(SEQ_STARTX),
    .SEQ_STARTX_OUT(SEQ_STARTX_OUT),
    .RCEBX0(RCEBX0)
    );
    
    SEQUENCER_CTRL sequencer_ctrl_0(
    .CLK(CLK),
    .RSTL(RSTL),
    .START(DPU_START),
    .RESTART(DPU_RESTART),
    .BUSY(DPU_BUSY),
    .SEQ_PURGE(SEQ_PURGE),
    .SEQ_LOAD_I(SEQ_LOAD_I),
    .SEQ_FIN(SEQ_FIN),
    .MSTART(CTRL_STARTI),
    .MBUSY(MEMI_BUSY),
    .BANKI(BANKI)
    );
    
    AXIS_MEM axis_mem_i(
    .ACLK(CLK),
    .ARESETN(RSTL),
    .S_AXIS_TDATA(S_AXIS_I_TDATA),
    .S_AXIS_TREADY(S_AXIS_I_TREADY),
    .S_AXIS_TLAST(S_AXIS_I_TLAST),
    .S_AXIS_TVALID(S_AXIS_I_TVALID),
    .MADDR(WADDRI[12:0]),
    .MDATA(DI),
    .MWEN(WCEBI),
    .MRESET(PURGE),
    .MSTART(CTRL_STARTI),
    .MBUSY(MEMI_BUSY)
    );
    
    MEMI memi_0(
    .CLK(CLK),
    .RA(RADDRI[13:0]),
    .WA({1'b0, WADDRI[12:0]}),
    .DW(DI),
    .RCEB(RCEBI),
    .WCEB(WCEBI),
    .BANK(BANKI),
    .QW(QI)
    );
    
    AXIS_MEM #(.BITS(64))
     axis_mem_w(
    .ACLK(CLK),
    .ARESETN(RSTL),
    .S_AXIS_TDATA(S_AXIS_W_TDATA),
    .S_AXIS_TREADY(S_AXIS_W_TREADY),
    .S_AXIS_TLAST(S_AXIS_W_TLAST),
    .S_AXIS_TVALID(S_AXIS_W_TVALID),
    .MADDR(WADDRW[12:0]),
    .MDATA(DW),
    .MWEN(WCEBW),
    .MRESET(PURGE),
    .MSTART(SEQ_STARTW),
    .MBUSY(MEMW_BUSY)
    );
    
    MEMW memw_0(
    .CLK(CLK),
    .RA(RADDRW[13:0]),
    .WA({1'b0, WADDRW[12:0]}),
    .DW(DW),
    .RCEB(RCEBW),
    .WCEB(WCEBW),
    .BANK(BANKW),
    .QW(WEIGHT)
    );
    
    AXIS_MEM #(.BITS(64))
     axis_mem_x(
    .ACLK(CLK),
    .ARESETN(RSTL),
    .S_AXIS_TDATA(S_AXIS_X_TDATA),
    .S_AXIS_TREADY(S_AXIS_X_TREADY),
    .S_AXIS_TLAST(S_AXIS_X_TLAST),
    .S_AXIS_TVALID(S_AXIS_X_TVALID),
    .MADDR(WADDRX0[12:0]),
    .MDATA(DX),
    .MWEN(WCEBX0),
    .MRESET(PURGE),
    .MSTART(SEQ_STARTX),
    .MBUSY(MEMX_BUSY)
    );
    
    MEM_AXIS #(.BITS(64))
     mem_axis_x(
    .ACLK(CLK),
    .ARESETN(RSTL),
    .M_AXIS_TDATA(M_AXIS_X_TDATA),
    .M_AXIS_TREADY(M_AXIS_X_TREADY),
    .M_AXIS_TLAST(M_AXIS_X_TLAST),
    .M_AXIS_TVALID(M_AXIS_X_TVALID),
    .MADDR(RADDRX0[12:0]),
    .MDATA(RX),
    .MRESET(PURGE),
    .MSTART(SEQ_STARTX_OUT),
    .MBUSY(MEMX_BUSY_OUT)
    );
    
    MEMX memx_0(
    .CLK(CLK),
    .RA0({1'b0, RADDRX0[12:0]}),
    .RA1({1'b0, RADDRX1[12:0]}),
    .WA0({1'b0, WADDRX0[12:0]}),
    .WA1({1'b0, WADDRX1[12:0]}),
    .DX(DX),
    .OX(OUTPUT),
    .RCEB0(RCEBX0),
    .RCEB1(RCEBX1),
    .WCEB0(WCEBX0),
    .WCEB1(WCEBX1),
    .BANK(BANKX),
    .QX(WBUF_I),
    .RX(RX)
    );
    
endmodule
