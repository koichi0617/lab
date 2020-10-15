//-----------------------------------------------------------------------------
// Title         : Memory to M_AXIS interface module
// Project       : ReNa Project
//-----------------------------------------------------------------------------
// File          : MEM_AXIS.v
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
//		2019.07.19 Fix for TLAST behavior
//		2019.07.28 Changed "addr_counter = addr_counter + 1;" to 
//				   "addr_counter <= addr_counter + 1;" by Qian Zhao
//-----------------------------------------------------------------------------
module MEM_AXIS #(parameter integer BITS = 128,
                  parameter integer WORDS = 8192,
                  parameter integer ADRS = 13)
                 (input wire ACLK,
                  input wire ARESETN,				   // system reset [active low]
				  // AXI Stream master interface
                  input wire M_AXIS_TREADY,
                  input wire [BITS-1:0] MDATA,         // 128-bit data width
				  output wire [BITS-1:0] M_AXIS_TDATA,
                  output wire M_AXIS_TLAST,
                  output wire M_AXIS_TVALID,
				  // Memory interface
                  input wire MRESET,                   // reset memory interface
                  input wire MSTART,                   // start transfer
                  output wire [ADRS-1:0] MADDR,        // 8192-word entries
                  output wire MBUSY);                  // BUSY state
    localparam IDLE = 2'b00,
    SEND = 2'b01,
    WAIT = 2'b11,
    LAST = 2'b10;
    
    reg  [1:0] 	   state;
    
    reg  [ADRS-1:0] addr_counter;
    wire            internal_reset;
    
    reg [BITS-1:0]  delayed_MDATA;  //  128-bit data width
    wire            tdata_hold;
    
    reg 		   delayed_tlast;
    wire 	   tlast;
    
    assign internal_reset = (!ARESETN || MRESET);
    
    // address counter
    always@(posedge ACLK)
    begin
        if (internal_reset)
        begin
            addr_counter <= { ADRS{1'b0} };
        end
        else
        begin
            case (state)
                IDLE:
                if (MSTART)
                    addr_counter <= addr_counter + 1;
                    SEND:
						if (M_AXIS_TREADY)
							addr_counter <= addr_counter + 1;
							//	       else
							//		 addr_counter = addr_counter - 1;
                	WAIT:
						if (M_AXIS_TREADY)
							addr_counter <= addr_counter + 1;
            endcase
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
					if (MSTART && M_AXIS_TREADY)
						state <= SEND;
					else if (MSTART && !M_AXIS_TREADY)
						state <= WAIT;
				SEND:
					if (!M_AXIS_TREADY)
						state <= WAIT;
					else if (tlast)
						state <= LAST;
				WAIT:
					if (M_AXIS_TREADY && !tlast)
						state <= SEND;
					else if (M_AXIS_TREADY && tlast)
						state <= LAST;
				LAST:
					if (M_AXIS_TREADY)
						state <= IDLE;
				default:
					state <= IDLE;
			endcase // case (state)
		end // else: !if(internal_sert)
	end // always@ (posedge ACLK)
                            
                            
	assign tdata_hold = ((state == IDLE) && !M_AXIS_TREADY && MSTART)
	|| ((state == SEND) && !M_AXIS_TREADY)
	|| ((state == LAST) && delayed_tlast);
									
	always @(posedge ACLK)
	begin
		if (internal_reset)
		begin
			delayed_MDATA <= { BITS{1'b0} };
		end
		else if (tdata_hold) // && (state != WAIT))
		begin
			delayed_MDATA <= MDATA;
		end
	end
	
	always @(posedge ACLK)
	begin
		delayed_tlast <= tlast;
	end

	assign M_AXIS_TDATA = ((state == WAIT) || (state == LAST && !delayed_tlast)) ? delayed_MDATA : MDATA;
	assign tlast = &addr_counter;		
	assign M_AXIS_TVALID = (state != IDLE) && M_AXIS_TREADY;
	assign M_AXIS_TLAST  = (state == LAST);
	assign MADDR = addr_counter;
	assign MBUSY = (state != IDLE);
				
endmodule
