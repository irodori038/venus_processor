module load_store (
  input         clk,
  input [31:0]  rd,     // rd value
  input [31:0]  rs,     // rs value
  input [31:0]  offset, // offset value
  input         load,   // H then load
  input         store,  // H then store
  output [31:0] result  // result from memory
);

  wire [31:0] address;
  wire [31:0] base;
  assign base = load ? rs : rd;
  assign address = base + offset;


  DP_mem32x64k data_mem (
    .clk(clk),
    .A(address[15:0]),
    .W(store),
    .D(rs),
    .Q(result)
  );

endmodule
