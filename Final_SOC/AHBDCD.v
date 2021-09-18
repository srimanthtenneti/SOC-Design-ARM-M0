// -----------------------------------------------------------------
 //                          AHB-Lite Decoder                    //
// -----------------------------------------------------------------

// Author : Srimanth Tenneti
// Date   : 8th May 2021
// Description : AHB-Lite Address Decoder
// Type : RTL Design

module AHBDCD(
 input wire [31:0] HADDR, // Taking HADDR as input
 
 output wire HSEL_S0,
 output wire HSEL_S1,
 output wire HSEL_S2,
 output wire HSEL_S3,
 output wire HSEL_S4,
 output wire HSEL_S5,
 output wire HSEL_S6,
 output wire HSEL_S7,
 output wire HSEL_S8,
 output wire HSEL_S9,
 output wire HSEL_NOMAP,
 
 output reg [3:0] MUX_SEL
);

reg [15:0] dec;

assign HSEL_S0 = dec[0]; // 0x0000_0000 to 0x00FF_FFFF : 16MB
assign HSEL_S1 = dec[1]; // 0x5000_0000 to 0x50FF_FFFF : 16MB
assign HSEL_S2 = dec[2]; // 0x5100_0000 to 0x51FF_FFFF : 16MB
assign HSEL_S3 = dec[3]; // 0x5200_0000 to 0x52FF_FFFF : 16MB
assign HSEL_S4 = dec[4]; // 0x5300_0000 to 0x53FF_FFFF : 16MB
assign HSEL_S5 = dec[5]; // 0x5400_0000 to 0x54FF_FFFF : 16MB
assign HSEL_S6 = dec[6]; // 0x5500_0000 to 0x55FF_FFFF : 16MB
assign HSEL_S7 = dec[7]; // 0x5600_0000 to 0x56FF_FFFF : 16MB
assign HSEL_S8 = dec[8]; // 0x5700_0000 to 0x57FF_FFFF : 16MB
assign HSEL_S9 = dec[9]; // 0x5800_0000 to 0x58FF_FFFF : 16MB
assign HSEL_NOMAP = dec[15]; 

always @*
begin
  case(HADDR[31:24])
    8'h00:
	begin
	 dec = 16'h0000_0000_0000_0001; // One Hot encoding
	 MUX_SEL = 4'b0000; 
	end
	
	8'h50:
	begin
	 dec = 16'h0000_0000_0000_0010;
	 MUX_SEL = 4'b0001; 
	end
	
	8'h51:
	begin
	 dec = 16'h0000_0000_0000_0100;
	 MUX_SEL = 4'b0010; 
	end
	
	8'h52:
	begin
	 dec = 16'h0000_0000_0000_1000;
	 MUX_SEL = 4'b0011; 
	end
	
	8'h53:
	begin
	 dec = 16'h0000_0000_0001_0000;
	 MUX_SEL = 4'b0100; 
	end
	
	8'h54:
	begin
	 dec = 16'h0000_0000_0010_0000;
	 MUX_SEL = 4'b0101; 
	end
	
	8'h55:
	begin
	 dec = 16'h0000_0000_0100_0000;
	 MUX_SEL = 4'b0110; 
	end
	
	8'h56:
	begin
	 dec = 16'h0000_0000_1000_0000;
	 MUX_SEL = 4'b0111; 
	end
	
	8'h57:
	begin
	 dec = 16'h0000_0001_0000_0000;
	 MUX_SEL = 4'b1000; 
	end
	
	8'h58:
	begin
	 dec = 16'h0000_0010_0000_0000;
	 MUX_SEL = 4'b1001; 
	end
	
	default:
	 begin
	  dec = 16'b1000_0000_0000_0000;
	  MUX_SEL = 4'b1111;
	 end 
	 
	endcase
	
end 

endmodule