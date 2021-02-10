//-----------------------------------------------------------------------------
// Title         : Processing Element (Parallel MAC) module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : PE8.v
// Author        : Masahiro IIDA <iida@cs.kumamoto-u.ac.jp>
// Created       : 20.05.2019
// Last modified : 09.07.2019
//-----------------------------------------------------------------------------
// Description :
//
//-----------------------------------------------------------------------------
// Copyright (c) 2019 by Kumamoto Univ. This model is the confidential and
// proprietary property of Kumamoto Univ. and the possession or use of this
// file requires a written license from Kumamoto Univ.
//-----------------------------------------------------------------------------
// Modification history :
//      Rev.0.0 2019.05.20
//      Rev.0.3 2019.07.05
//      Rev.0.4 2019.07.08 Append Ceiling function to RF output
//      Rev.0.5 2019.07.09 Modified of output range check
//-----------------------------------------------------------------------------
module PE8(do,
           oe,
           xi,
           yi,
           en,
           orq,
           olsb,
           purge,
           clk,
           rstl);
    input [1:0] xi;
    input [1:0] yi;
    input en; // start singal (One hot)
    input orq; // Outdata request (One hot)
    input [3:0] olsb;
    input purge; // Purge request of all FF
    input clk;
    input rstl;
    
    output [1:0] do;
    output oe; // Out enable
    
    reg [16:0] RF; // result register of MAC
    wire [1:0] do; // outdata
    reg        oe; // outdata enable
    
    reg [2:0] psw; // PE status word([2]:udf, [1]:ovf, [0]:busy)
    
    reg [7:0] X;
    reg [7:0] Y;
    wire [16:0] maco; // out data of MAC
    
    reg [2:0] STC; // State Counter
    reg [1:0] ou_d; // Previous RF[17:16], overflow/underflow detect signgal
    reg       iden; // In data enable
    reg [1:0] outc; // outdata counter
    wire      ovfg; // Overflow flag
    wire      udfg; // Underflow flag
    // RF read
    assign do = {oe & RF[{outc,1'b1}], oe & RF[{outc,1'b0}]};
    
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)
            outc <= 2'b0;
        else if (purge)
            outc <= 2'b0;
        else if (oe)
            outc <= outc + 2'b1;
        else
            outc <= outc;
    end
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)
            oe <= 1'b0;
        else if (purge)
            oe <= 1'b0;
        else if (orq)
            oe <= 1'b1;
        else if (outc == 2'b11)
            oe <= 1'b0;
        else
            oe <= oe;
    end
    
    // Overflow/Underflow check
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)              ou_d <= 2'h0;
        else if (purge)         ou_d <= 2'h0;
        else if (STC == 3'b011) ou_d <= RF[16:15];
        else                   ou_d <= ou_d;
    end
    // Overflow flag
    assign ovfg = (STC == 3'b100)&&(ou_d == 2'b01)&&(maco[16:15] == 2'b10);
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)          psw[1] <= 1'b0;
        else if (purge)     psw[1] <= 1'b0;
        else if (ovfg)      psw[1] <= 1'b1;
        else               psw[1]  <= psw[1];
    end
    // Underflow flag
    assign udfg = (STC == 3'b100)&&(ou_d == 2'b10)&&(maco[16:15] == 2'b01);
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)          psw[2] <= 1'b0;
        else if (purge)     psw[2] <= 1'b0;
        else if (udfg)      psw[2] <= 1'b1;
        else               psw[2]  <= psw[2];
    end
    
    // Multiply and Add & RF write
    assign maco = func_mac(X, Y, RF);
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)              RF <= 17'h0;
        else if (purge)         RF <= 17'h0;
        else if (ovfg|psw[1])   RF <= 17'h0007f; // Overflow
        else if (udfg|psw[2])   RF <= 17'h00000; // Underflow
        else if (STC == 3'b100) RF <= maco;
        else if (orq)           RF <= func_readRF(psw, olsb, RF);
        else                   RF  <= RF;
    end
    
    // Serial data in
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)          X <= 8'h0;
        else if (purge)     X <= 8'h0;
        else if (en | iden) X <= {xi, X[7:2]};
        else               X  <= X;
    end
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)          Y <= 8'h0;
        else if (purge)     Y <= 8'h0;
        else if (en | iden) Y <= {yi, Y[7:2]};
        else               Y  <= Y;
    end
    
    // Control signal generate
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)              iden <= 1'b0;
        else if (purge)         iden <= 1'b0;
        else if (STC == 3'b011) iden <= 1'b0;
        else if (en)            iden <= 1'b1;
        else                   iden  <= iden;
    end
    // busy Flag; Operation in progress.
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)              psw[0] <= 1'b0;
        else if (purge)         psw[0] <= 1'b0;
        else if (STC == 3'b100) psw[0] <= 1'b0;
        else if (en)            psw[0] <= 1'b1;
        else                   psw[0]  <= psw[0];
    end
    always @(posedge clk or negedge rstl)
    begin
        if (!rstl)              STC <= 3'h0;
        else if (purge)         STC <= 3'h0;
        else if (STC == 3'b100) STC <= 3'h0;
        else if (en)            STC <= 3'h1;
        else if (psw[0])        STC <= STC + 3'h1;
        else                   STC  <= STC;
    end
    
    // Function define
    function [16:0] func_mac(
        input [7:0] X,
        input [7:0] Y,
        input [16:0] Z
        );
        begin
            func_mac = $signed(X) * $signed(Y) + $signed(Z);
        end
    endfunction // func_mac
    
    // Function RF read
    function [16:0] func_readRF(
        input [2:0] psw,
        input [3:0] olsb,
        input [16:0] RF
        );
        reg [16:0] RF_tmp;
        begin
            RF_tmp = RF >> olsb;
            if (RF[16])
                func_readRF = 17'h00000;
            else
                if (|RF_tmp[16:7])
                    func_readRF = 17'h0007f;
                else
                    func_readRF = {10'b0, RF_tmp[6:0]};
        end
    endfunction // func_readRF
    
endmodule
