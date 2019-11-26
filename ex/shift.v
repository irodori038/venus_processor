module shift (
  input [31:0] src,
  input [31:0] dst,
  input left,
  input right,
  input math_shift,
  output [31:0] result,
  output cf
);

  wire [33:0] result_left;
  wire [33:0] result_right;
  wire [33:0] result_math_shift;

  wire [33:0] tmp;

  assign tmp = {1'b0, dst, 1'b0};

  assign result_left       = tmp << src[4:0];
  assign result_right      = tmp >> src[4:0];
  assign result_math_shift = tmp >>> src[4:0];

  if (left) begin
    result = result_left[32:1];
    cf = result_left[33];
  end
  else if (right) begin
    result = result_right[32:1];
    cf = result_right[0];
  end
  else if (math_shift) begin
    result = result_math_shift;
    cf = result_right[0];
  end
  else begin
    result = 32'h0;
    cf = 1'b0;
  end
  
endmodule
