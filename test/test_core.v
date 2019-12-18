`timescale 1ns/100ps
`include "../top/core.v"

module test_core();

  parameter STEP = 10;
  integer i, j;

  reg clk;
  always begin
    #(STEP / 2) clk = ~clk;
  end

  reg rst;

  core core0 (
    .clk(clk),
    .rst(rst)
  );

  initial begin
    // store iinstrucion to instrucion memory
    $readmemh("../mem/mem.dat", core0.Inst_mem.mem_bank);
    // set initial value
    i = 0;
    clk = 1'b0;
    rst = 1'b0;

    // wait for reset
    #(STEP * 10);

    // disable reset
    rst = 1'b1;

    // run
    for (i = 0; i < 10; i = i + 1) begin
      #(STEP);
    end

    $finish;
  end

  always @(posedge clk) begin
    $display("########## cycle %d ##########", i);
    for (j = 0; j < 16; j = j + 1) begin
      $write("|   %h", j[3:0]);
    end
    $display("|");
    $write("|%h", core0.id0.register.r0.data_o[15:0]);
    $write("|%h", core0.id0.register.r1.data_o[15:0]);
    $write("|%h", core0.id0.register.r2.data_o[15:0]);
    $write("|%h", core0.id0.register.r3.data_o[15:0]);
    $write("|%h", core0.id0.register.r4.data_o[15:0]);
    $write("|%h", core0.id0.register.r5.data_o[15:0]);
    $write("|%h", core0.id0.register.r6.data_o[15:0]);
    $write("|%h", core0.id0.register.r7.data_o[15:0]);
    $write("|%h", core0.id0.register.r8.data_o[15:0]);
    $write("|%h", core0.id0.register.r9.data_o[15:0]);
    $write("|%h", core0.id0.register.ra.data_o[15:0]);
    $write("|%h", core0.id0.register.rb.data_o[15:0]);
    $write("|%h", core0.id0.register.rc.data_o[15:0]);
    $write("|%h", core0.id0.register.rd.data_o[15:0]);
    $write("|%h", core0.id0.register.re.data_o[15:0]);
    $write("|%h", core0.id0.register.rf.data_o[15:0]);
    $display("|");

    $display("---------- Instruction fetch ----------");
    $display("PC: %h", core0.ifetch0.pc);
    $display("inst_i: %h", core0.ifetch0.inst_i);
    $display("branch_i: %b", core0.ifetch0.branch_i);
    $display("branch_addr_i: %h", core0.ifetch0.branch_addr_i);
    $display("stall_i: %b", core0.ifetch0.stall_i);
    $display("");
    $display("---------- Instruction decode ----------");
    $display("PC: %h", core0.id0.pc_value_o);
    $display("rd_value: %h", core0.id0.rd_value_o);
    $display("rs_value: %h", core0.id0.rs_value_o);
    $display("imm_value: %h", core0.id0.imm_value_o);
    $display("ctrl_inte: %h", core0.id0.ctrl_inte_o);
    $display("stall_i: %b", core0.id0.stall_i);
    $display("");
    $display("---------- Execute ----------");
    $display("result: %h", core0.ex0.result_o);
    $display("adder_i0: %h", core0.ex0.adder0.opr0_i);
    $display("adder_i1: %h", core0.ex0.adder0.opr1_i);
    $display("result_adder: %h", core0.ex0.adder0.result_o);
    $display("");
    $display("---------- Write back ----------");
    $display("wb_en_o: %h", core0.wb0.wb_en_o);
    $display("dest_reg_addr_o: %h", core0.wb0.dest_reg_addr_o);
    $display("wb_data_o: %h", core0.wb0.wb_data_o);
  end

endmodule
