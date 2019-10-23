module pc(clk,
          set,
          addr_i,
          addr_o
          );

  parameter ADDR = 16;
  parameter WORD = 32;

  input           clk;
  input           set;
  input [ADDR:0]  addr_i;
  output [ADDR:0] addr_o;

  reg [ADDR:0] pc_value;
  
  wire next_pc;
  assign addr_o = pc_value;
  assign next_pc = pc_value + (set ? 16'h4 : addr_i);


  always @(posedge clk )
  begin
    pc_value <= next_pc;
  end // always @(posedge clk or negedge rst)

endmodule // pc
