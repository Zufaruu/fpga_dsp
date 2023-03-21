`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2023 17:36:19
// Design Name: 
// Module Name: fft
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
parameter N = 8;

function automatic float[0:N-1][0:1] cooleytukey(float[N-1:0] in_re, float[N-1:0] in_im);
    float reim[0:N-1][0:1];
    float re[0:(N/2)-1];
    float im[0:(N/2)-1];
    
    assign reim [0:N-1][0] = in_re;
    assign reim [0:N-1][1] = in_im;
    
    if (N == 1) 
        begin
        return reim;
        end
    else
        begin
        
        end
    
endfunction
    
module fft(
    input clk,
    input float in_re [N-1:0],
    input float in_im [N-1:0],
    output float out_re [N-1:0],
    output float out_im [N-1:0]
    );
    
    
endmodule
