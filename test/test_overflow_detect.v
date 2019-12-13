`timescale 1ns/100ps
`include "../ex/overflow_detect.v"

module test_adder();
  `include "../ex/overflow_detect.v"

  integer i;
  parameter STEP = 10;

  reg [31:0] opr0, opr1;
  reg [31:0] result;
  reg minus;
  reg overflow;


  initial begin
    minus = 1'b0;

    opr0 = {1'b0, {31{1'b0}}};
    opr1 = {1'b0, {31{1'b0}}};
    result = {1'b0, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of0");

    opr0 = {1'b0, {31{1'b0}}};
    opr1 = {1'b0, {31{1'b0}}};
    result = {1'b1, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b1, "of1");

    opr0 = {1'b1, {31{1'b0}}};
    opr1 = {1'b1, {31{1'b0}}};
    result = {1'b0, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b1, "of2");

    opr0 = {1'b1, {31{1'b0}}};
    opr1 = {1'b1, {31{1'b0}}};
    result = {1'b1, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of3");

    opr0 = {1'b0, {31{1'b0}}};
    opr1 = {1'b1, {31{1'b0}}};
    result = {1'b0, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of4");

    opr0 = {1'b0, {31{1'b0}}};
    opr1 = {1'b1, {31{1'b0}}};
    result = {1'b1, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of5");
    
    opr0 = {1'b1, {31{1'b0}}};
    opr1 = {1'b0, {31{1'b0}}};
    result = {1'b0, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of6");

    opr0 = {1'b1, {31{1'b0}}};
    opr1 = {1'b0, {31{1'b0}}};
    result = {1'b1, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of7");



    minus = 1'b1;

    opr0 = {1'b0, {31{1'b0}}};
    opr1 = {1'b0, {31{1'b0}}};
    result = {1'b0, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of8");

    opr0 = {1'b0, {31{1'b0}}};
    opr1 = {1'b0, {31{1'b0}}};
    result = {1'b1, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of9");

    opr0 = {1'b1, {31{1'b0}}};
    opr1 = {1'b1, {31{1'b0}}};
    result = {1'b0, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of10");

    opr0 = {1'b1, {31{1'b0}}};
    opr1 = {1'b1, {31{1'b0}}};
    result = {1'b1, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of11");

    opr0 = {1'b0, {31{1'b0}}};
    opr1 = {1'b1, {31{1'b0}}};
    result = {1'b0, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of12");

    opr0 = {1'b0, {31{1'b0}}};
    opr1 = {1'b1, {31{1'b0}}};
    result = {1'b1, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b1, "of13");
    
    opr0 = {1'b1, {31{1'b0}}};
    opr1 = {1'b0, {31{1'b0}}};
    result = {1'b0, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b1, "of14");

    opr0 = {1'b1, {31{1'b0}}};
    opr1 = {1'b0, {31{1'b0}}};
    result = {1'b1, {31{1'b0}}};
    #(STEP);
    overflow = overflow_detect(opr0, opr1, result, minus);
    check_value1(overflow, 1'b0, "of15");

    $finish;
  end


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

endmodule
