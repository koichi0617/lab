module output_send(
	input wire CLK, 
	input wire RSTL,
	input wire OUTPUT_SEND,
	input wire [7:0] COUNTER0,
	input wire [5:0] OUTPUT_EN_CTRL_I,
	output wire [15:0] WADDRX,
	output wire WCEBX,
	output wire OUTPUT_EN,
	output wire [5:0] OUTPUT_EN_CTRL,
	output wire OUTPUT_BUSY
	);

	reg [15:0] 	pc;
	reg [2:0]   cnt;
	reg [7:0] 	counter0;
	reg [15:0] 	reg_waddrx;
	reg			reg_wcebx;
	reg 		reg_outputen;
	reg [5:0]  	reg_outputenctrl;


	assign WADDRX = reg_waddrx;
	assign OUTPUT_EN_CTRL = reg_outputenctrl;
	assign OUTPUT_BUSY = (counter0 > 1 | |cnt) ? 1:0;
	assign WCEBX   = ~|counter0;
	assign OUTPUT_EN = |counter0;

	//counter0
  	always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL) begin
			counter0 <= 0;
		end
		else if(OUTPUT_SEND && !OUTPUT_BUSY) begin
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
		else if(OUTPUT_SEND & !OUTPUT_BUSY)
			cnt <= 3'b100;
		else if(OUTPUT_BUSY && ~|cnt)
			cnt <= 3'b011;
		else if(OUTPUT_BUSY) begin
			cnt <= cnt - 1;
		end else
			cnt <= 0;
	end

	//WADDRX
	always @(posedge CLK or negedge RSTL) begin
		if (!RSTL)			
			reg_waddrx <= 1'd0;
		else if(OUTPUT_BUSY)
			reg_waddrx <= reg_waddrx + 1'd1;
		else
			reg_waddrx <= reg_waddrx;
    end

	//OUTPUT_EN_CTRL
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_outputenctrl <= 1'd0;
		else if(OUTPUT_SEND & !OUTPUT_BUSY)
			reg_outputenctrl <= OUTPUT_EN_CTRL_I;
		else if(OUTPUT_BUSY & ~|cnt)
			reg_outputenctrl <= reg_outputenctrl + 1'd1;
		else
			reg_outputenctrl <= reg_outputenctrl;
	end


endmodule