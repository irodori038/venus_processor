`timescale 1ns/100ps
`include "../ex/adder.v"

module test_adder();
  integer i;
  parameter STEP = 10;

  reg [31:0] opr0, opr1;
  reg minus;

  wire [31:0] result;
  wire zf_o_adder0, pf_o_adder0, nf_o_adder0, of_o_adder0;
  wire [32:0] adder_tmp;
  assign adder_tmp = opr0 + opr1;

  adder adder0 (
    .opr0_i(opr0),
    .opr1_i(opr1),
    .minus_i(minus),
    .result_o(result),
    .zero_flag_o(zf_o_adder0),
    .pos_flag_o(pf_o_adder0),
    .neg_flag_o(nf_o_adder0),
    .overflow_flag_o(of_o_adder0)
  );

  initial begin
    for (i = 0; i < 10; i = i + 1) begin
      opr0 = $random(opr0);
      opr1 = $random(opr1);
      minus = opr0[20];
      #(STEP);
      if (~minus) begin
        $display("------- add -------");
        check_value(result, adder_tmp[31:0]);
      end
      else begin
        $display("------- sub -------");
        check_value(result, adder_tmp[31:0]);
      end
      $display("------- zf  -------");
      check_value(zf_o_adder0, ~|adder_tmp[31:0]);
      $display("------- pf  -------");
      check_value(pf_o_adder0, ~adder_tmp[31]);
      $display("------- nf  -------");
      check_value(nf_o_adder0, adder_tmp[31]);
      $display("------- of  -------");
      check_value(of_o_adder0, adder_tmp[32]);
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
