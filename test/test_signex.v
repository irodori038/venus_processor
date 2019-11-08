`timescale 1ns/100ps
`include "../id/SignEx.v"

module test_signex();
  parameter STEP = 10;

  wire [31:0] ext;
  wire [31:0] not_ext;
  reg [15:0] value_i;

  assign ext = extend_sign(1, value_i);
  assign not_ext = extend_sign(0, value_i);

  initial begin
    value_i = 16'h1;
    $display("%b", ext);
    $display("%b", not_ext);
    $display("----------------");
    value_i = 16'hF000;
    $display("%b", ext);
    $display("%b", not_ext);
    $finish;
  end

endmodule
