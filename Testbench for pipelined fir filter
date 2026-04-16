`timescale 1ns/1ps

module tb_fir_pipelined;

    reg clk;
    reg rst;
    reg signed [15:0] x_in;
    wire signed [31:0] y_out;

    fir_pipelined uut (
        .clk(clk),
        .rst(rst),
        .x_in(x_in),
        .y_out(y_out)
    );

    always #5 clk = ~clk;

    integer i;

    initial begin
        clk = 0;
        rst = 1;
        x_in = 0;

        #10 rst = 0;

        for (i = 0; i < 20; i = i + 1) begin
            x_in = i * 10;   
            #10;
        end

        #100 $stop;
    end

endmodule
