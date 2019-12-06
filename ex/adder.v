module adder (
  input [31:0] opr0_i,
  input [31:0] opr1_i,
  input minus_i,
  output [31:0] result_o,
  output zero_flag_o,
  output pos_flag_o,
  output neg_flag_o,
  output overflow_flag_o
);

  wire [31:0] tmp;
  wire [32:0] result_tmp;

  assign tmp = minus_i ? ~opr1_i : opr1_i;
  assign result_tmp = opr0_i + tmp + minus_i;

  assign result_o = result_tmp[31:0];
  assign zero_flag_o = ~|result_tmp[31:0];
  assign pos_flag_o = ~result_tmp[31];
  assign neg_flag_o = result_tmp[31];
  assign overflow_flag_o = result_tmp[32];

endmodule
