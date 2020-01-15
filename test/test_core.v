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
    for (i = 0; i < 50; i = i + 1) begin
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
    $display("PC: %h", core0.id0.pc_value_i);
    $display("stall: %b", core0.id0.stall_i);
    $display("rsvd_o_re: %b", core0.id0.reserved_o_register);
    print_mnemonic(core0.id0.inst_i[31:25]);
    write_args(core0.id0.inst_i);
    $display("");
    $display("Write Back enable: %b", core0.id0.wb_i);
    $display("Write Back data: %h", core0.id0.wb_data_i);
    $display("");
    $display("---------- Execute ----------");
    $display("PC: %h", core0.ex0.pc_value_i);
    print_mnemonic(core0.ex0.opcode_i);
    $display("");
    display_ctrl_line(
      core0.ex0.ctrl_inte_i,
      core0.ex0.ctrl_logic_i,
      core0.ex0.ctrl_shift_i,
      core0.ex0.ctrl_ld_i,
      core0.ex0.ctrl_st_i,
      core0.ex0.ctrl_br_i,
      core0.ex0.immf_i
    );
    $display("rd: %h", core0.ex0.rd_value_i);
    $display("rs: %h", core0.ex0.rs_value_i);
    $display("im: %h", core0.ex0.imm_value_i);
    display_flags(core0.ex0.flag_register.data_o);
    display_cc(core0.ex0.rd_addr_i[2:0]);
    $display("rsv_i: %b", core0.ex0.rsv_i);
    $display("---------- Write back ----------");
    $display("wb_en_o: %h", core0.wb0.wb_en_o);
    $display("dest_reg_addr_o: %h", core0.wb0.dest_reg_addr_o);
    $display("wb_data_o: %h", core0.wb0.wb_data_o);
  end

endmodule

`default_nettype wire
