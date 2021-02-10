//-----------------------------------------------------------------------------
// Title         : S_AXIS to Memmory Interface (non-pipeline version)
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : AXIS_MEM.v
// Author        : Morihiro KUGA <kuga@cs.kumamoto-u.ac.jp>
// Created       : 12.07.2019
// Last modified : 19.07.2019
//-----------------------------------------------------------------------------
// Description :
//
//-----------------------------------------------------------------------------
// Copyright (c) 2019 by Kumamoto Univ. This model is the confidential and
// proprietary property of Kumamoto Univ. and the possession or use of this
// file requires a written license from Kumamoto Univ.
//-----------------------------------------------------------------------------
// Modification history :
//		2019.07.19 add MWEN_ACTIVE
//-----------------------------------------------------------------------------
module AXIS_MEM #(parameter integer BITS = 128,         // Data width
                  parameter integer WORDS = 8192,       // Memory words
                  parameter integer ADRS = 13,          // Memory address bits
                  parameter integer MWEN_ACTIVE = 0)    // Active level of MWEN 0:Low, 1:High
                 (input wire ACLK,
                  input wire ARESETN,                 // system reset [active low]
                  // AXI Stream slave interface
                  input wire [BITS-1:0] S_AXIS_TDATA,
                  input wire S_AXIS_TLAST,
                  input wire S_AXIS_TVALID,
                  output wire S_AXIS_TREADY,
                  // Memory interface
                  input wire MRESET,                  // reset memory interface
                  input wire MSTART,                  // start transfer
                  output wire [ADRS-1:0] MADDR,       // 8192-word entries
                  output wire [BITS*2-1:0] MDATA,       // 128-bit data width
                  output wire MWEN,                   // write enable [Negative]
                  output wire MBUSY);                 // transfer busy
    
    localparam IDLE = 1'b0,
    SEND = 1'b1;
    
    reg        state;
    
    reg  [ADRS-1:0] addr_counter;
    wire            internal_reset;
    
    
    
    assign internal_reset = (!ARESETN | MRESET);
    
    // address counter
    always@(posedge ACLK)
    begin
        if (internal_reset)
        begin
            addr_counter <= { ADRS{1'b0} };
        end
        else
        begin
            if (S_AXIS_TVALID && S_AXIS_TREADY)
                addr_counter = addr_counter + 1;
        end // else: !if(!ARESETN || MRESET)
    end // always@ (posedge ACLK)
            
            
    // state control
    always@(posedge ACLK)
    begin
        if (internal_reset)
        begin
            state <= IDLE;
        end
        else
        begin
            case(state)
                IDLE:
                if (MSTART)
                    state <= SEND;
                SEND:
                if (S_AXIS_TVALID && S_AXIS_TREADY && S_AXIS_TLAST)
                    state <= IDLE;
            endcase // case (state)
        end // else: !if(internal_sert)
    end // always@ (posedge ACLK)
                
    assign S_AXIS_TREADY = (state == SEND);
    assign MADDR = addr_counter;
    assign MDATA = S_AXIS_TDATA;
    assign MWEN = (MWEN_ACTIVE) ?  (S_AXIS_TVALID & S_AXIS_TREADY) : ~(S_AXIS_TVALID & S_AXIS_TREADY);
    assign MBUSY = (state == SEND);
                
endmodule
