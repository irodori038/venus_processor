`include "../reg/register_cell.v"

module flag_register (
  input clk,
  input rst,
  input [5:0] data_i,
  input write,
  output [5:0] data_o
);

  wire [31:0] data_to_cell;
  wire [31:0] data_from_cell;
  assign data_to_cell = {{26{1'b0}}, data_i};
  assign data_o = data_from_cell[5:0];

  register_cell flag_register_cell (
    .clk(clk),
    .rst(rst),
    .data_i(data_to_cell),
    .data_o(data_from_cell),
    .w_reserve_i(1'b0),
    .w_reserve_o(),
    .wb_i(write)
  );

endmodule
