module branch (
  input [31:0]  pc_i,       // value of program counter
  input [2:0]   cc_i,       // condition code
  input [5:0]   flags_i,    // value of flag register
  input [31:0]  src_i,      // value of rs
  input         abs_i,      // if L then relative, H then absolute
  output [31:0] dest_addr_o,  // destination address
  output        branch_en_o   // branch activate signal
);

  wire [31:0] pc_plus_src;
  assign pc_plus_src = pc_i + src_i;

  assign dest_addr_o = (abs_i) ? src_i : pc_plus_src;


  function check_branch;
    input [5:0] flags_i;
    input [3:0] cc_i;

    case (cc_i)
      3'b000: check_branch = 1'b1;
      3'b001: check_branch = flags_i[5];
      3'b010: check_branch = flags_i[4];
      3'b011: check_branch = flags_i[3];
      3'b100: check_branch = flags_i[2];
      3'b101: check_branch = flags_i[1];
      default: check_branch = 1'b0;
    endcase
  endfunction


  assign branch_en_o = check_branch(
    .flags_i(flags_i),
    .cc_i(cc_i)
  );

endmodule
