module conv_cal_test;
  reg CLK, RSTL, CONV_CAL;
  reg [15:0] loop;
  wire [2:0] cnt;
  wire [15:0] RADDRW;
  wire [15:0] COUNTER0;
  wire RCEBW, NL_EN, MAC_EN;

  conv_cal conv_cal_instance(
    .CLK(CLK),
    .RSTL(RSTL),
    .CONV_CAL(CONV_CAL),
    .loop(loop),
    .cnt(cnt),
    .RADDRW(RADDRW),
    .COUNTER0(COUNTER0),
    .RCEBW(RCEBW),
    .NL_EN(NL_EN),
    .MAC_EN(MAC_EN)
  );

  parameter step = 10;

  initial begin
    CLK = 0;
    forever #(step) CLK = ~CLK;
  end

  initial begin
    RSTL = 0;
    CONV_CAL = 0;
    loop = 5; //ループ回数
    #(step*3)
    RSTL = 1;
    CONV_CAL = 1;
    #step
    CONV_CAL = 0;

    // #(step*53)
    // CONV_CAL = 1;
    // #step
    // CONV_CAL = 0;
  end

  initial begin
    #(step*100) $finish();
  end
  
  initial begin
    $dumpfile("conv_cal_test.vcd");
    $dumpvars(0, conv_cal_instance);
  end

endmodule