`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2023 20:01:05
// Design Name: 
// Module Name: fft_r2
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fft_r2
#(
    parameter N = 8 // FFT size
)
(
    input clk,
    input rst,
    input [15:0] in_r[N], in_i[N], // Real and imaginary inputs
    output [15:0] out_r[N], out_i[N] // Real and imaginary outputs
    );

parameter logN = $clog2(N);

reg [15:0] X_r[N], X_i[N];
reg [15:0] W_r[N/2], W_i[N/2];

initial begin
    W_r[0] = 1; W_i[0] = 0;
    for (int i = 1; i < N/2; i+=1) begin
        W_r[i] = cos((2 * $pi * i) / N);
        W_i[i] = -sin((2 * $pi * i) / N);
    end
end

// FFT butterfly operation
// r1, i1: real and imaginary parts of first input
// r2, i2: real and imaginary parts of second input
// w_r, w_i: real and imaginary parts of twiddle factor
// r_out, i_out: real and imaginary parts of output
function [15:0] butterfly;
    input [15:0] r1, i1, r2, i2, w_r, w_i;
    output [15:0] r_out, i_out;
    
    begin
        r_out = r1 + (w_r * r2) - (w_i * i2);
        i_out = i1 + (w_r * i2) + (w_i * r2);
    end
endfunction

// Radix-2 FFT algorithm
always @(posedge clk) begin
    if (rst) begin
        // Reset registers
        for (int i = 0; i < N; i+=1) begin
            X_r[i] <= 0;
            X_i[i] <= 0;
        end
    end 
    else begin
        // Input stage
        for (int i = 0; i < N; i+=1) begin
            X_r[i] <= in_r[i];
            X_i[i] <= in_i[i];
        end
        
        // FFT stages
        for (int stage = 1; stage <= logN; stage+=1) begin
            int butterfly_span = 1 << stage;
            int num_butterflies = N / butterfly_span;
            
            for (int b = 0; b < num_butterflies; b+=1) begin
                // Calculate twiddle factor index
                int tw_index = b * (1 << (logN - stage));
                
                for (int i = 0; i < butterfly_span/2; i+=1) begin
                    // Calculate butterfly inputs
                    int index1 = b * butterfly_span + i;
                    int index2 = index1 + butterfly_span/2;
                    
                    // Perform butterfly operation
                    {X_r[index1], X_i[index1]} <= butterfly(X_r[index1], X_i[index1],
                                                            X_r[index2], X_i[index2],
                                                            W_r[tw_index], W_i[tw_index]);
                    {X_r[index2], X_i[index2]} <= butterfly(X_r[index1], X_i[index1],
                                                            X_r[index2], X_i[index2],
                                                            W_r[tw_index], -W_i[tw_index]);
                    end
            end
        end    
    end 
end
endmodule
