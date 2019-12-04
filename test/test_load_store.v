`timescale 1ns/100ps
`include "../ex/load_store.v"

module test_load_store();
  parameter STEP = 10;
  integer i;

  reg clk;
  always begin
    #(STEP / 2) clk = ~clk;
  end

  reg [31:0]  base;
  reg [31:0]  offset;
  reg [31:0]  data;
  reg         store;
  wire [31:0] result;

  load_store ld_st (
    .clk(clk),
    .base(base),
    .offset(offset),
    .data(data),
    .store(store),
    .result(result)
  );

  initial begin
    clk = 1'b1;
    base = 32'h0;
    offset = 32'h0;
    data = 32'h5;
    store = 1'b0;
    // load test
    for (i = 0; i < 12; i = i + 1) begin
      #(STEP);
      $display("result: %h, expected %h", result, base);
      check_value(result, base);
      base = base + 32'h1;
    end

    // store and load test
    for (i = 0; i < 12; i = i + 1) begin
      data = $random(data);
      offset = $random(offset);
      store = 1'b1;
      #(STEP);
      store = 1'b0;
      #(STEP);
      $display("result: %h, expected %h", result, data);
      check_value(result, data);
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
