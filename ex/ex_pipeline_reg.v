module ex_pipeline_reg (
  input clk,
  input rst,
  input ctrl_addsub_i,
  input ctrl_mul_i,
  input ctrl_shift_i,
  input ctrl_logic_i,
  input ctrl_ld_i,
  input ctrl_br_i,
  input [31:0] result_addsub_i,
  input [31:0] result_mul_i,
  input [31:0] result_shift_i,
  input [31:0] result_logic_i,
  input [31:0] result_ld_i,
  input [31:0] result_br_i,
  output result_o
);

  reg [31:0] result_r;
  assign result_o = (ctrl_ld_i) ? result_ld_i : result_r;

  always @(posedge clk) begin
    if (~rst) result_r <= 32'h0;
    else if (ctrl_addsub_i) result_r <= result_addsub_i;
    else if (ctrl_mul_i) result_r <= result_mul_i;
    else if (ctrl_shift_i) result_r <= result_shift_i;
    else if (ctrl_logic_i) result_r <= result_logic_i;
    else if (ctrl_br_i) result_r <= result_br_i;
  end
endmodule
