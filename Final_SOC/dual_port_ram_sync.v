
module dual_port_ram_sync
  #(
      parameter ADDR_WIDTH = 6,
      parameter DATA_WIDTH = 8
  )
  (
  input wire clk,
  input wire reset_n,
  input wire we,
  input wire [ADDR_WIDTH-1:0] addr_a,
  input wire [ADDR_WIDTH-1:0] addr_b,
  input wire [DATA_WIDTH-1:0] din_a,
  
  output wire [DATA_WIDTH-1:0] dout_a,
  output wire [DATA_WIDTH-1:0] dout_b
  );

  reg [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];
  reg [ADDR_WIDTH-1:0] addr_a_reg;
  reg [ADDR_WIDTH-1:0] addr_b_reg;
  
  reg [ADDR_WIDTH:0] reset_addr;
  reg [1:0] reset_n_buf;
  
  always @ (posedge clk)
  begin
    // Clear each data when reset
    reset_n_buf = {reset_n_buf[0], reset_n};
    if (reset_n_buf == 2'b10)
    begin
      reset_addr <= 0;
    end
    else if ((!we) && (reset_addr[ADDR_WIDTH] == 1'b0))
    begin
      reset_addr <= reset_addr + 1;
    end

    if (we || (reset_addr[ADDR_WIDTH] == 1'b0))
      ram[we ? addr_a : reset_addr] <= we ? din_a : {DATA_WIDTH{1'b0}};
    addr_a_reg <= addr_a;
    addr_b_reg <= addr_b;
  end
  
  assign dout_a = ram[addr_a_reg];
  assign dout_b = ram[addr_b_reg];
  
endmodule
