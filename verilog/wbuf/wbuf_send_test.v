module wbuf_send_test;
  reg CLK, RSTL, WBUF_SEND;
  wire [15:0] RADDRX;
  wire [5:0] WBUF_EN_CTRL;
  wire WBUF_EN, RCEBX;

  wbuf_send wbuf_send_instance(
    .CLK(CLK),
    .RSTL(RSTL),
    .WBUF_SEND(WBUF_SEND),
    .RADDRX(RADDRX),
    .RCEBX(RCEBX),
    .WBUF_EN(WBUF_EN),
    .WBUF_EN_CTRL(WBUF_EN_CTRL)
  );

  parameter step = 10;

  initial begin
    CLK = 0;
    forever #(step) CLK = ~CLK;
  end

  initial begin
    RSTL = 0;
    WBUF_SEND = 0;
    #(step*3)
    RSTL = 1;
    WBUF_SEND = 1;

    #(step*2)
    WBUF_SEND = 0;
  end

  initial begin
    #(step*500) $finish();
  end
  
  initial begin
    $dumpfile("wbuf_send_test.vcd");
    $dumpvars(0, wbuf_send_instance);
  end

endmodule