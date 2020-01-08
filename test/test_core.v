`default_nettype none
`timescale 1ns/100ps
`include "../top/core.v"

module test_core();
  `include "../test/test_utils.v"

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
    for (i = 0; i < 12; i = i + 1) begin
      #(STEP);
    end

    $finish;
  end

  always @(posedge clk) begin
    $display("########## cycle %d ##########", i);
    print_regs();

    $display("---------- Instruction fetch ----------");
    $display("PC: %h", core0.ifetch0.pc);
    $display("inst_i: %h", core0.ifetch0.inst_i);
    $display("branch_i: %b", core0.ifetch0.branch_i);
    $display("branch_addr_i: %h", core0.ifetch0.branch_addr_i);
    $display("stall_i: %b", core0.ifetch0.stall_i);
    $display("");
    $display("---------- Instruction decode ----------");
    $display("PC: %h", core0.id0.pc_value_o);
    print_mnemonic(core0.ifetch0.inst_i[31:25]);
    $display("");
    $display("rd_value: %h", core0.id0.rd_value_o);
    $display("rs_value: %h", core0.id0.rs_value_o);
    $display("imm_value: %h", core0.id0.imm_value_o);
    $display("ctrl_inte: %h", core0.id0.ctrl_inte_o);
    $display("ctrl_br: %h", core0.id0.ctrl_br_o);
    $display("inst_i: %h", core0.id0.inst_i);
    $display("inst_i[31:25]: %b", core0.id0.inst_i[31:25]);
    $display("stall_i: %b", core0.id0.stall_i);
    $display("");
    $display("---------- Execute ----------");
    $display("PC: %h", core0.ex0.pc_value_i);
    print_mnemonic(core0.ex0.opcode_i);
    $display("");
    $display("stage result: %h", core0.ex0.result_o);
    $display("stage branch_en_o: %b", core0.ex0.branch_en_o);
    $display("adder_i0: %h", core0.ex0.adder0.opr0_i);
    $display("adder_i1: %h", core0.ex0.adder0.opr1_i);
    $display("result_adder: %h", core0.ex0.adder0.result_o);
    $display("branch: pc_i = %h", core0.ex0.branch0.pc_i);
    $display("branch: cc_i = %b", core0.ex0.branch0.cc_i);
    $display("branch: flags_i = %b", core0.ex0.branch0.flags_i);
    $display("branch: src_i = %h", core0.ex0.branch0.src_i);
    $display("branch: abs_i = %h", core0.ex0.branch0.abs_i);
    $display("branch: dest_addr_o = %h", core0.ex0.branch0.dest_addr_o);
    $display("ctrl: data_i[0] = %h", core0.ex0.ctrl_register.data_i[0]);
    $display("");
    $display("---------- Write back ----------");
    $display("wb_en_o: %h", core0.wb0.wb_en_o);
    $display("dest_reg_addr_o: %h", core0.wb0.dest_reg_addr_o);
    $display("wb_data_o: %h", core0.wb0.wb_data_o);
  end

endmodule

`default_nettype wire
