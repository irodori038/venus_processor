`timescale 1ns/100ps
`include "../if/ifetch.v"
`include "DP_mem32x64k.v"

module test_ifetch();
  parameter STEP = 10;
  integer i;

  reg clk;
  always begin    // clock generation
    #(STEP / 2) clk = ~clk;
  end

  reg rst;
  reg branch;
  reg [15:0] branch_addr;
  reg stall;
  wire [15:0] inst_addr_o_ifetch0;
  wire [31:0] Q_DP_mem32x64k0;
  wire [31:0] inst_o_ifetch0;

  ifetch ifetch0 (
    .clk(clk),
    .rst(rst),
    .inst_i(Q_DP_mem32x64k0),
    .branch_i(branch),
    .branch_addr_i(branch_addr),
    .stall_i(stall),
    .inst_o(inst_o_ifetch0),
    .inst_addr_o(inst_addr_o_ifetch0)
  );

  reg W;
  reg [31:0] D;

  DP_mem32x64k DP_mem32x64k0 (
    .clk(clk),
    .A(inst_addr_o_ifetch0),
    .W(W),
    .D(D),
    .Q(Q_DP_mem32x64k0)
  );


  initial begin
    $dumpfile("test_ifetch.vcd");
    $dumpvars(0, test_ifetch);
    i = 0;
    clk = 1'b0;
    rst = 1'b0;
    branch = 1'b0;
    stall = 1'b0;
    W = 0;
    D = 32'h0;
    # (STEP * 4);

    rst = 1'b1;   // reset disable
    for (i = 1; i <= 5; i = i + 1) begin
      #(STEP);
    end
    branch_addr = 16'h0009;
    branch = 1'b1;
    stall = 1'b1;
    #(STEP);
    #(STEP);
    for (i = 7; i <= 10; i = i + 1) begin
      #(STEP);
    end
    $finish;
  end
  
  always @(posedge clk)
  begin
    $display("##### cycle %h #############", i);
    $display("RST\tPC\tADDR\tINST\t\tSTALL\tBRANCH");
    $display("%b\t%h\t%h\t%h\t%b\t%b", rst, ifetch0.pc, ifetch0.addr_r, inst_o_ifetch0, stall, branch);
  end
endmodule
