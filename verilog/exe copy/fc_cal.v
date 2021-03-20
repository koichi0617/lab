module fc_cal(
	input wire CLK, 
	input wire RSTL,
	input wire FC_CAL,
	input wire [7:0] COUNTER0,
	input wire [15:0] RADDRW_I,
	input wire module_busy,
	output wire [15:0] RADDRW,
	output wire RCEBW,
	output wire MAC_EN,
	output wire NL_EN,
	output wire CAL_MODE,
	output wire WEIGHT_EN,
	output wire FC_BUSY
	);

	reg [15:0] 	pc;
	reg [3:0]   cnt;
	reg [7:0] 	counter0;
	reg [15:0] 	reg_raddrw;
	reg			reg_rcebw;
	reg 		reg_macen;
	reg 		reg_nlen;
	reg 		reg_calmode;
	reg 		reg_weighten;


	assign RADDRW = reg_raddrw;
	assign RCEBW   = reg_rcebw;
	assign MAC_EN = reg_macen;
	assign NL_EN = reg_nlen;
	assign CAL_MODE = reg_calmode;
	assign WEIGHT_EN = reg_weighten;
	assign FC_BUSY = (counter0 > 1 | |cnt) ? 1:0;
	assign start = FC_CAL & !module_busy;

	//counter0
  	always @(posedge CLK or negedge RSTL)  begin
		if (!RSTL) begin
			counter0 <= 0;
		end
		else if(start) begin
			counter0 <= COUNTER0;
		end
		else if(|counter0 && cnt == 4'b0000) begin
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
			cnt <= 4'b1101;
		else if(FC_BUSY && ~|cnt)
			cnt <= 4'b1100;
		else if(FC_BUSY) begin
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
		else if(FC_BUSY) begin
			if(cnt == 4'b0101 | cnt == 4'b0100 | cnt == 4'b0011 | cnt == 4'b0010 | cnt == 4'b0001)
				reg_raddrw <= reg_raddrw;
			else if(counter0 == 1 & cnt == 4'b0000)
				reg_raddrw <= reg_raddrw;
			else
				reg_raddrw <= reg_raddrw + 1;
		end else
			reg_raddrw <= reg_raddrw;
    end

	//MAC_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_macen <= 1'd0;
		else if(FC_BUSY) begin
			if(cnt == 4'b0101)
				reg_macen <= 1'b1;
			else
				reg_macen <= 1'b0;
		end else
			reg_macen <= 1'b0;
	end

	//RCEBW
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)
			reg_rcebw 	<= 1'd0;
		else if(FC_BUSY) begin
			if(cnt == 4'b0101)
				reg_rcebw 	<= 1'd1;
			else if(cnt == 4'b0001)
				reg_rcebw 	<= 1'd0;
			else
				reg_rcebw 	<= reg_rcebw;
		end else
			reg_rcebw 	<= 1'd0;
	end

	//NL_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)
			reg_nlen 	<= 1'd0;
		else if(FC_BUSY) begin
			if(cnt == 4'b0101)
				reg_nlen 	<= 1'd1;
			else if(cnt == 4'b0001)
				reg_nlen 	<= 1'd0;
			else
				reg_nlen 	<= reg_nlen;
		end else
			reg_nlen 	<= 1'd0;
	end

	//CAL_MODE
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)
			reg_calmode <= 1'd0;
		else if(FC_BUSY) begin
			if(cnt == 4'b0101)
				reg_calmode <= 1'd1;
			else if(cnt == 4'b0001)
				reg_calmode <= 1'd0;
			else
				reg_calmode <= reg_calmode;
		end else
			reg_calmode <= 1'd0;
	end

	//WEIGHT_EN
	always@ (posedge CLK or negedge RSTL) begin
		if (!RSTL)       
			reg_weighten <= 1'd0;
		else if(FC_BUSY) begin
			if(counter0 == 1 & cnt == 4'b0000)
				reg_weighten <= reg_weighten;
			else if(cnt == 4'b0000 | cnt == 4'b1101)
				reg_weighten <= 1'b1;
			else if(cnt == 4'b0101)
				reg_weighten <= 1'b0;
			else
				reg_weighten <= reg_weighten;
		end else
			reg_weighten <= 1'b0;
	end


endmodule