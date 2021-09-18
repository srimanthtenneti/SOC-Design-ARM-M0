
module BAUDGEN
(
  input wire clk,
  input wire resetn,
  output wire baudtick
);


reg [21:0] count_reg;
wire [21:0] count_next;

//Counter
always @ (posedge clk, negedge resetn)
  begin
    if(!resetn)
      count_reg <= 0;
    else
      count_reg <= count_next;
end


//Baudrate  = 19200 = 50Mhz/(163*16)
assign count_next = ((count_reg == 162) ? 0 : count_reg + 1'b1);

assign baudtick = ((count_reg == 162) ? 1'b1 : 1'b0);

endmodule
