`timescale 1ns/100ps
`include "../id/ID.v"

module test_ifetch();
  parameter STEP = 10;
  integer i, loop;

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
  reg [31:0] inst_r;
  reg [31:0] imm_r;

  wire [31:0] inst;
  assign inst = {opecode, immf, rd, rs, imm};

  wire [31:0] rd_value;
  wire [31:0] rs_value;
  wire [31:0] imm_value;
  wire immf_o_id;
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
    .rd_value_o(rd_value),
    .rs_value_o(rs_value),
    .imm_value_o(imm_value),
    .immf_o(immf_o_id),
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
    rd = 4'h0;
    rs = 4'h0;
    imm = 16'h0;
    stall = 1'b0;
    #(1.0);
    #(STEP * 2);
    rst = 1'b1;
    #(STEP * 3);
    for (loop = 0; loop <= 31; loop = loop + 1) begin
      opecode = opecode + 7'b1;
      immf = $random(clk);
      imm = $random(clk);
      rd = $random(clk);
      rs = $random(clk);
      #(STEP);
    end
    $finish;
  end

  always @(posedge clk) begin
    $display("############# cycle %h ################", i);
    $display("RST: %b", rst);
    $display("IN LO SH LD ST BR IM");
    $display("%b  %b  %b  %b  %b  %b  %b", inte, logic, shift, ld, st, br, immf_o_id);
    $display("ins: %b %b %h %h %h (No.%d)", inst_r[31:25], inst_r[24], inst_r[23:20], inst_r[19:16], inst_r[15:0], inst_r[31:25]);
    $display("src: %h", rs_value);
    $display("dst: %h", rd_value);
    $display("imm: %h", imm_value);
    $display("stl: %b", stall_o);
    inst_r <= inst;
    imm_r <= imm;
    i = i + 1;
  end
  
endmodule

