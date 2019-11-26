module execute (
  clk,
  rst,
  rd_value_i,
  rs_value_i,
  imm_value_i,
  immf_i,
  ctrl_inte_i,
  ctrl_logic_i,
  ctrl_shift_i,
  ctrl_ld_i,
  ctrl_st_i,
  ctrl_br_i,
  stall_i
);

  input clk, rst;     // rst: active Low
  input [31:0] rd_value_i;
  input [31:0] rs_value_i;
  input [31:0] imm_value_i;
  input immf_i;
  input ctrl_inte_i;
  input ctrl_logic_i;
  input ctrl_shift_i;
  input ctrl_ld_i;
  input ctrl_st_i;
  input ctrl_br_i;
  input stall_i;

  
endmodule
