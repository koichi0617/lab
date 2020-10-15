//-----------------------------------------------------------------------------
// Title         : SEQUENCER controller module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : SEQUENCER_CTRL.v
// Author        : Qian ZHAO <cho@ai.kyutech.ac.jp>
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
//      2019.08.21:  Added RESTART signal for restarting sequencer.
//-----------------------------------------------------------------------------
module SEQUENCER_CTRL(input wire CLK,
                      input wire RSTL,
                      input wire START,
                      input wire RESTART,
                      output wire BUSY,
                      output wire SEQ_PURGE,
                      input wire SEQ_LOAD_I,
                      input wire SEQ_FIN,
                      output wire MSTART,
                      input wire MBUSY,
                      output BANKI);
    
    reg         banki, mstart, busy, seq_purge;
    reg         start_latch, seq_load_i_latch;
    reg  [2:0]  state;
    localparam  IDLE         = 3'b000,
                START_LOADI  = 3'b001,
                LOADI_00     = 3'b010,
                LOADI_01     = 3'b011,
                START_EXE    = 3'b100,
                LOADI_10     = 3'b101,               
                EXE          = 3'b110,
                FIN          = 3'b111;
    
    // state control
    always@(posedge CLK)
    begin
        if (!RSTL)
        begin
            state <= IDLE;
        end
        else if (RESTART)
        begin
            state <= EXE;
        end
        else
        begin
            case(state)
                IDLE:
                    if (start_latch && !MBUSY)
                        state <= START_LOADI;
                START_LOADI:
                    state <= LOADI_00;
                LOADI_00:
                    state <= LOADI_01;
                LOADI_01:
                    if (!MBUSY)
                        state <= START_EXE;
                START_EXE:
                    state <= LOADI_10;
                LOADI_10:
                    state <= EXE;
                EXE:
                    if (SEQ_FIN)
                        state <= FIN;
                    else if (seq_load_i_latch && !MBUSY)
                        state <= START_EXE;
                FIN:
                    state <= IDLE;
                default:
                    state <= IDLE;
            endcase
        end
    end
                
    //BANKI
    always@(posedge CLK)
    begin
        if (!RSTL)
        begin
            banki <= 1'b0;
        end
        else
        begin
            case(state)
                START_EXE:
                    banki <= ~banki;
            endcase
        end
    end
                
    //PURGE
    always@(posedge CLK)
    begin
        if (!RSTL || RESTART)
        begin
            seq_purge <= 1'b1;
        end
        else
        begin
            case(state)
                EXE:
                    seq_purge <= 1'b0;
                default:
                    seq_purge <= 1'b1;
            endcase
        end
    end
                
    //MSTART
    always@(posedge CLK)
    begin
        if (!RSTL)
        begin
            mstart <= 1'b0;
        end
        else
        begin
            case(state)
                START_LOADI:
                    mstart <= 1'b1;
                START_EXE:
                    mstart <= 1'b1;
                default:
                    mstart <= 1'b0;
            endcase
        end
    end
                
    //BUSY
    always@(posedge CLK)
    begin
        if (!RSTL)
        begin
            busy <= 1'b0;
        end
        else
        begin
            case(state)
                IDLE:
                    busy <= 1'b0;
                default:
                    busy <= 1'b1;
            endcase
        end
    end

    // start_latch
    always@(posedge CLK)
    begin
        if (!RSTL)
        begin
            start_latch <= 1'b0;
        end
        else
        begin
            if(state == IDLE && START)
                start_latch <= 1'b1;
            else
                start_latch <= 1'b0;
        end
    end
            
    // seq_load_i_latch
    always@(posedge CLK)
    begin
        if (!RSTL)
        begin
            seq_load_i_latch <= 1'b0;
        end
        else
        begin
            if(state == EXE && SEQ_LOAD_I)
                seq_load_i_latch <= 1'b1;
            else
                seq_load_i_latch <= 1'b0;
        end
    end
                
    assign SEQ_PURGE = seq_purge;
    assign MSTART    = mstart;
    assign BANKI     = banki;
    assign BUSY      = busy;
endmodule
