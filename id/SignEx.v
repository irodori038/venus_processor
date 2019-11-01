function [31:0] extend_sign;
  input en_extend;
  input [15:0] value;

  if (en_extend)
    extend_sign = {16{value[15]}, value};
  else
    extend_sign = {16'b0, value};

endfunction
