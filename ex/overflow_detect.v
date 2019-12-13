function overflow_detect;
  // oprA - oprB
  input [31:0] oprA, oprB, result;
  input minus;
  if (~minus) begin
    if (oprA[31] ~^ oprB[31]) begin
      overflow_detect = oprA[31] ^ result[31];
    end
  end
  else begin
    if (oprA[31] ^ oprB[31]) begin
      overflow_detect = oprA[31] ^ result[31];
    end
  end
endfunction
