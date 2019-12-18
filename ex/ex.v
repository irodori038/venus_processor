`include "../ex/adder.v"
`include "../a_stage/a_stage.v"
`include "../ex/flag_register.v"

module ex (
  input clk,
  input rst,
  input [31:0] rd_value_i,
  input [31:0] rs_value_i,
  input [31:0] imm_value_i,
  input [3:0] rd_addr_i,

  input [6:0] opcode_i,
  input ctrl_inte_i,
  input ctrl_logic_i,
  input ctrl_shift_i,
  input ctrl_ld_i,
  input ctrl_st_i,
  input ctrl_br_i,
  input immf_i,

  output  stall_o,
  output branch_en_o,
  output wb_en_o,
  output [3:0] rd_addr_o,

  output [31:0] result_o
);

  wire [31:0] result_o_adder0;
  wire flags_adder0;
  wire zero_flag_o_adder0;
  wire pos_flag_o_adder0;
  wire neg_flag_o_adder0;
  wire overflow_flag_o_adder0;
  assign flags_adder0 = {
    zero_flag_o_adder0,
    pos_flag_o_adder0,
    neg_flag_o_adder0,
    1'b0,
    overflow_flag_o_adder0,
    1'b0
  };

  adder adder0 (
    .opr0_i(rd_value_i),
    .opr1_i(immf_i ? imm_value_i : rs_value_i),
    .minus_i(opcode_i[0]),      // if 1 then inst "sub"
    .result_o(result_o_adder0),
    .zero_flag_o(zero_flag_o_adder0),
    .pos_flag_o(pos_flag_o_adder0),
    .neg_flag_o(neg_flag_o_adder0),
    .overflow_flag_o(overflow_flag_o_adder0)
  );




  `include "../ex/selector.v"
  wire [5:0] selected_flag;
  assign selected_flag = selector (
    .ctrl_inte(ctrl_inte_i),
    .result_from_adder({{26{1'b0}}, flags_adder0})
  );
  
  wire [31:0] selected_result;
  assign selected_result = selector(
    .ctrl_inte(ctrl_inte_i),
    .result_from_adder(result_o_adder0)
  );

  wire [31:0] data_o_ctrl_register;
  assign branch_en_o = data_o_ctrl_register[0];
  assign wb_en_o = data_o_ctrl_register[1];
  assign rd_addr_o = data_o_ctrl_register[5:2];

  a_stage ctrl_register (
    .clk(clk),
    .rst(rst),
    .v_i(1'b1),
    .v_o(),
    .data_i({26'h0, rd_addr_i, ~(ctrl_st_i | ctrl_br_i), ctrl_br_i}),
    .data_o(data_o_ctrl_register),
    .stall_i(1'b0),
    .stall_o(stall_o)
  );

  a_stage result_stage (
    .clk(clk),
    .rst(rst),
    .v_i(1'b1),
    .v_o(),
    .data_i(selected_result),
    .data_o(result_o),
    .stall_i(1'b0),
    .stall_o(stall_o)
  );


endmodule
