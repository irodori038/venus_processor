module a_stage #(
  parameter WORD = 32
) (
  input clk,
  input rst,
  input v_i,                    // valid in, if (v_i == 1) valid
  output reg v_o,               // valid out, if (v_o == 1) valid 
  input [WORD-1:0] data_i,      // data in
  output reg [WORD-1:0] data_o, // data out
  input stall_i,                // stall in, if (stall_i == 1) stall
  output stall_o                // stall out, if (stall_o == 1) stall
);

  // stall to previous stage
  assign stall_o = (v_o & stall_i);

  always @(posedge clk or negedge rst) begin
    if (~rst) begin // reset
      v_o <= 0;       // reset valid reg
      data_o <= 0;    // reset data reg
    end
    else begin
      if (~stall_i) begin // valid and not stall
        v_o <= v_i;
        data_o <= data_i;
      end // if (~stall_i)
    end // else !if(~rst)
  end // always @(posedge clk or negedge rst)
endmodule //a_stage
