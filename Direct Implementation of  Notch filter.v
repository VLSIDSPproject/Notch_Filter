`timescale 1ns / 1ps

    module fir_direct (
    input wire clk,
    input wire rst,
    input wire signed [15:0] x_in,
    output reg signed [31:0] y_out
);

    // Filter coefficients (Notch at fs/6)
    localparam signed [15:0] H0 = 16'sd1;
    localparam signed [15:0] H1 = -16'sd2;
    localparam signed [15:0] H2 = 16'sd3;
    localparam signed [15:0] H3 = -16'sd2;
    localparam signed [15:0] H4 = 16'sd1;

    // Shift register (delay line)
    reg signed [15:0] x1, x2, x3, x4;

    // Combinational signals for products and sum
    wire signed [31:0] m0, m1, m2, m3, m4;
    wire signed [31:0] sum;

    // ---------------------------------------------------------
    // Combinational Logic: Pure Math (No clock delays here)
    // ---------------------------------------------------------
    
    // 5 parallel multipliers
    assign m0 = x_in * H0;
    assign m1 = x1   * H1;
    assign m2 = x2   * H2;
    assign m3 = x3   * H3;
    assign m4 = x4   * H4;

    // Direct addition tree
    assign sum = m0 + m1 + m2 + m3 + m4;

    // ---------------------------------------------------------
    // Sequential Logic: Data Shifting and Output
    // ---------------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            x1 <= 16'd0;
            x2 <= 16'd0;
            x3 <= 16'd0;
            x4 <= 16'd0;
            y_out <= 32'd0;
        end else begin
            // Shift the delay line
            x1 <= x_in;
            x2 <= x1;
            x3 <= x2;
            x4 <= x3;

            // Register the final calculated sum to the output
            y_out <= sum;
        end
    end

endmodule
