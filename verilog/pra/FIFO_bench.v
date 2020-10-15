`timescale 1ps/1ps
module FIFO_bench();

  parameter DATA_WIDTH   = 8;
  parameter FIFO_DEPTH   = 4;
  reg clk,n_rst,rd_en,wr_en;
  reg  [DATA_WIDTH - 1:0]  din;
  wire [DATA_WIDTH - 1:0]  dout;

  FIFO #(.FIFO_DEPTH(FIFO_DEPTH))u0(
    .clk(clk),
    .n_rst(n_rst),
    .rd_en(rd_en),
    .wr_en(wr_en),
    .din(din),
    .dout(dout)
  );

  initial begin
    n_rst = 1;
    #10 n_rst = ~n_rst;
  end

  initial begin
    clk = 0;
    rd_en = 0;
    forever #10 clk = ~clk;
  end

  initial begin 
    #10 wr_en = 1;
        din = 1;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 2;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 3;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 4;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 5;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 6;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 7;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 8;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 9;
    #10 wr_en = ~wr_en;
    #10 wr_en = 1;
        din = 10;
    #10 wr_en = ~wr_en;
    #10 rd_en = 1'b1;
    #10 rd_en = ~rd_en;
    #10 rd_en = 1'b1;
    #10 rd_en = ~rd_en;
    #10 rd_en = 1'b1;
    #10 rd_en = ~rd_en;
    #10 rd_en = 1'b1;
    #10 rd_en = ~rd_en;
    #10 rd_en = 1'b1;
    #10 rd_en = ~rd_en;
  end
integer i;
  initial begin
    $dumpfile("FIFO.vcd");
    $dumpvars(0, FIFO_bench);
    for(i = 0;i < 2**FIFO_DEPTH;i++)
      $dumpvars(1,u0.data[i]);
    $monitor ("%t: clk = %b r_data = %b", $time, clk,dout);
  end

  initial begin
    #500 $finish();
  end

endmodule
