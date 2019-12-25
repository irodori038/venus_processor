function [31:0] selector;
  input ctrl_inte;
  input ctrl_br;
  /*
  input ctrl_logic;
  input ctrl_shift;
  input ctrl_ld;
  input ctrl_st;
  */

  input [31:0] result_from_adder;
  input [31:0] result_from_branch;
  if (ctrl_inte) begin
    selector = result_from_adder;
  end
  else if (ctrl_br) begin
    selector = result_from_branch;
  end
  else begin
    selector = 32'h0;
  end
endfunction
