`timescale 1ns/100ps
`include "../ex/multiplier.v"

module test_multiplier();
  integer i;
  parameter STEP = 10;
  reg [31:0] random_tmp = 5;

  reg [31:0] opr0, opr1;

  wire [31:0] result;

  multiplier mult0 (
    .opr0(opr0),
    .opr1(opr1),
    .result(result)
  );

  initial begin
    for (i = 0; i <= 1000; i = i + 1)
      check();
    $finish;
  end


  task check;
    begin
      opr0 <= $random(random_tmp);
      opr1 <= $random(random_tmp);
      #(STEP);
      if (result !== opr0 * opr1) begin
        $display("######## Wrong Answer (mult) ##########");
        $display("opr0: %d (%b)", opr0, opr0);
        $display("opr1: %d (%b)", opr1, opr1);
        $display("expc: %d (%b)", opr0*opr1, opr0*opr1);
        $display("rslt: %d (%b)", result, result);
      end
    end
  endtask

endmodule
