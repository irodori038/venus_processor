`timescale 1ns/100ps
`include "../if/ifetch.v"

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


  initial begin
    i = 0;
    clk = 1'b0;
    rst = 1'b0;
    branch = 1'b0;
    stall = 1'b0;
    # (STEP * 4);

    rst = 1'b1;   // reset disable
    for (i = 1; i <= 5; i = i + 1) begin
      #(STEP);
    end
    $finish;
  end
  
  always @(posedge clk)
  begin
    $display("##### cycle %h #############", i);
    $display("%h", ifetch0.inst_addr_o);
    // $display("RST\tPC\tINST\t\tSTALL\tBRANCH");
    // $display("%b\t%h\t%h\t%b\t%b", rst, inst_addr_o_ifetch0, inst_o_ifetch0, stall, branch);
  end
endmodule
