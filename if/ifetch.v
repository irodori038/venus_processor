module ifetch(clk,
              rst,
              inst_i,
              branch_i,
              branch_addr_i,
              stall_i,
              inst_o,
              inst_addr_o
              );

  parameter ADDR = 16;
  parameter WORD = 32;
  
  input           clk;            // clock
  input           rst;            // reset
  input [WORD-1:0]  inst_i;         // instruction data from memory
  input           branch_i;       // branch input (if H then branch)
  input [ADDR-1:0]  branch_addr_i;  // branch address
  input           stall_i;        // stall input (if H then stall)
  output [WORD-1:0] inst_o;         // instruction to the next stage
  output [ADDR-1:0] inst_addr_o;    // instruction addr to memory


  // pipeline registers
  reg [ADDR-1:0] addr_r;            // to the next stage

  // connect pipeline registers to output
  assign inst_o = inst_i;

  // program counter
  reg [ADDR-1:0] pc;
  wire [ADDR-1:0] pc_plus1;
  wire [ADDR-1:0] next_pc;
  assign pc_plus1 = addr_r + 16'h0001;
  assign next_pc = branch_i ? branch_addr_i : pc_plus1;
  assign inst_addr_o = addr_r;

  always @(posedge clk or negedge rst) begin
    if (~rst) begin
      pc <= 16'h0000;
      addr_r <= 16'h0000;
    end // if (~rst)
    else
      if (stall_i) begin
        addr_r <= addr_r;
        pc <= pc;
      end // if (stall_i)
      else begin
        pc = next_pc;
        addr_r = pc;
      end
  end // always @(posedge clk or negedge rst)


endmodule // if
