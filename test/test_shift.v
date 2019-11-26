`timescale 1ns/100ps
`include "../ex/shift.v"

module test_shift();

  parameter STEP = 10;
  integer i;

  reg [31:0] src, dst;

  wire [31:0] result_left;
  wire cf_left;
  shift left_shift (
    .src(src),
    .dst(dst),
    .left(1'b1),
    .right(1'b0),
    .math_shift(1'b0),
    .result(result_left),
    .cf(cf_left)
  );

  wire [31:0] result_right;
  wire cf_right;
  shift right_shift (
    .src(src),
    .dst(dst),
    .left(1'b0),
    .right(1'b1),
    .math_shift(1'b0),
    .result(result_right),
    .cf(cf_right)
  );

  wire [31:0] result_math;
  wire cf_math;
  shift math_shift (
    .src(src),
    .dst(dst),
    .left(1'b0),
    .right(1'b0),
    .math_shift(1'b1),
    .result(result_math),
    .cf(cf_math)
  );

  initial begin
    for (i = 0; i < 10; i++) begin
      src = $random(src);
      dst = $random(dst);
      check_value(result_left, dst << src);
      check_value(result_right, dst >> src);
      check_value(result_math, dst >>> src);
      #(STEP);
    end
    $finish;
  end


  task check_value;
    input [31:0] a, b;
    begin
      if (a != b) begin
        $display("ERROR: %h != %h", a, b);
      end
    end
  endtask

endmodule
