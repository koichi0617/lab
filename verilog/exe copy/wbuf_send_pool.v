module wbuf_send_pool(
	input wire CLK, 
	input wire RSTL,
	input wire WBUF_SEND_POOL,
	input wire [7:0] COUNTER0,
	input wire [15:0] RADDRX_I,
	input wire [5:0] WBUF_EN_CTRL_I,
	input wire module_busy,
	output wire [15:0] RADDRX,
	output wire RCEBX,
	output wire WBUF_EN,
	output wire [5:0] WBUF_EN_CTRL,
	output wire I_COMPARE_EN,
	output wire I_COMPARE_MODE,
	output wire I_COMPARE_REGEN,
	output wire I_COMPARE_SWITCH,
	output wire WBUF_POOL_BUSY
	);

	reg [15:0] 	pc;
	reg [3:0]   cnt;
	reg [7:0] 	counter0;
	reg [15:0] 	reg_raddrx;
	reg [5:0]  	reg_wbufenctrl;
	reg reg_wbufen;
	reg reg_rcebx;
	reg reg_c_regen;
	reg reg_c_switch;
	reg reg_c_en;


	assign RADDRX = reg_raddrx;
	assign WBUF_EN = reg_wbufen;
	assign WBUF_EN_CTRL = reg_wbufenctrl;
	assign RCEBX = reg_rcebx;
	assign I_COMPARE_MODE = |counter0;
	assign I_COMPARE_REGEN = reg_c_regen;
	assign I_COMPARE_SWITCH = reg_c_switch;
	assign I_COMPARE_EN = reg_c_en;
	assign WBUF_POOL_BUSY = (counter0 > 1 | |cnt) ? 1:0;
	assign start = WBUF_SEND_POOL & !module_busy;

	//counter0
  	always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL) begin
			counter0 <= 0;
		end
		else if(start) begin
			counter0 <= COUNTER0 + 1;
		end
		else if(|counter0 && cnt == 4'b0) begin
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
			cnt <= 4'b1001;
		else if(WBUF_POOL_BUSY && ~|cnt) begin
			if(counter0 == 2)
				cnt <= 4'b0011;
			else
				cnt <= 4'b1000;
		end else if(WBUF_POOL_BUSY) begin
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
		else if(WBUF_POOL_BUSY) begin
			if(cnt == 4'b0001 | counter0 == 1)
				reg_raddrx <= reg_raddrx;
			else if(counter0 == 2 & cnt == 4'b0000)
				reg_raddrx <= reg_raddrx;
			else if(cnt == 4'b0110)
				reg_raddrx <= reg_raddrx + 16'd125;
			else if(cnt == 4'b0010)
				reg_raddrx <= reg_raddrx - 16'd127;
			else
				reg_raddrx <= reg_raddrx + 1'd1;
		end else
			reg_raddrx <= reg_raddrx;
  	end

	//WBUF_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_wbufen <= 1'd0;
		else if(WBUF_POOL_BUSY) begin
			if(cnt == 4'b0000) begin
				if(counter0 == 1)
					reg_wbufen <= 0;
				else
					reg_wbufen <= 1;
			end else if(cnt == 4'b0101)
				reg_wbufen <= 0;
			else
				reg_wbufen <= reg_wbufen;
		end else
			reg_wbufen <= 0;
	end

	//WBUF_EN_CTRL
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_wbufenctrl <= 1'd0;
		else if(cnt == 4'b1001)
			reg_wbufenctrl <= WBUF_EN_CTRL_I;
		else if(counter0 == 1)
			reg_wbufenctrl <= reg_wbufenctrl;
		else if(cnt == 4'b0101 & reg_wbufen)
			reg_wbufenctrl <= reg_wbufenctrl + 1;
		else
			reg_wbufenctrl <= reg_wbufenctrl;
	end

	//RCEBX
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_rcebx <= 1'd0;
		else if(start)
			reg_rcebx <= 1'b0;
		else if(WBUF_POOL_BUSY) begin
			if(cnt == 4'b0010 | counter0 == 1)
				reg_rcebx <= 1;
			else if(cnt == 4'b0000 & counter0 == 2)
				reg_rcebx <= 1;
			else
				reg_rcebx <= 0;
		end else
			reg_rcebx <= 1;
	end

	//I_COMPARE_REGEN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_c_regen <= 1'd0;
		else if(counter0) begin
			if(cnt == 4'b0001)
				reg_c_regen <= 0;
			else if(counter0 == 2 & cnt == 4'b0000)
				reg_c_regen <= 0;
			else if(counter0 == 1)
				reg_c_regen <= 0;
			else
				reg_c_regen <= 1;
		end else
			reg_c_regen <= 0;
	end

	//I_COMPARE_SWITCH
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_c_switch <= 1'd0;
		else if(WBUF_POOL_BUSY) begin
			if(cnt == 4'b0101)
				reg_c_switch <= 1;
			else if(cnt == 4'b0000)
				reg_c_switch <= 0;
			else
				reg_c_switch <= reg_c_switch;
		end else
			reg_c_switch <= 0;
	end

	//I_COMPARE_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_c_en <= 1'd0;
		else if(counter0 == 1)
			reg_c_en <= 0;
		else if(cnt == 4'b0001)
			reg_c_en <= 1;
		else
			reg_c_en <= 0;
	end


endmodule