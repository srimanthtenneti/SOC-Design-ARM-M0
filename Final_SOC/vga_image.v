


module vga_image(
  input wire clk,
  input wire resetn,
  input wire [9:0] pixel_x,
  input wire [9:0] pixel_y,
  input wire image_we,
  input wire [7:0] image_data,
  input wire [15:0] address,
  output wire [7:0] image_rgb
  );


  wire [15:0] addr_r;
  wire [14:0] addr_w;
  wire [7:0] din;
  wire [7:0] dout;
  
  wire [9:0] img_x;
  wire [9:0] img_y;

  reg [15:0] address_reg;
  
 //buffer address = bus address -1 , as the first address is used for console
  always @(posedge clk)
    address_reg <= address-1;

//Frame buffer
 dual_port_ram_sync
  #(.ADDR_WIDTH(15), .DATA_WIDTH(8))
  uimage_ram
  ( .clk(clk),
    .reset_n(resetn),
    .we(image_we),
    .addr_a(addr_w),
    .addr_b(addr_r),
    .din_a(din),
    .dout_a(),
    .dout_b(dout)
  ); 

  assign addr_w = address_reg[14:0];
  assign din = image_data;
  	
  assign img_x = pixel_x[9:0]-240;
  assign img_y = pixel_y[9:0];
  		
  assign addr_r = {1'b0,img_y[8:2], img_x[8:2]}; 
  
  assign image_rgb = dout;



endmodule
