module output_send_pool(
	input wire CLK, 
	input wire RSTL,
	input wire OUTPUT_SEND_POOL,
	input wire [7:0] COUNTER0,
	input wire [15:0] WADDRX_I,
	input wire [5:0] OUTPUT_EN_CTRL_I,
	input wire module_busy,
	output wire [15:0] WADDRX,
	output wire WCEBX,
	output wire OUTPUT_EN,
	output wire [5:0] OUTPUT_EN_CTRL,
	output wire O_COMPARE_EN,
	output wire O_COMPARE_MODE,
	output wire O_COMPARE_SWITCH,
	output wire OUTPUT_POOL_BUSY
	);

	reg [15:0] 	pc;
	reg [4:0]   cnt;
	reg [7:0] 	counter0;
	reg [15:0] 	reg_waddrx;
	reg [5:0]  	reg_outputenctrl;
	reg reg_outputen;
	reg reg_wcebx;
	reg reg_c_switch;
	reg reg_c_en;

	assign WADDRX = reg_waddrx;
	assign OUTPUT_EN = reg_outputen;
	assign OUTPUT_EN_CTRL = reg_outputenctrl;
	assign WCEBX = reg_wcebx;
	assign O_COMPARE_MODE = |counter0;
	assign O_COMPARE_SWITCH = reg_c_switch;
	assign O_COMPARE_EN = reg_c_en;
	assign OUTPUT_POOL_BUSY = (counter0 > 1 | |cnt) ? 1:0;
	assign start = OUTPUT_SEND_POOL & !module_busy;

	//counter0
  	always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL) begin
			counter0 <= 0;
		end
		else if(start) begin
			counter0 <= COUNTER0 + 1;
		end
		else if(|counter0 && cnt == 5'b0) begin
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
			cnt <= 5'b10010;
		else if(OUTPUT_POOL_BUSY && ~|cnt)
			if(counter0 == 2)
				cnt <= 5'b00100;
			else
				cnt <= 5'b01000;
		else if(OUTPUT_POOL_BUSY) begin
			cnt <= cnt - 1;
		end else
			cnt <= 0;
	end

	//WADDRX
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			reg_waddrx <= 1'd0;
		else if(start)
			reg_waddrx <= WADDRX_I;
		else if(OUTPUT_POOL_BUSY) begin
			if(counter0 == 1) begin
				if(cnt == 5'b00100 | cnt == 5'b00011 | cnt == 5'b00010 | cnt == 5'b00001)
					reg_waddrx <= reg_waddrx + 1'd1;
			end
			else if(cnt == 5'b01000 | cnt == 5'b00111 | cnt == 5'b00110 | cnt == 5'b00101)
				reg_waddrx <= reg_waddrx + 1'd1;
			else
				reg_waddrx <= reg_waddrx;
		end else
			reg_waddrx <= reg_waddrx;
  	end

	//OUTPUT_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_outputen <= 1'd0;
		else if(OUTPUT_POOL_BUSY) begin
			if(cnt == 5'b01010 | cnt == 5'b00001)
				reg_outputen <= 0;
			else
				reg_outputen <= 1;
		end else
			reg_outputen <= 0;
	end

	//OUTPUT_EN_CTRL
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_outputenctrl <= 1'd0;
		else if(OUTPUT_POOL_BUSY) begin
			if(counter0 == 1)
				reg_outputenctrl <= reg_outputenctrl;
			else if(cnt == 5'b01110 | cnt == 5'b01010 | cnt == 5'b00101 | cnt == 5'b00001)
				reg_outputenctrl <= reg_outputenctrl + 1;
			else
				reg_outputenctrl <= reg_outputenctrl;
		end else
			reg_outputenctrl <= reg_outputenctrl;
	end

	//WCEBX
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_wcebx <= 1'd0;
		else if(OUTPUT_POOL_BUSY) begin
			if(cnt == 5'b00000 | cnt == 5'b01001)
				reg_wcebx <= 1'b0;
			else if(cnt == 5'b00101)
				reg_wcebx <= 1'b1;
			else if(counter0 == 1 & cnt == 5'b00001)
				reg_wcebx <= 1'b1;
			else
				reg_wcebx <= reg_wcebx;
		end else
			reg_wcebx <= 1'b1;
	end

	//O_COMPARE_SWITCH
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_c_switch <= 1'd0;
		else if(OUTPUT_POOL_BUSY) begin
			if(cnt == 5'b01110 | cnt == 5'b00101)
				reg_c_switch <= 1;
			else if(cnt == 5'b01001 | cnt == 5'b00000)
				reg_c_switch <= 0;
			else
				reg_c_switch <= reg_c_switch;
		end else
			reg_c_switch <= 0;
	end

	//O_COMPARE_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_c_en <= 1'd0;
		else if(cnt == 5'b01010 | cnt == 5'b00001)
			if(counter0 == 1)
				reg_c_en <= 0;
			else
				reg_c_en <= 1;
		else
			reg_c_en <= 0;
	end


endmodule