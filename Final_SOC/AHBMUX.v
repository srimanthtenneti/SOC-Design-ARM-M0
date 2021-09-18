//---------------------------------------------------------------------------------
 //                         AHB Lite Slave Mux Design
//---------------------------------------------------------------------------------

// ********************************************************************************
 
 //    Author : Srimanth Tenneti
 //    Date : 5th May 2021
 //	   Description : AHB-Lite bus slave decoder
 //	   Type : RTL Design
	 
// ********************************************************************************

module AHBMUX(
  input wire HCLK,  // Global Signals
  input wire HRESETn, 
  
  input wire [3:0] MUX_SEL, // Mux Sel for address decoder
  
  input wire [31:0] HRDATA_S0,
  input wire [31:0] HRDATA_S1,
  input wire [31:0] HRDATA_S2,
  input wire [31:0] HRDATA_S3,
  input wire [31:0] HRDATA_S4,
  input wire [31:0] HRDATA_S5, // HRDATA from all the slaves
  input wire [31:0] HRDATA_S6,
  input wire [31:0] HRDATA_S7,
  input wire [31:0] HRDATA_S8,
  input wire [31:0] HRDATA_S9,
  input wire [31:0] HRDATA_NOMAP,
  
  input wire HREADYOUT_S0,
  input wire HREADYOUT_S1,
  input wire HREADYOUT_S2,
  input wire HREADYOUT_S3,
  input wire HREADYOUT_S4,  // HREADYOUT from all the slaves 
  input wire HREADYOUT_S5,
  input wire HREADYOUT_S6,
  input wire HREADYOUT_S7,
  input wire HREADYOUT_S8,
  input wire HREADYOUT_S9,
  input wire HREADYOUT_NOMAP,
  
  output reg HREADY,
  output reg [31:0] HRDATA 
);

reg [3:0] APHASE_MUX_SEL; // Latch the address phase mux sel
// We do this to provide the appropriate control signals in the data 
// The control signals are valid only if HREADY = 1

always @ (posedge HCLK)
 begin
     if(!HRESETn)
	  APHASE_MUX_SEL <= 4'h0;
	 else
	  APHASE_MUX_SEL <= MUX_SEL;
 end
 
 always @*
  begin
     case(APHASE_MUX_SEL)
	  4'b0000: begin
	    HRDATA = HRDATA_S0;
		HREADY = HREADYOUT_S0;
	  end
	  
	   4'b0001: begin
	    HRDATA = HRDATA_S1;
		HREADY = HREADYOUT_S1;
	  end
	  
	   4'b0010: begin
	    HRDATA = HRDATA_S2;
		HREADY = HREADYOUT_S2;
	  end
	  
	   4'b0011: begin
	    HRDATA = HRDATA_S3;
		HREADY = HREADYOUT_S3;
	  end
	  
	   4'b0100: begin
	    HRDATA = HRDATA_S4;
		HREADY = HREADYOUT_S4;
	  end
	  
	   4'b0101: begin
	    HRDATA = HRDATA_S5;
		HREADY = HREADYOUT_S5;
	  end
	  
	   4'b0110: begin
	    HRDATA = HRDATA_S6;
		HREADY = HREADYOUT_S6;
	  end
	  
	   4'b0111: begin
	    HRDATA = HRDATA_S7;
		HREADY = HREADYOUT_S7;
	  end
	  
	   4'b1000: begin
	    HRDATA = HRDATA_S8;
		HREADY = HREADYOUT_S8;
	  end
	  
	   4'b1001: begin
	    HRDATA = HRDATA_S9;
		HREADY = HREADYOUT_S9;
	  end
	  
	  default: begin
	      HRDATA = HRDATA_NOMAP;
		  HREADY = HREADYOUT_NOMAP;
	  end
	  endcase
  end
 
 endmodule