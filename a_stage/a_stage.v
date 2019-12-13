module a_stage(clk, rst,
                v_i,
                v_o,
                data_i,
                data_o,
                stall_i,
                stall_o
                );

    input           clk, rst;   //clock, reset
    input           v_i;        // valid in, if (v_i == 1) valid
    output          v_o;        // valid out, if (v_o == 1) valid
    input [31:0]    data_i;     // data in
    output [31:0]   data_o;     // data out
    input           stall_i;    // stall in, if (stall_i == 1) stall
    output          stall_o;    // stall out, if (stall_o == 1) stall

    // pipeline registers
    reg         v_r;        // valid register for output
    reg [31:0]  data_r;     // data register for output

    // connecting registers to output
    assign v_o = v_r;
    assign data_o = data_r;

    // stall to previous stage
    assign stall_o = (v_r & stall_i);

    always @(posedge clk or negedge rst)
        begin
            if (~rst) // reset
                begin
                    v_r <= 0;       // reset valid reg
                    data_r <= 0;    // reset data reg
                end
            else
                begin
                    if (~stall_i) // valid and not stall
                    begin // transfer to next stage
                        v_r <= v_i;
                        data_r <= data_i;
                    end
                end // else !if(~rst)
        end // always @(posedge clk or negedge rst)
endmodule //a_stage
