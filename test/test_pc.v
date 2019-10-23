`timescale 1ns/100ps
`include "../if/pc.v"

module test_pc();
  parameter STEP = 10;
  integer i;

  reg clk;
  always begin    // clock generation
    #(STEP / 2) clk = ~clk;
  end

  reg [16:0] addr_i;
  reg set;

  wire [16:0] addr_o_pc0;

  pc pc0(
    .clk(clk),
    .set(set),
    .addr_i(addr_i),
    .addr_o(addr_o_pc0)
  );

  initial begin
    clk = 1'b0;
    set = 1'b1;
    addr_i = 16'h0000;

    # (STEP * 4);
    set = 1'b0;
    for (i = 1; i <= 5; i = i + 1) begin
      #(STEP);
    end
    $finish;
  end
  
  always @(posedge clk)
  begin
    $display("##### cycle %h #############", i);
    $display("set\taddr_i\t\taddr_o\t\tnext_pc");
    $display("%b\t%h\t\t%h\t\t%h",set, addr_i, addr_o_pc0, pc0.next_pc);
  end
endmodule
