`timescale 1ns / 1ps
module fir_pipelined (
    input clk,
    input rst,
    input signed [15:0] x_in,
    output reg signed [31:0] y_out
);

    parameter signed [15:0] h0 = 16'd1;
    parameter signed [15:0] h1 = -16'd2;
    parameter signed [15:0] h2 = 16'd3;
    parameter signed [15:0] h3 = -16'd2;
    parameter signed [15:0] h4 = 16'd1;

    reg signed [15:0] x1, x2, x3, x4;

    reg signed [31:0] m0, m1, m2, m3, m4;

    reg signed [31:0] s1, s2, s3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x1 <= 0; x2 <= 0; x3 <= 0; x4 <= 0;
            m0 <= 0; m1 <= 0; m2 <= 0; m3 <= 0; m4 <= 0;
            s1 <= 0; s2 <= 0; s3 <= 0;
            y_out <= 0;
        end else begin
            x4 <= x3;
            x3 <= x2;
            x2 <= x1;
            x1 <= x_in;

            m0 <= x_in * h0;
            m1 <= x1   * h1;
            m2 <= x2   * h2;
            m3 <= x3   * h3;
            m4 <= x4   * h4;

            s1 <= m0 + m1;
            s2 <= m2 + m3;

            s3 <= s1 + s2;

            y_out <= s3 + m4;
        end
    end

endmodule
