module wbuf_send(
	input wire CLK, 
	input wire RSTL,
	input wire WBUF_SEND,
	input wire [7:0] COUNTER0,
	output wire [15:0] RADDRX,
	output wire RCEBX,
	output wire WBUF_EN,
	output wire [5:0] WBUF_EN_CTRL,
	output wire [7:0] COUNTER_END
	);

	reg [15:0] 	pc;
	reg [2:0]	cnt;
	reg [7:0] 	counter0;
	reg [15:0] 	reg_raddrx;
	reg			reg_rcebx;
	reg 		reg_wbufen;
	reg [5:0]  	reg_wbufenctrl;

	assign RADDRX = reg_raddrx;
	assign RCEBX = reg_rcebx;
	assign WBUF_EN = reg_wbufen;
	assign WBUF_EN_CTRL = reg_wbufenctrl;
	assign COUNTER_END = counter0;

	//RADDRX
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			reg_raddrx <= 1'd0;
		else if(COUNTER0)
			reg_raddrx <= reg_raddrx + 1'd1;
		else
			reg_raddrx <= reg_raddrx;
    end

	//WBUF_EN_CTRL
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_wbufenctrl <= 1'd0;
		else if(COUNTER0) begin
			if(counter0 != 1 && cnt == 3'b100)
				reg_wbufenctrl <= reg_wbufenctrl + 1'd1;
			else
				reg_wbufenctrl <= reg_wbufenctrl;
		end else
			reg_wbufenctrl <= reg_wbufenctrl;
	end

	//counter0
  	always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL)
			counter0 <= 1'd0;
		else if(WBUF_SEND) begin
			if(counter0 == 1'd0)
				counter0 <= COUNTER0;
		end else if(cnt == 3'b100)
			counter0 <= counter0 - 1;
		else
			counter0 <= counter0;
	end

	//cnt:アドレス用カウンタ(4サイクル)
  	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			cnt <= 3'b000;
		else if(COUNTER0) begin
			if(cnt == 3'b100) begin
				if(counter0 == 16'd1)
					cnt <= 3'b000;
				else
					cnt <= 3'b001;
			end else
        		cnt <= cnt + 1;
		end else
			cnt <= 3'b000;
	end

	//RCEBX
  	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			reg_rcebx <= 1;
		else if(COUNTER0)
      		reg_rcebx <= 0;
		else
			reg_rcebx <= 1;
	end

	//WBUF_EN
  	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			reg_wbufen <= 3'b000;
		else if(COUNTER0)
      		reg_wbufen <= 1;
		else
			reg_wbufen <= 0;
	end


endmodule