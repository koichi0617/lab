//
// SRAM module
//
// (C) 2019.06.12 Masahiro IIDA @ Kumamoto University
//
// SEG option : S
// MUX option : 4
// Word Depth : 8192 (adrs:13bit)
// Bits       : 128
// Total Bits : 1M bits
module
ts1n40lphsb8192x128m4s_250a(A, D, CLK, CEB, WEB, Q,
			    BWEB, AM, DM, CEBM, WEBM, BWEBM, BIST, PD, AWT);
   parameter WORDS = 8192;
   parameter BITS = 64;
   parameter ADRS = 13;

   input [ADRS-1:0] A; // Address input
   input [BITS*2-1:0] D; // Data input
   input CLK; // CLK input
   input CEB; // Chip enable for SRAM operation [active low]
   input WEB; // Write enable for SRAM operation [active low]
   output [BITS-1:0] Q; // Data output
// The below does not use for functional simulation
   input BWEB; // Bit write enable for SRAM operation [active low]
   input [ADRS-1:0] AM; // Address input for BIST
   input [BITS-1:0] DM; // Data input for BIST
   input CEBM; // Chip enable for BIST [active low]
   input WEBM; // Write enable for BIST [active low]
   input BWEBM; // Bit write enable for BIST [active low]
   input BIST; // BIST enable
   input PD; // Power down mode
   input AWT; // Asynchronous write through

   reg [BITS-1:0] ram[0:WORDS-1];

   reg [BITS-1:0] Q; // Data output

   always @(posedge CLK)
     begin
	     Q <= ram[A];
     end
endmodule //