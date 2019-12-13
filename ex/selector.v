function [31:0] selector;
  input ctrl_inte;
  /*
  input ctrl_logic;
  input ctrl_shift;
  input ctrl_ld;
  input ctrl_st;
  input ctrl_br;
  */

  input [31:0] result_from_adder;
  if (ctrl_inte) begin
    selector = result_from_adder;
  end
  else begin
    selector = 32'h0;
  end
endfunction
