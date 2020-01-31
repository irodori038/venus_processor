module logic (
  input [31:0] src,
  input [31:0] dst,
  input [1:0] opcode,
  output [31:0] result
);

  /*
   * opcode = 00 -> AND
   * opcode = 01 -> OR
   * opcode = 10 -> NOT
   * opcode = 11 -> XOR
   */


  function [31:0] ex_logic;
    input [31:0] src;
    input [31:0] dst;
    input [1:0] opcode;

    case(opcode)
      2'b00: ex_logic = dst & src;
      2'b01: ex_logic = dst | src;
      2'b10: ex_logic = ~src;
      2'b11: ex_logic = dst ^ src;
      default: ex_logic = 32'h0;
    endcase
  endfunction

  assign result = ex_logic(src, dst, opcode);

endmodule

