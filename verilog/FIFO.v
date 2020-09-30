//---------------------------------------
//module FIFO 
//                    made by Ryohei.K
//---------------------------------------

`default_nettype none
`define FIFO_D 4
module FIFO(
  input wire        clk,
  input wire        n_rst,
  input wire  [DATA_WIDTH - 1:0] din,
  input wire        rd_en,
  input wire        wr_en,
  output reg        empty,
  output reg        full,
  output reg  [DATA_WIDTH - 1:0] dout
);
  parameter DATA_WIDTH   = 8;
  parameter FIFO_DEPTH   = 4;

  reg [0:2**FIFO_DEPTH]  rd_addr;
  reg [0:2**FIFO_DEPTH]  wr_addr;
  reg [DATA_WIDTH - 1:0]  data[0:2**FIFO_DEPTH - 1];

//FIFO
  always @(posedge clk)begin
    if(wr_en & !full)data[wr_addr] <= din;
    if(rd_en & !empty)dout <= data[rd_addr];
  end

//Write address
  always @(posedge clk or posedge n_rst)begin
    if(n_rst)begin
      wr_addr <= 0;
    end else begin
      if(wr_en == 1'b1 & full == 1'b0)begin
        if(wr_addr == `FIFO_D'b1111)begin
          wr_addr <= 0;
        end else begin
          wr_addr <= wr_addr + 1'b1;
        end
      end
    end
  end

//Read address
    always @(posedge clk or posedge n_rst)begin
      if(n_rst)begin
        rd_addr <= 0;
      end else begin
        if(rd_en)begin
          if(rd_addr == `FIFO_D'b1111)begin
            rd_addr <= 0;
          end else begin
            rd_addr <= rd_addr + 1'b1;
          end
        end
      end
    end

//Full flag
  always @(posedge clk or posedge n_rst)begin
    if(n_rst)begin
      full <= 0;
    end else begin
      if( wr_addr == `FIFO_D'b1111 & wr_en == 1 & rd_en == 0)begin
        full <= 1;
      end else if(full == 1 &rd_en == 1)begin
        full <= 0;
      end
    end
  end

  //Empty flag
  always @(posedge clk or posedge n_rst)begin
    if(n_rst)begin
      empty <= 1;
    end else begin
      if(wr_en)begin
        empty <= 0;
      end
    end
  end
endmodule