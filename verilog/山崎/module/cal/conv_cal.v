module conv_cal(
	input wire CLK, 
	input wire RSTL,
	input wire CONV_CAL,
	input wire [7:0] COUNTER0,
	input wire [15:0] RADDRW_I,
	input wire module_busy,
	output wire [15:0] RADDRW,
	output wire RCEBW,
	output wire MAC_EN,
	output wire NL_EN,
	output wire CONV_BUSY,
	output wire COUNTER0_O
	);

	reg [15:0] 	pc;
	reg [2:0]   cnt;
	reg [7:0] 	counter0;
	reg [15:0] 	reg_raddrw;
	reg 		reg_macen;
	reg 		reg_nlen;


	assign RADDRW = reg_raddrw;
	assign MAC_EN = reg_macen;
	assign NL_EN = reg_nlen;
	assign CONV_BUSY = (counter0 > 1 | |cnt) ? 1:0;
	assign RCEBW   = ~|counter0;
	assign start = CONV_CAL & !module_busy;
	assign COUNTER0_O = |counter0;

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
			cnt <= 3'b101;
		else if(CONV_BUSY && ~|cnt)
			cnt <= 3'b100;
		else if(CONV_BUSY) begin
			cnt <= cnt - 1;
		end else
			cnt <= 0;
	end

	//RADDRW
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			reg_raddrw <= 1'd0;
		else if(start)
			reg_raddrw <= RADDRW_I;
		else if(CONV_BUSY) begin
			if(cnt == 3'b010)
				reg_raddrw <= reg_raddrw;
			else
				reg_raddrw <= reg_raddrw + 1'd1;
		end else
			reg_raddrw <= reg_raddrw;
    end

	//MAC_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_macen <= 1'd0;
		else if(CONV_BUSY) begin
			if(cnt == 3'b000 | cnt == 3'b101)
				reg_macen <= 1'b1;
			else
				reg_macen <= 1'b0;
		end else
			reg_macen <= 1'b0;
	end

	//NL_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_nlen <= 1'd0;
		else if(CONV_BUSY) begin
			if(cnt == 3'b001)
				reg_nlen <= 1'b0;
			else
				reg_nlen <= 1'b1;
		end else
			reg_nlen <= 1'b0;
	end

endmodule