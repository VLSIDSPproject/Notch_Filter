`timescale 1ns/1ps

module tb_fir_folded;

    reg clk, rst, start;
    reg signed [15:0] x_in;
    wire signed [31:0] y_out;
    wire done;

    fir_folded uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .x_in(x_in),
        .y_out(y_out),
        .done(done)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        start = 0;
        x_in = 0;

        #20 rst = 0;

        @(posedge clk);
        x_in = 10;
        start = 1;

        @(posedge clk);
        start = 0;

        repeat (10) @(posedge clk);

        @(posedge clk);
        x_in = 20;
        start = 1;

        @(posedge clk);
        start = 0;

        repeat (10) @(posedge clk);

        @(posedge clk);
        x_in = 30;
        start = 1;

        @(posedge clk);
        start = 0;

        repeat (10) @(posedge clk);

        $stop;
    end

endmodule
