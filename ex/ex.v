`include "../ex/adder.v"
`include "../a_stage/a_stage.v"
`include "../ex/flag_register.v"

module ex (
  input clk,
  input rst,
  input [31:0] rd_value_i,
  input [31:0] rs_value_i,
  input [31:0] imm_value_i,

  input [7:0] opcode_i,
  input ctrl_inte_i,
  input ctrl_logic_i,
  input ctrl_shift_i,
  input ctrl_ld_i,
  input ctrl_st_i,
  input ctrl_br_i,
  input immf_i,

  output stall_o,
  input  stall_i,

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
    .opr1_i(rs_value_i),
    .minus_i(opcode[0]),      // if 1 then inst "sub"
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


  a_stage result_stage (
    .clk(clk),
    .rst(rst),
    .v_i(1'b1),
    .v_o(),
    .data_i(selected_result),
    .data_o(result_o),
    .stall_i(stall_i),
    .stall_o(stall_o)
  );


endmodule
