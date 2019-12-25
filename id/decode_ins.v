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
    7'b000_1001: decode_ins = 9'b001000_1_1_0;
    7'b000_1010: decode_ins = 9'b001000_1_1_0;
    7'b000_1100: decode_ins = 9'b001000_1_1_0;
    7'b000_1101: decode_ins = 9'b001000_1_1_0;
    
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

    default:     decode_ins = 9'b000000_0_0_1;
  endcase
endfunction
