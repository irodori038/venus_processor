`include "../if/ifetch.v"
`include "../mem/DP_mem32x64k.v"
`include "../id/ID.v"
`include "../ex/ex.v"
`include "../wb/wb.v"

module core (
  input clk,
  input rst
);

  // ********** Instruction Fetch ***********

  wire [15:0] inst_addr_o_ifetch0;
  wire [31:0] Q_DP_mem32x64k0;
  wire [31:0] inst_o_ifetch0;
  wire branch_en_o_ex0;
  // wire [15:0] branch_addr_o_ex0;
  wire stall_o_id0;
  wire [31:0] wb_data_o_wb0;

  ifetch ifetch0 (
    .clk(clk),
    .rst(rst),
    .inst_i(Q_DP_mem32x64k0),
    .branch_i(branch_en_o_ex0),
    .branch_addr_i(wb_data_o_wb0[15:0]),
    .stall_i(stall_o_id0),
    .inst_o(inst_o_ifetch0),
    .inst_addr_o(inst_addr_o_ifetch0)
  );

  // Instruction Memory
  DP_mem32x64k Inst_mem (
    .clk(clk),
    .A(inst_addr_o_ifetch0),
    .W(1'b0),
    .D(32'h0),
    .Q(Q_DP_mem32x64k0)
  );



  // ********** Instruction decode ***********

  wire [31:0] rd_value_o_id0;
  wire [31:0] rs_value_o_id0;
  wire [31:0] imm_value_o_id0;
  wire immf_o_id0;
  wire stall_o_ex0;
  wire ctrl_inte_o_id0;
  wire ctrl_logic_o_id0;
  wire ctrl_shift_o_id0;
  wire ctrl_ld_o_id0;
  wire ctrl_st_o_id0;
  wire ctrl_br_o_id0;
  wire [15:0] pc_value_o_id0;
  wire wb_en_o_wb0;
  wire [3:0] dest_reg_addr_o_wb0;
  wire [6:0] opcode_o_id0;
  wire [3:0] rd_addr_o_id0;
  
  ID id0 (
    .clk(clk),
    .rst(rst),
    .inst_i(inst_o_ifetch0),
    .rd_value_o(rd_value_o_id0),
    .rs_value_o(rs_value_o_id0),
    .imm_value_o(imm_value_o_id0),
    .immf_o(immf_o_id0),
    .stall_i(stall_o_ex0),
    .stall_o(stall_o_id0),
    .ctrl_inte_o(ctrl_inte_o_id0),
    .ctrl_logic_o(ctrl_logic_o_id0),
    .ctrl_shift_o(ctrl_shift_o_id0),
    .ctrl_ld_o(ctrl_ld_o_id0),
    .ctrl_st_o(ctrl_st_o_id0),
    .ctrl_br_o(ctrl_br_o_id0),
    .wb_r_i(dest_reg_addr_o_wb0),
    .wb_i(wb_en_o_wb0),
    .wb_data_i(wb_data_o_wb0),
    .pc_value_i(inst_addr_o_ifetch0),
    .pc_value_o(pc_value_o_id0),
    .opcode_o(opcode_o_id0),
    .rd_addr_o(rd_addr_o_id0)
  );


  // ********** Execute ***********

  wire [31:0] result_o_ex0;
  wire [3:0] dest_reg_addr_o_ex0;
  wire wb_en_o_ex0;

  ex ex0 (
    .clk(clk),
    .rst(rst),
    .rd_value_i(rd_value_o_id0),
    .rs_value_i(rs_value_o_id0),
    .imm_value_i(imm_value_o_id0),
    .rd_addr_i(rd_addr_o_id0),
    .pc_value_i(pc_value_o_id0),
    .opcode_i(opcode_o_id0),
    .ctrl_inte_i(ctrl_inte_o_id0),
    .ctrl_logic_i(ctrl_logic_o_id0),
    .ctrl_shift_i(ctrl_shift_o_id0),
    .ctrl_ld_i(ctrl_ld_o_id0),
    .ctrl_st_i(ctrl_st_o_id0),
    .ctrl_br_i(ctrl_br_o_id0),
    .immf_i(immf_o_id0),
    .stall_o(stall_o_ex0),
    .branch_en_o(branch_en_o_ex0),
    .wb_en_o(wb_en_o_ex0),
    .rd_addr_o(dest_reg_addr_o_ex0),
    .result_o(result_o_ex0)
  );



  // ********** Write back ***********
  //
  wb wb0 (
    .wb_en_i(wb_en_o_ex0),
    .dest_reg_addr_i(dest_reg_addr_o_ex0),
    .wb_data_i(result_o_ex0),
    .wb_en_o(wb_en_o_wb0),
    .dest_reg_addr_o(dest_reg_addr_o_wb0),
    .wb_data_o(wb_data_o_wb0)
  );



  // ********** Execute ***********


endmodule 
