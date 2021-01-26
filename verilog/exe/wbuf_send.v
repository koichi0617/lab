module wbuf_send(
	input wire CLK, 
	input wire RSTL,
	input wire WBUF_SEND,
	input wire [7:0] COUNTER0,
	input wire [15:0] RADDRX_I,
	input wire [5:0] WBUF_EN_CTRL_I,
	input wire module_busy,
	output wire [15:0] RADDRX,
	output wire RCEBX,
	output wire WBUF_EN,
	output wire [5:0] WBUF_EN_CTRL,
	output wire WBUF_BUSY
	);

	reg [15:0] 	pc;
	reg [2:0]   cnt;
	reg [7:0] 	counter0;
	reg [15:0] 	reg_raddrx;
	reg			reg_rcebx;
	reg 		reg_wbufen;
	reg [5:0]  	reg_wbufenctrl;


	assign RADDRX = reg_raddrx;
	assign WBUF_EN_CTRL = reg_wbufenctrl;
	assign WBUF_BUSY = (counter0 > 1 | |cnt) ? 1:0;
	assign RCEBX   = ~|counter0;
	assign WBUF_EN = |counter0;
	assign start = WBUF_SEND & !module_busy;

	//counter0
  	always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL) begin
			counter0 <= 0;
		end
		else if(start) begin
			counter0 <= COUNTER0;
		end
		else if(|counter0 && cnt == 3'b0) begin
			counter0 <= counter0 - 1;
		end
		else begin
			counter0 <= counter0;
		end
	end

	//cnt:アドレス用カウンタ
  	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)	
			cnt <= 0;
		else if(start)
			cnt <= 3'b100;
		else if(WBUF_BUSY && ~|cnt)
			cnt <= 3'b011;
		else if(WBUF_BUSY) begin
			cnt <= cnt - 1;
		end else
			cnt <= 0;
	end

	//RADDRX
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			reg_raddrx <= 1'd0;
		else if(start)
			reg_raddrx <= RADDRX_I;
		else if(WBUF_BUSY)
			reg_raddrx <= reg_raddrx + 1'd1;
		else
			reg_raddrx <= reg_raddrx;
    end

	//WBUF_EN_CTRL
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_wbufenctrl <= 1'd0;
		else if(start)
			reg_wbufenctrl <= WBUF_EN_CTRL_I;
		else if(WBUF_BUSY & ~|cnt)
			reg_wbufenctrl <= reg_wbufenctrl + 1'd1;
		else
			reg_wbufenctrl <= reg_wbufenctrl;
	end


endmodule