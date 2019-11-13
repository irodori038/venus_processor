`timescale 1ns/100ps
`include "../id/ID.v"

module test_ifetch();
  parameter STEP = 10;
  integer i;

  reg clk;
  always begin
    #(STEP / 2) clk = ~clk;
  end

  reg rst;
  reg stall;
  reg [3:0] wb_r;
  reg wb;
  reg [31:0] wb_data;
  reg [6:0] opecode;
  reg immf;
  reg [3:0] rd;
  reg [3:0] rs;
  reg [15:0] imm;

  wire [31:0] inst;
  assign inst = {opecode, immf, rd, rs, imm};

  wire [31:0] opr0_value;
  wire [31:0] opr1_value;
  wire stall_o;
  wire inte;
  wire logic;
  wire shift;
  wire ld;
  wire st;
  wire br;

  ID idecode (
    .clk(clk),
    .rst(rst),
    .inst_i(inst),
    .opr0_value_o(opr0_value),
    .opr1_value_o(opr1_value),
    .stall_i(stall),
    .stall_o(stall_o),
    .ctrl_inte_o(inte),
    .ctrl_logic_o(logic),
    .ctrl_shift_o(shift),
    .ctrl_ld_o(ld),
    .ctrl_st_o(st),
    .ctrl_br_o(br),
    .wb_r_i(wb_r),
    .wb_i(wb),
    .wb_data_i(wb_data)
  );

  initial begin
    clk = 1'b0;
    rst = 1'b0;
    i = 0;
    opecode = 7'b000_0000;
    immf = 1'b0;
    rd = 4'h1;
    rs = 4'h0;
    imm = 16'h0;
    #(STEP * 3)
    $finish;
  end

  always @(posedge clk) begin
    $display("############# cycle %h ################", i);
    $display("ctrl line");
  end
  
endmodule

