`timescale 1ns/100ps
`include "../ex/adder.v"

module test_adder();
  integer i;
  parameter STEP = 10;
  reg [31:0] random_tmp = 5;

  reg [31:0] opr0, opr1;
  reg minus;

  wire [32:0] result;

  adder adder0 (
    .opr0(opr0),
    .opr1(opr1),
    .minus(minus),
    .result(result)
  );

  initial begin
    for (i = 0; i <= 1000; i = i + 1)
      check_add();
    for (i = 0; i <= 1000; i = i + 1)
      check_minus();
    $finish;
  end


  task check_add;
    begin
      opr0 <= $random(random_tmp);
      opr1 <= $random(random_tmp);
      minus <= 1'b0;
      #(STEP);
      if (result[31:0] !== opr0 + opr1) begin
        $display("######## Wrong Answer (plus) ##########");
        $display("opr0: %d (%b)", opr0, opr0);
        $display("opr1: %d (%b)", opr1, opr1);
        $display("expc: %d (%b)", opr0+opr1, opr0+opr1);
        $display("rslt: %d (%b)", result[31:0], result[31:0]);
      end
    end
  endtask

  task check_minus;
    begin
      opr0 <= $random(random_tmp);
      opr1 <= $random(random_tmp);
      minus <= 1'b1;
      #(STEP);
      if (result[31:0] !== opr0 - opr1) begin
        $display("######## Wrong Answer (minus) ##########");
        $display("opr0: %d (%b)", opr0, opr0);
        $display("opr1: %d (%b)", opr1, opr1);
        $display("expc: %d (%b)", opr0-opr1, opr0-opr1);
        $display("rslt: %d (%b)", result[31:0], result[31:0]);
      end
    end
  endtask
endmodule
