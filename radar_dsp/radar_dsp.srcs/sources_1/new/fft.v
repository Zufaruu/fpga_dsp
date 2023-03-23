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

module fft #(
    parameter N = 8,
    parameter bit = 32,
    parameter total_serial = bit*N //512
    )(
    input clk,
    input [bit*N-1:0] in_re,
    input [bit*N-1:0] in_im,
    output reg[bit*N-1:0] out_re,
    output reg[bit*N-1:0] out_im
    );
    reg[31:0] in_re_arr[N-1:0], in_im_arr[N-1:0], out_re_arr[N-1:0], out_im_arr[N-1:0];
    integer i, j;
    
    always@(posedge clk)
        begin
        
        end
      
    function automatic [total_serial*2-1:0] cooleytukey;
        input [bit*N-1:0] in_re;
        input [bit*N-1:0] in_im;
                
        begin
        
        // serial to N channel I-Q
        for(i = 0;i < N;i = i+1) // i+1 = 8
            begin
            for(j = 0;j < bit; j = j+1) // j+1 = 32
                begin
                 in_re_arr[j][i] = in_re[total_serial*2 - (bit*i+j+1)]; //511-480 
                 in_im_arr[j][i] = in_im[total_serial - (bit*i+j+1)];
                end
            end 
            
        // cooley-tukey stato
        if (N == 1) 
            begin
            cooleytukey[total_serial*2-1:0] = {in_re, in_im};
            end
//        else
//            begin
//            for(i = 0; i < (N/2)-1; i = i + 1)
//                begin
//                for(j = bit-1; j > 0; j = j - 1)
//                    begin
//                    re_odd[i] = in_re[2*i];
//                    im_odd[i] = in_im[2*i];
//                    re_even[i] = in_re[2*i];
//                    im_even[i] = in_im[2*i];
//                    end
//                end   
    
////            out_odd = cooleytukey(re_odd, im_odd);
////            out_even = cooleytukey(re_even, im_even);
    
////            for(i = 0; i < (N/2)-1; i = i + 1) 
////                begin
////                t_re = $cos(2.0*PI*i/N);
////                t_im = -$sin(2.0*PI*i/N); 
////                temp_re = ((t_re * out_odd[i][0]) - (t_im * out_odd[i][1]));
////                temp_im = ((t_re * out_odd[i][1]) + (t_im * out_odd[i][0]));
////                cooleytukey[31:0][i][0] = out_even[i][0] + temp_re;
////                cooleytukey[31:0][i][1] = out_even[i][1] + temp_im;
////                cooleytukey[31:0][i + N/2][0] = out_even[i][0] - temp_re;
////                cooleytukey[31:0][i + N/2][1] = out_even[i][1] - temp_im;
////                end
//            end 
        end
    endfunction
    
endmodule
