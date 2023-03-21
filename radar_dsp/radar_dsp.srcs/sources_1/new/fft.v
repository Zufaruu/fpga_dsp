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
`define PI 3.14159265359
parameter N = 8;

module fft(
    input clk,
    input real in_re [0:N-1],
    input real in_im [0:N-1],
    output real out_re [0:N-1],
    output real out_im [0:N-1]
    );
    
    function automatic real[0:N-1][0:1] cooleytukey(real[0:N-1] in_re, real[0:N-1] in_im);
        real out[0:N-1][0:1],
        out_odd[0:(N/2)-1][0:1], out_even[0:(N/2)-1][0:1],
        re_odd[0:(N/2)-1], im_odd[0:(N/2)-1],
        re_even[0:(N/2)-1], im_even[0:(N/2)-1],
        t_re, t_im,
        temp_re, temp_im;
        integer i;
    
        
        // real out_im_odd[0:(N/2)-1];
        // real out_im_even[0:(N/2)-1];
        // real out_re_odd[0:(N/2)-1];
        // real out_re_even[0:(N/2)-1];
        
        if (N == 1) 
            begin
            cooleytukey [0:N-1][0] = in_re;
            cooleytukey [0:N-1][1] = in_im;
            end
        else
            begin
            for(i = 0; i < (N/2)-1; i = i + 1)
                begin
                re_odd[i] = in_re[2*i];
                im_odd[i] = in_im[2*i];
                re_even[i] = in_re[2*i];
                im_even[i] = in_im[2*i];
                end   
    
            out_odd = cooleytukey(re_odd, im_odd);
            out_even = cooleytukey(re_even, im_even);
    
            for(i = 0; i < (N/2)-1; i = i + 1) 
                begin
                t_re = $cos(2.0*PI*i/N);
                t_im = -$sin(2.0*PI*i/N); 
                temp_re = ((t_re * out_odd[i][0]) - (t_im * out_odd[i][1]));
                temp_im = ((t_re * out_odd[i][1]) + (t_im * out_odd[i][0]));
                cooleytukey[i][0] = out_even[i][0] + temp_re;
                cooleytukey[i][1] = out_even[i][1] + temp_im;
                cooleytukey[i + N/2][0] = out_even[i][0] - temp_re;
                cooleytukey[i + N/2][1] = out_even[i][1] - temp_im;
                end
            end
    endfunction
    
    real X[0:N-1][0:1] = cooleytukey(in_re, in_im);
    assign out_re = X[0:N-1][0];
    assign out_im = X[0:N-1][1];
    
endmodule
