`include "../reg/register_cell.v"

module g_register (
  clk,
  rst,
  w_reserve_i,
  r0_i,
  r1_i,
  r_opr0_o,
  r_opr1_o,
  reserved_o,
  wb_i,
  wb_r_i,
  result_i
);


  `include "../include/params.v"

  input               clk, rst;
  input               w_reserve_i;  
  input [W_RD-1:0]    r0_i;         // register No. as opr0 & write_reservation
  input [W_RD-1:0]    r1_i;         // register No. as opr1
  output [W_OPR-1:0]  r_opr0_o;     // operand 0
  output [W_OPR-1:0]  r_opr1_o;     // operand 1
  output              reserved_o;   // destination is reserved
  
  input               wb_i;         // write back
  input [W_RD-1:0]    wb_r_i;       // write back register
  input [W_OPR-1:0]   result_i;     // write back data

  wire [REG_S-1:0]    w_reserve;
  wire [REG_S-1:0]    w_reserved;
  wire [REG_S-1:0]    wb_r;

  wire [W_OPR-1:0]    data0;
  wire [W_OPR-1:0]    data1;
  wire [W_OPR-1:0]    data2;
  wire [W_OPR-1:0]    data3;
  wire [W_OPR-1:0]    data4;
  wire [W_OPR-1:0]    data5;
  wire [W_OPR-1:0]    data6;
  wire [W_OPR-1:0]    data7;
  wire [W_OPR-1:0]    data8;
  wire [W_OPR-1:0]    data9;
  wire [W_OPR-1:0]    dataa;
  wire [W_OPR-1:0]    datab;
  wire [W_OPR-1:0]    datac;
  wire [W_OPR-1:0]    datad;
  wire [W_OPR-1:0]    datae;
  wire [W_OPR-1:0]    dataf;


  `include "../reg/select16.v"

  assign r_opr0_o = select16 (
    r0_i, // register descriptor
    data0, data1, data2, data3,
    data4, data5, data6, data7,
    data8, data9, dataa, datab,
    datac, datad, datae, dataf
  );

  assign r_opr1_o = select16 (
    r1_i, // register descriptor
    data0, data1, data2, data3,
    data4, data5, data6, data7,
    data8, data9, dataa, datab,
    datac, datad, datae, dataf
  );

  wire [REG_S-1:0]  opr_req0; // operand request vector0
  wire [REG_S-1:0]  opr_req1; // operand request vector1


  `include "../reg/decode16.v"

  assign            opr_req0 = decode16(r0_i);
  assign            opr_req1 = decode16(r1_i);

  assign            w_reserve = opr_req0 & {16{w_reserve_i}};
  
  // if requested register is reserved
  assign            reserved_o = ((opr_req0 | opr_req1) & w_reserved);

  assign            wb_r = decode16(wb_r_i) & {16{wb_i}};
  
  // perl register_cellbuild.pl
  register_cell r0 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data0),
    .w_reserve_i(w_reserve[0]),
    .w_reserve_o(w_reserved[0]),
    .wb_i(wb_r[0])
  );

  register_cell r1 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data1),
    .w_reserve_i(w_reserve[1]),
    .w_reserve_o(w_reserved[1]),
    .wb_i(wb_r[1])
  );

  register_cell r2 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data2),
    .w_reserve_i(w_reserve[2]),
    .w_reserve_o(w_reserved[2]),
    .wb_i(wb_r[2])
  );

  register_cell r3 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data3),
    .w_reserve_i(w_reserve[3]),
    .w_reserve_o(w_reserved[3]),
    .wb_i(wb_r[3])
  );

  register_cell r4 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data4),
    .w_reserve_i(w_reserve[4]),
    .w_reserve_o(w_reserved[4]),
    .wb_i(wb_r[4])
  );

  register_cell r5 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data5),
    .w_reserve_i(w_reserve[5]),
    .w_reserve_o(w_reserved[5]),
    .wb_i(wb_r[5])
  );

  register_cell r6 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data6),
    .w_reserve_i(w_reserve[6]),
    .w_reserve_o(w_reserved[6]),
    .wb_i(wb_r[6])
  );

  register_cell r7 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data7),
    .w_reserve_i(w_reserve[7]),
    .w_reserve_o(w_reserved[7]),
    .wb_i(wb_r[7])
  );

  register_cell r8 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data8),
    .w_reserve_i(w_reserve[8]),
    .w_reserve_o(w_reserved[8]),
    .wb_i(wb_r[8])
  );

  register_cell r9 (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(data9),
    .w_reserve_i(w_reserve[9]),
    .w_reserve_o(w_reserved[9]),
    .wb_i(wb_r[9])
  );

  register_cell ra (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(dataa),
    .w_reserve_i(w_reserve[10]),
    .w_reserve_o(w_reserved[10]),
    .wb_i(wb_r[10])
  );

  register_cell rb (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(datab),
    .w_reserve_i(w_reserve[11]),
    .w_reserve_o(w_reserved[11]),
    .wb_i(wb_r[11])
  );

  register_cell rc (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(datac),
    .w_reserve_i(w_reserve[12]),
    .w_reserve_o(w_reserved[12]),
    .wb_i(wb_r[12])
  );

  register_cell rd (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(datad),
    .w_reserve_i(w_reserve[13]),
    .w_reserve_o(w_reserved[13]),
    .wb_i(wb_r[13])
  );

  register_cell re (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(datae),
    .w_reserve_i(w_reserve[14]),
    .w_reserve_o(w_reserved[14]),
    .wb_i(wb_r[14])
  );

  register_cell rf (
    .clk(clk),
    .rst(rst),
    .data_i(result_i),
    .data_o(dataf),
    .w_reserve_i(w_reserve[15]),
    .w_reserve_o(w_reserved[15]),
    .wb_i(wb_r[15])
  );

endmodule
