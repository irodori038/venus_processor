`include "../mem/DP_mem32x64k.v"

module load (
  input         clk,
  input [31:0]  base,     // base address
  input [31:0]  offset,   // offset address
  input [31:0]  data,     // data to write
  input         store,    // if L then load, H then store
  output [31:0] result    // result from memory
);

  wire [31:0] address;


  DP_mem32x64k data_mem (
    .clk(clk),
    .A(base + offset),
    .W(store),
    .D(data),
    .Q(result)
  );
