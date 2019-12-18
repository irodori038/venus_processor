module wb (
  input wb_en_i,
  input [3:0] dest_reg_addr_i,
  input [31:0] wb_data_i,
  output wb_en_o,
  output [3:0] dest_reg_addr_o,
  output [31:0] wb_data_o
);

  assign wb_en_o = wb_en_i;
  assign dest_reg_addr_o = dest_reg_addr_i;
  assign wb_data_o = wb_data_i;

endmodule
