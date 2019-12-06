`timescale 1ns/100ps
`include "../ex/branch.v"

module test_branch();
  parameter STEP = 10;
  integer i;

  reg [31:0]  pc;
  reg [2:0]   cc;
  reg [5:0]   flags;
  reg [31:0]  src;
  reg         abs;
  wire [31:0] dest_addr_o_branch0;
  wire        branch_en_o_branch0;

  branch branch0 (
    .pc_i(pc),
    .cc_i(cc),
    .flags_i(flags),
    .src_i(src),
    .abs_i(abs),
    .dest_addr_o(dest_addr_o_branch0),
    .branch_en_o(branch_en_o_branch0)
  );

  initial begin
    pc = 32'h1;
    cc = 3'b000;
    flags = 6'b000000;
    src = 32'h2;
    abs = 1'b0;
    #(STEP);

    // branch address check (pc relative)
    for (i = 0; i < 20; i = i + 1) begin
      pc = $random(pc);
      src = $random(src);
      #(STEP);
      check_value(dest_addr_o_branch0, pc + src);
    end

    // branch address check (absolute)
    abs = 1'b1;
    for (i = 0; i < 20; i = i + 1) begin
      pc = $random(pc);
      src = $random(src);
      #(STEP);
      check_value(dest_addr_o_branch0, src);
    end

    // condition check test
    abs = 1'b0;
    for (i = 0; i < 20; i = i + 1) begin
      cc = 3'b000;
      flags = 6'b000000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b1);

      // zero flag test
      cc = 3'b001;
      flags = 6'b000000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b0);
      cc = 3'b001;
      flags = 6'b100000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b1);

      // positive flag test
      cc = 3'b010;
      flags = 6'b000000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b0);
      cc = 3'b010;
      flags = 6'b010000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b1);

      // negative flag test
      cc = 3'b011;
      flags = 6'b000000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b0);
      cc = 3'b011;
      flags = 6'b001000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b1);

      // carry flag test
      cc = 3'b100;
      flags = 6'b000000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b0);
      cc = 3'b100;
      flags = 6'b000100;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b1);

      // overflow flag test
      cc = 3'b101;
      flags = 6'b000000;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b0);
      cc = 3'b101;
      flags = 6'b000010;
      #(STEP);
      check_value(branch_en_o_branch0, 1'b1);
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

  task disp_values;
    input [2:0] cc;
    input [5:0] flags;
    input branch_en;
    begin
      $display("CC    : %b", cc);
      $display("FLAGS : %b", flags);
      $display("BRANCH: %b", branch_en_o_branch0);
      $display("-------------------");
    end
  endtask
  
endmodule
