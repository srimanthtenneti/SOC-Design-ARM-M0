`timescale 1ns / 1ps


module GenericCounter(
     CLK,
     RESET,
     ENABLE_IN,
	  TRIG_OUT,
	  COUNT
    );
	parameter COUNTER_WIDTH=4;
	parameter COUNTER_MAX=4;
	
	input CLK;
	input RESET;
	input ENABLE_IN;
	output TRIG_OUT;
	output [COUNTER_WIDTH-1:0] COUNT;
	
	reg [COUNTER_WIDTH-1:0] counter;
	reg triggerout;


	always@(posedge CLK)begin
		if (RESET)
			counter<=0;
		else begin
			if (ENABLE_IN) begin
				if (counter==(COUNTER_MAX)) 
					counter<=0;
				else
					counter<=counter+1;
			end
		end
	end
	
	always@(posedge CLK)begin
		if (RESET)
			triggerout<=0;
		else begin
			if (ENABLE_IN && (counter==(COUNTER_MAX)))
				triggerout<=1;
			else
				triggerout<=0;
		end
	end
	
	assign COUNT=counter;
	assign TRIG_OUT=triggerout;
	
endmodule