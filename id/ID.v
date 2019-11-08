module ID (
  clk,
  rst,
  inst_i,
  stall_o
);

  parameter W_DOPC  = 9;    // decoded opecode width
  parameter W_INST  = 32;   // instruction width
  parameter P_RD    = 20;   // position of register
  parameter W_OPC   = 7;    // opecode width

  wire [W_DOPC-1:0] dopc; // decoded opecode

  assign            dopc    = decode_ins(inst_i[W_INST-1:W_INST-W_OPC]);

  assign            inte    = dopc[W_DOPC-1]; // integer
  assign            logic   = dopc[W_DOPC-2]; // logic
  assign            shift   = dopc[W_DOPC-3]; // shift
  assign            ld      = dopc[W_DOPC-4]; // load
  assign            st      = dopc[W_DOPC-5]; // store
  assign            br      = dopc[W_DOPC-6]; // branch
  assign            imme16  = dopc[W_DOPC-7]; // immediate 16
  assign            rsv_o   = dopc[W_DOPC-8]; // reserve
  assign            und     = dopc[W_DOPC-9]; // undefined

  // **************** decode opecode *****************
    // dopc = {inte, logic, shift, ls, br, imm16, rsv, und}
    // integer, logic, shift, load, store, branch, immediate, reserved, undefined
    function [W_DOPC -1: 0] decode_ins;
      input [6: 0] opcode;
      case (opecode) // synopsys parallel_case
        // integer reg - reg
        7'b0000_000: decode_ins = 11'b100000_0_1_0;
        7'b0000_001: decode_ins = 11'b100000_0_1_0;
        7'b0000_010: decode_ins = 11'b100000_0_1_0;
        7'b0000_011: decode_ins = 11'b100000_0_1_0;
        7'b0000_100: decode_ins = 11'b100000_0_0_0;
        7'b0000_101: decode_ins = 11'b100000_0_1_0;
        7'b0000_110: decode_ins = 11'b100000_0_1_0;
        7'b0000_111: decode_ins = 11'b100000_0_1_0;

        // shift reg - reg
        7'b000_1000: decode_ins = 11'b001000_1_1_0;
        7'b000_1000: decode_ins = 11'b001000_1_1_0;
        7'b000_1000: decode_ins = 11'b001000_1_1_0;
        7'b000_1000: decode_ins = 11'b001000_1_1_0;
        7'b000_1000: decode_ins = 11'b001000_1_1_0;
        7'b000_1000: decode_ins = 11'b001000_1_1_0;
        
        // logic reg - reg
        7'b00_10000: decode_ins = 11'b010000_0_1_0;
        7'b00_10001: decode_ins = 11'b010000_0_1_0;
        7'b00_10010: decode_ins = 11'b010000_0_1_0;
        7'b00_10011: decode_ins = 11'b010000_0_1_0;

        // set reg - reg
        7'b00_10110: decode_ins = 11'b000000_0_1_0;
        7'b00_10111: decode_ins = 11'b000000_0_1_0;

        // load
        7'b00_11000: decode_ins = 11'b000100_0_1_0;

        // store
        7'b00_11001: decode_ins = 11'b000010_0_1_0;

        // branch
        7'b00_11100: decode_ins = 11'b000001_0_1_0;
        7'b00_11101: decode_ins = 11'b000001_0_1_0;
        7'b00_11110: decode_ins = 11'b000001_0_1_0;
        7'b00_11111: decode_ins = 11'b000001_0_1_0;

        default:     decode_ins = 11'b000000_0_0_0;
      endcase

  // **************** decode register *****************


  endmodule
