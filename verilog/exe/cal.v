module cal(
	input wire CLK, 
	input wire RSTL,
	input wire CONV_CAL,
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
	output wire CAL_BUSY
	);

	wire [15:0] RADDRW_CONV;
	wire		RCEBW_CONV;
	wire		MAC_EN_CONV;
	wire        NL_EN_CONV;
	wire		CONV_BUSY;
	wire [15:0] RADDRW_FC;
	wire		RCEBW_FC;
	wire		MAC_EN_FC;
	wire        NL_EN_FC;
	wire		FC_BUSY;

	assign RADDRW = (COUNTER0_O) ? RADDRW_CONV:RADDRW_FC;
	assign RCEBW = (COUNTER0_O) ? RCEBW_CONV:RCEBW_FC;
	assign MAC_EN = (COUNTER0_O) ? MAC_EN_CONV:MAC_EN_FC;
	assign NL_EN = (COUNTER0_O) ? NL_EN_CONV:NL_EN_FC;
	assign CAL_BUSY = CONV_BUSY | FC_BUSY;

	conv_cal conv_cal_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .CONV_CAL(CONV_CAL),
        .COUNTER0(COUNTER0),
        .RADDRW_I(RADDRW_I),
        .module_busy(module_busy),
        //output
        .RADDRW(RADDRW_CONV),
        .RCEBW(RCEBW_CONV),
        .MAC_EN(MAC_EN_CONV),
        .NL_EN(NL_EN_CONV),
        .CONV_BUSY(CONV_BUSY),
		.COUNTER0_O(COUNTER0_O)
    );

	fc_cal fc_cal_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .FC_CAL(FC_CAL),
        .COUNTER0(COUNTER0),
        .RADDRW_I(RADDRW_I),
        .module_busy(module_busy),
        //output
        .RADDRW(RADDRW_FC),
        .RCEBW(RCEBW_FC),
        .MAC_EN(MAC_EN_FC),
        .NL_EN(NL_EN_FC),
        .CAL_MODE(CAL_MODE),
        .WEIGHT_EN(WEIGHT_EN),
        .FC_BUSY(FC_BUSY)
    );

endmodule