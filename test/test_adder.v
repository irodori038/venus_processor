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
  wire [32:0] sub_tmp;
  assign adder_tmp = opr0 + opr1;
  assign sub_tmp = opr0 - opr1;

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

  function check_overflow_add;
    input [31:0] a, b, tmp;
    if (~a[31] & ~b[31]) begin
      check_overflow_add = tmp[31];
    end
    else if (a[31] & b[31]) begin
      check_overflow_add = ~tmp[31];
    end
    else begin
      check_overflow_add = 1'b0;
    end
  endfunction

  function check_overflow_sub;
    input [31:0] a, b, tmp;
    if (~a[31] & b[31]) begin
      check_overflow_sub = tmp[31];
    end
    else if (a[31] & ~b[31]) begin
      check_overflow_sub = ~tmp[31];
    end
    else begin
      check_overflow_sub = 1'b0;
    end
  endfunction

  initial begin
    opr0 = 32'h3;
    opr1 = 32'h5;
    for (i = 0; i < 10; i = i + 1) begin
      opr0 = $random(opr0);
      opr1 = $random(opr1);
      minus = opr0[20];
      #(STEP);
      dump_values();
      if (~minus) begin
        check_value32(result, adder_tmp[31:0], "add");
        check_value1(zf_o_adder0, ~|adder_tmp[31:0], "zf");
        check_value1(pf_o_adder0, ~adder_tmp[31], "pf");
        check_value1(nf_o_adder0, adder_tmp[31], "nf");
      end
      else begin
        check_value32(result, sub_tmp[31:0], "sub");
        check_value1(zf_o_adder0, ~|sub_tmp[31:0], "zf");
        check_value1(pf_o_adder0, ~sub_tmp[31], "pf");
        check_value1(nf_o_adder0, sub_tmp[31], "nf");
      end
    end
    $finish;
  end


  task check_value32;
    input [31:0] a, b;
    input string msg;
    begin
      if (a != b) begin
        $display("-----------------------------------------");
        $display("ERROR at %s: %h != %h", msg, a, b);
        // dump_values();
      end
    end
  endtask

  task check_value1;
    input a, b;
    input string msg;
    begin
      if (a != b) begin
        $display("-----------------------------------------");
        $display("ERROR at %s: %b != %b", msg, a, b);
        // dump_values();
      end
    end
  endtask

  task dump_values;
    begin
      $write("OPR0: %h (%b, ", opr0, opr0);
      if (~opr0[31]) begin
        $display("+%d", opr0[31:0]);
      end
      else begin
        $display("-%d", ~(opr0[31:0])+32'h1);
      end
      $write("OPR1: %h (%b, ", opr1, opr1);
      if (~opr1[31]) begin
        $display("+%d", opr1[31:0]);
      end
      else begin
        $display("-%d", ~(opr1[31:0])+32'h1);
      end
      $display("MINS: %b", minus);
      $display("RSLT: %h", result);
      if (~minus) begin
        $display("EXPT: %h", adder_tmp[31:0]);
      end
      else begin
        $display("EXPT: %h", sub_tmp[31:0]);
      end
      $display("ZF  : %h", zf_o_adder0);
      $display("PF  : %h", pf_o_adder0);
      $display("NF  : %h", nf_o_adder0);
      $display("OF  : %h", of_o_adder0);
    end
  endtask

endmodule
