module IP2_TEST;

parameter STEP = 10;
reg CLK, RSTL;

reg DPU_START;
wire DPU_BUSY;

reg [127:0] ddr_memoryi [0:16383];
reg [63:0] ddr_memoryw [0:16383];
reg [63:0] ddr_memoryx [0:16383];
reg [63:0] ddr_memoryo [0:16383];
reg [15:0] ddr_addri, ddr_addrw, ddr_addrx, ddr_addro;

reg [63:0] S_AXIS_TDATAW, S_AXIS_TDATAX;
reg [127:0] S_AXIS_TDATAI;
wire [63:0] M_AXIS_TDATAX;
wire S_AXIS_TREADYI, S_AXIS_TREADYW, S_AXIS_TREADYX;
reg S_AXIS_TLASTI, S_AXIS_TVALIDI;
reg S_AXIS_TLASTW, S_AXIS_TVALIDW;
reg S_AXIS_TLASTX, S_AXIS_TVALIDX;
reg M_AXIS_TREADYX;
wire M_AXIS_TLASTX, M_AXIS_TVALIDX;

always begin
    CLK = 1; #(STEP/2);
    CLK = 0; #(STEP/2);
end

always @(posedge CLK) begin
    if(S_AXIS_TVALIDI && S_AXIS_TREADYI)
        ddr_addri = ddr_addri + 1;
end

always @(posedge CLK) begin
    S_AXIS_TDATAI <= ddr_memoryi[ddr_addri];
end

always @(posedge CLK) begin
    if(S_AXIS_TVALIDW && S_AXIS_TREADYW)
        ddr_addrw = ddr_addrw + 1;
end

always @(posedge CLK) begin
    S_AXIS_TDATAW <= ddr_memoryw[ddr_addrw];
end

always @(posedge CLK) begin
    if(S_AXIS_TVALIDX && S_AXIS_TREADYX)
        ddr_addrx = ddr_addrx + 1;
end

always @(posedge CLK) begin
    S_AXIS_TDATAX <= ddr_memoryx[ddr_addrx];
end

IP2 ip2_0(
.CLK(CLK),
.RSTL(RSTL),
.PURGE(~RSTL),
.DPU_START(DPU_START),
.DPU_BUSY(DPU_BUSY),

.S_AXIS_I_TDATA(S_AXIS_TDATAI),
.S_AXIS_I_TREADY(S_AXIS_TREADYI),
.S_AXIS_I_TLAST(S_AXIS_TLASTI),
.S_AXIS_I_TVALID(S_AXIS_TVALIDI),

.S_AXIS_W_TDATA(S_AXIS_TDATAW),
.S_AXIS_W_TREADY(S_AXIS_TREADYW),
.S_AXIS_W_TLAST(S_AXIS_TLASTW),
.S_AXIS_W_TVALID(S_AXIS_TVALIDW),

.S_AXIS_X_TDATA(S_AXIS_TDATAX),
.S_AXIS_X_TREADY(S_AXIS_TREADYX),
.S_AXIS_X_TLAST(S_AXIS_TLASTX),
.S_AXIS_X_TVALID(S_AXIS_TVALIDX),

.M_AXIS_X_TDATA(M_AXIS_TDATAX),
.M_AXIS_X_TREADY(M_AXIS_TREADYX),
.M_AXIS_X_TLAST(M_AXIS_TLASTX),
.M_AXIS_X_TVALID(M_AXIS_TVALIDX)
);

initial begin
        $display("Start loading memory");
        $dumpfile("wave.vcd");
        $dumpvars(0, ip2_0);

        #STEP
                $dumpflush;
        #STEP   $finish;
end

endmodule
