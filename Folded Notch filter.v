`timescale 1ns / 1ps

module fir_folded (
    input clk,
    input rst,
    input start,
    input signed [15:0] x_in,
    output reg signed [31:0] y_out,
    output reg done
);

    reg signed [15:0] h[0:4];
    initial begin
        h[0] = 16'd1;
        h[1] = -16'd2;
        h[2] = 16'd3;
        h[3] = -16'd2;
        h[4] = 16'd1;
    end

    reg signed [15:0] x[0:4];

    reg [2:0] count;
    reg signed [31:0] acc;

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            count <= 0;
            acc <= 0;
            y_out <= 0;
            done <= 0;

            for (i = 0; i < 5; i = i + 1)
                x[i] <= 0;

        end else begin

            if (start) begin
                x[4] <= x[3];
                x[3] <= x[2];
                x[2] <= x[1];
                x[1] <= x[0];
                x[0] <= x_in;

                acc <= 0;
                count <= 0;
                done <= 0;
            end else begin
                if (count < 5) begin
                    acc <= acc + x[count] * h[count];
                    count <= count + 1;
                end else begin
                    y_out <= acc;
                    done <= 1;
                end
            end

        end
    end

endmodule
