module multiplier (
  input [31:0] opr0,
  input [31:0] opr1,
  output [31:0] result
);

  wire [63:0] tmp;
  assign tmp = opr0 * opr1;
  assign result = tmp[31:0];

endmodule
