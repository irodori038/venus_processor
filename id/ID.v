`include "../reg/g_register.v"

module ID (
  clk,
  rst,
  inst_i,
  opr0_value_o,
  opr1_value_o,
  stall_i,
  stall_o,
  ctrl_inte_o,
  ctrl_logic_o,
  ctrl_shift_o,
  ctrl_ld_o,
  ctrl_st_o,
  ctrl_br_o,
  wb_r_i,
  wb_i,
  wb_data_i
);

  parameter W_DOPC  = 9;    // decoded opecode width
  parameter W_INST  = 32;   // instruction width
  parameter P_RD    = 20;   // position of register
  parameter W_OPC   = 7;    // opecode width

  input clk, rst;
  input [31:0] inst_i;
  input stall_i;
  input wb_i;
  input [3:0] wb_r_i;
  input [31:0] wb_data_i;

  output ctrl_inte_o;
  output ctrl_logic_o;
  output ctrl_shift_o;
  output ctrl_ld_o;
  output ctrl_st_o;
  output ctrl_br_o;

  output stall_o;
  output [31:0] opr0_value_o;
  output [31:0] opr1_value_o;

  wire [W_DOPC-1:0] dopc; // decoded opecode

  assign dopc    = decode_ins(inst_i[W_INST-1:W_INST-W_OPC]);

  assign inte    = dopc[W_DOPC-1]; // integer
  assign logic   = dopc[W_DOPC-2]; // logic
  assign shift   = dopc[W_DOPC-3]; // shift
  assign ld      = dopc[W_DOPC-4]; // load
  assign st      = dopc[W_DOPC-5]; // store
  assign br      = dopc[W_DOPC-6]; // branch
  assign imme16  = dopc[W_DOPC-7]; // immediate 16
  assign rsv_o   = dopc[W_DOPC-8]; // reserve
  assign und     = dopc[W_DOPC-9]; // undefined

  // **************** decode opecode *****************
    // dopc = {inte, logic, shift, ls, br, imm16, rsv, und}
    // integer, logic, shift, load, store, branch, immediate, reserved, undefined
    function [W_DOPC -1: 0] decode_ins;
      input [6: 0] opcode;
      case (opcode) // synopsys parallel_case
        // integer reg - reg
        7'b0000_000: decode_ins = 9'b100000_0_1_0;
        7'b0000_001: decode_ins = 9'b100000_0_1_0;
        7'b0000_010: decode_ins = 9'b100000_0_1_0;
        7'b0000_011: decode_ins = 9'b100000_0_1_0;
        7'b0000_100: decode_ins = 9'b100000_0_0_0;
        7'b0000_101: decode_ins = 9'b100000_0_1_0;
        7'b0000_110: decode_ins = 9'b100000_0_1_0;
        7'b0000_111: decode_ins = 9'b100000_0_1_0;

        // shift reg - reg
        7'b000_1000: decode_ins = 9'b001000_1_1_0;
        7'b000_1000: decode_ins = 9'b001000_1_1_0;
        7'b000_1000: decode_ins = 9'b001000_1_1_0;
        7'b000_1000: decode_ins = 9'b001000_1_1_0;
        7'b000_1000: decode_ins = 9'b001000_1_1_0;
        7'b000_1000: decode_ins = 9'b001000_1_1_0;
        
        // logic reg - reg
        7'b00_10000: decode_ins = 9'b010000_0_1_0;
        7'b00_10001: decode_ins = 9'b010000_0_1_0;
        7'b00_10010: decode_ins = 9'b010000_0_1_0;
        7'b00_10011: decode_ins = 9'b010000_0_1_0;

        // set reg - reg
        7'b00_10110: decode_ins = 9'b000000_0_1_0;
        7'b00_10111: decode_ins = 9'b000000_0_1_0;

        // load
        7'b00_11000: decode_ins = 9'b000100_0_1_0;

        // store
        7'b00_11001: decode_ins = 9'b000010_0_1_0;

        // branch
        7'b00_11100: decode_ins = 9'b000001_0_1_0;
        7'b00_11101: decode_ins = 9'b000001_0_1_0;
        7'b00_11110: decode_ins = 9'b000001_0_1_0;
        7'b00_11111: decode_ins = 9'b000001_0_1_0;

        default:     decode_ins = 9'b000000_0_0_0;
      endcase
    endfunction

  // **************** decode register *****************
  wire [3:0] rd_addr;
  wire [3:0] rs_addr;
  wire [31:0] rd_value;
  wire [31:0] rs_value;
  wire reserved_o_register;
  assign rd_addr = inst_i[23:20];
  assign rs_addr = inst_i[19:16];
  
  g_register register (
    .clk(clk),
    .rst(rst),
    .w_reserve_i(rsv_o),
    .r0_i(rd_addr),
    .r1_i(rs_addr),
    .r_opr0_o(rd_value),
    .r_opr1_o(rs_value),
    .reserved_o(reserved_o_register),
    .wb_i(wb_i),
    .wb_r_i(wb_r_i),
    .result_i(wb_data_i)
  );
  assign stall_o = reserved_o_register;

  // **************** decode immediate ****************
  `include "SignEx.v" 
  wire [31:0] dimm; // decoded immediate
  wire [31:0] opr0_value;
  wire [31:0] opr1_value;
  assign dimm = extend_sign(~imme16, inst_i[15:0]);

  assign opr0_value = rd_value;
  assign opr1_value = inst_i[24] ? dimm : rs_value;


  // *************** pipeline register ***************
  reg [31:0] opr0_value_r;
  reg [31:0] opr1_value_r;
  reg ctrl_inte_r;
  reg ctrl_logic_r;
  reg ctrl_shift_r;
  reg ctrl_ld_r;
  reg ctrl_st_r;
  reg ctrl_br_r;

  assign opr0_value_o = opr0_value_r;
  assign opr1_value_o = opr1_value_r;
  assign ctrl_inte_o  = ctrl_inte_r;
  assign ctrl_logic_o = ctrl_logic_r;
  assign ctrl_shift_o = ctrl_shift_r;
  assign ctrl_ld_o    = ctrl_ld_r;
  assign ctrl_st_o    = ctrl_st_r;
  assign ctrl_br_o    = ctrl_br_r;

  always @(posedge clk or negedge rst) begin
    if (~rst) begin
      opr0_value_r <= 32'b0;
      opr1_value_r <= 32'b0;
      ctrl_inte_r  <= 1'b0;
      ctrl_logic_r <= 1'b0;
      ctrl_shift_r <= 1'b0;
      ctrl_ld_r    <= 1'b0;
      ctrl_st_r    <= 1'b0;
      ctrl_br_r    <= 1'b0;
    end
    else if (stall_i) begin
      opr0_value_r <= opr0_value_r;
      opr1_value_r <= opr1_value_r;
      ctrl_inte_r  <= ctrl_inte_r;
      ctrl_logic_r <= ctrl_logic_r;
      ctrl_shift_r <= ctrl_shift_r;
      ctrl_ld_r    <= ctrl_ld_r;
      ctrl_st_r    <= ctrl_st_r;
      ctrl_br_r    <= ctrl_br_r;
    end
    else begin
      opr0_value_r <= opr0_value;
      opr1_value_r <= opr1_value;
      ctrl_inte_r  <= inte;
      ctrl_logic_r <= logic;
      ctrl_shift_r <= shift;
      ctrl_ld_r    <= ld;
      ctrl_st_r    <= st;
      ctrl_br_r    <= br;
    end
  end

endmodule
