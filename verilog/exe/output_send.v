module output_send(
	input wire CLK, 
	input wire RSTL,
	input wire OUTPUT_SEND,
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
	output wire O_COMPARE_REGEN,
	output wire O_COMPARE_SWITCH,
	output wire OUTPUT_BUSY
	);

	wire [15:0] WADDRX_NO;
	wire		WCEBX_NO;
	wire		OUTPUT_EN_NO;
	wire [5:0]  OUTPUT_EN_CTRL_NO;
	wire		OUTPUT_NO_BUSY;
	wire [15:0] WADDRX_POOL;
	wire		WCEBX_POOL;
	wire		OUTPUT_EN_POOL;
	wire [5:0]  OUTPUT_EN_CTRL_POOL;
	wire		OUTPUT_POOL_BUSY;

	assign WADDRX = (COUNTER0_O) ? WADDRX_NO:WADDRX_POOL;
	assign WCEBX = (COUNTER0_O) ? WCEBX_NO:WCEBX_POOL;
	assign OUTPUT_EN = (COUNTER0_O) ? OUTPUT_EN_NO:OUTPUT_EN_POOL;
	assign OUTPUT_EN_CTRL = (COUNTER0_O) ? OUTPUT_EN_CTRL_NO:OUTPUT_EN_CTRL_POOL;
	assign OUTPUT_BUSY = OUTPUT_NO_BUSY | OUTPUT_POOL_BUSY;

	output_send_nopool output_send_nopool_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .OUTPUT_SEND(OUTPUT_SEND),
        .COUNTER0(COUNTER0),
        .WADDRX_I(WADDRX_I),
        .OUTPUT_EN_CTRL_I(OUTPUT_EN_CTRL_I),
        .module_busy(module_busy),
        //output
        .WADDRX(WADDRX_NO),
        .WCEBX(WCEBX_NO),
        .OUTPUT_EN(OUTPUT_EN_NO),
        .OUTPUT_EN_CTRL(OUTPUT_EN_CTRL_NO),
        .OUTPUT_BUSY(OUTPUT_NO_BUSY),
		.COUNTER0_O(COUNTER0_O)
    );

	output_send_pool output_send_pool_0(
        //input
        .CLK(CLK),
        .RSTL(RSTL),
        .OUTPUT_SEND_POOL(OUTPUT_SEND_POOL),
        .COUNTER0(COUNTER0),
        .WADDRX_I(WADDRX_I),
        .OUTPUT_EN_CTRL_I(OUTPUT_EN_CTRL_I),
        .module_busy(module_busy),
        //output
        .WADDRX(WADDRX_POOL),
        .WCEBX(WCEBX_POOL),
        .OUTPUT_EN(OUTPUT_EN_POOL),
        .OUTPUT_EN_CTRL(OUTPUT_EN_CTRL_POOL),
        .O_COMPARE_EN(O_COMPARE_EN),
        .O_COMPARE_MODE(O_COMPARE_MODE),
        .O_COMPARE_SWITCH(O_COMPARE_SWITCH),
        .OUTPUT_POOL_BUSY(OUTPUT_POOL_BUSY)
    );

endmodule