//////////////////////////////////////////////////////////////////////////////////
//END USER LICENCE AGREEMENT                                                    //


module VGAInterface(
    input CLK,
    input [7:0] COLOUR_IN,
    output reg [7:0] cout,
    output reg hs,
    output reg vs,
    output reg [9:0] addrh,
    output reg [9:0] addrv
    );


// Time in Vertical Lines
parameter VertTimeToPulseWidthEnd  = 10'd2;
parameter VertTimeToBackPorchEnd   = 10'd31;
parameter VertTimeToDisplayTimeEnd = 10'd511;
parameter VertTimeToFrontPorchEnd  = 10'd521;

// Time in Horizontal Lines
parameter HorzTimeToPulseWidthEnd  = 10'd96;
parameter HorzTimeToBackPorchEnd   = 10'd144;
parameter HorzTimeToDisplayTimeEnd = 10'd784;
parameter HorzTimeToFrontPorchEnd  = 10'd800;

wire TrigHOut, TrigDiv;
wire [9:0] HorzCount;
wire [9:0] VertCount;

//Divide the clock frequency
GenericCounter  #(.COUNTER_WIDTH(1), .COUNTER_MAX(1))
FreqDivider
(
	.CLK(CLK),
	.RESET(1'b0),
	.ENABLE_IN(1'b1),
	.TRIG_OUT(TrigDiv)
);

//Horizontal counter
GenericCounter  #(.COUNTER_WIDTH(10), .COUNTER_MAX(HorzTimeToFrontPorchEnd))
HorzAddrCounter
(
	.CLK(CLK),
	.RESET(1'b0),
	.ENABLE_IN(TrigDiv),
	.TRIG_OUT(TrigHOut),
	.COUNT(HorzCount)
);

//Vertical counter
GenericCounter  #(.COUNTER_WIDTH(10), .COUNTER_MAX(VertTimeToFrontPorchEnd))
VertAddrCounter
(
	.CLK(CLK),
	.RESET(1'b0),
	.ENABLE_IN(TrigHOut),
	.COUNT(VertCount)
);

//Synchronisation signals
always@(posedge CLK) begin
	if(HorzCount<HorzTimeToPulseWidthEnd)
			hs <= 1'b0;
	else
			hs <= 1'b1;

	if(VertCount<VertTimeToPulseWidthEnd)
			vs <= 1'b0;
	else
			vs <= 1'b1;
end

//Color signals
always@(posedge CLK) begin
	if ( ( (HorzCount >= HorzTimeToBackPorchEnd ) && (HorzCount < HorzTimeToDisplayTimeEnd) ) &&
		  ( (VertCount >= VertTimeToBackPorchEnd ) && (VertCount < VertTimeToDisplayTimeEnd) ) ) 
		cout <= COLOUR_IN;
	else
		cout <= 8'b00000000;
end

//output horizontal and vertical addresses 
always@(posedge CLK)begin
	if ((HorzCount>HorzTimeToBackPorchEnd)&&(HorzCount<HorzTimeToDisplayTimeEnd))
		addrh<=HorzCount-HorzTimeToBackPorchEnd;
	else
		addrh<=10'b0000000000;
end	
	
always@(posedge CLK)begin
	if ((VertCount>VertTimeToBackPorchEnd)&&(VertCount<VertTimeToDisplayTimeEnd))
		addrv<=VertCount-VertTimeToBackPorchEnd;
	else
		addrv<=10'b0000000000;
end

endmodule
