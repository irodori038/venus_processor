module shift (
  input [31:0] src,
  input [31:0] dst,
  input left,
  input right,
  input math_shift,
  output [31:0] result,
  output cf
);

  wire [2:0] op;
  wire [33:0] tmp;
  wire [33:0] result_left;
  wire [33:0] result_right;
  wire [33:0] result_math_shift;

  assign op = {math_shift, right, left};
  assign tmp = {1'b0, dst, 1'b0};
  
  assign result_left       = tmp << src[4:0];
  assign result_right      = tmp >> src[4:0];
  assign result_math_shift = tmp >>> src[4:0];

  function [32:0] shifter;
    input [2:0] op;
    input [33:0] result_left;
    input [33:0] result_right;
    input [33:0] result_math_shift;

    case (op)
      3'b001: shifter = {result_left[33], result_left[32:1]};
      3'b010: shifter = {result_right[0], result_right[32:1]};
      3'b100: shifter = {result_math_shift[0], result_math_shift[32:1]};
      default: shifter = 32'b0;
    endcase
  endfunction

  wire [32:0] result_tmp;
  assign result_tmp = shifter(
    .op(op),
    .result_left(result_left),
    .result_right(result_right),
    .result_math_shift(result_math_shift)
  );

  assign result = result_tmp[31:0];
  assign cf     = result_tmp[32];
  
endmodule
