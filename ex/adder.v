module adder (
  input [31:0] opr0,
  input [31:0] opr1,
  input minus,
  output [32:0] result
);

  wire [31:0] tmp;

  assign tmp = minus ? ~opr1 : opr1;
  assign result = opr0 + tmp + minus;

endmodule
