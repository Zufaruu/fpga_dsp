`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2023 14:52:28
// Design Name: 
// Module Name: qpsk_tx
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


module qpsk_tx(
    input clk,
    input [1:0] serial,
    output reg [31:0] sine
    );
    
    parameter SIZE = 1000;    
    reg [15:0] rom_memory_I [SIZE-1:0];
    reg [15:0] rom_memory_Q [SIZE-1:0];
    reg [15:0] rom_memory_carrier_I [SIZE-1:0];
    reg [15:0] rom_memory_carrier_Q [SIZE-1:0];
    
    integer i;
    reg isStart, isCorring;
    reg I, Q;
    reg[127:0] corr_result_I, corr_result_Q;
    
    initial begin
        i = 0;
        isStart = 1;
        isCorring = 0;
        corr_result_I = 0;
        corr_result_Q = 0;
    end    

    always@(posedge clk or isStart)
    begin
        isStart = 0;
        if(i == 0 && !isCorring)
            begin
            I = serial[0];
            Q = serial[1];
            $readmemh("sine.mem", rom_memory_carrier_I);
            $readmemh("sine90.mem", rom_memory_carrier_Q);
            
            if(I == 0) $readmemh("sine.mem", rom_memory_I);
            else $readmemh("sine180.mem", rom_memory_I);
            
            if(Q == 0) $readmemh("sine90.mem", rom_memory_Q);
            else $readmemh("sine270.mem", rom_memory_Q);
            end
        else if (i != SIZE && !isCorring)
            begin
            sine = rom_memory_I[i] + rom_memory_Q[i];    
            i = i+ 1;
            
            isCorring = i == SIZE;
            if(i == SIZE)
                begin
                
                corr_result_I = corr_result_I + rom_memory_I ;
                
                i = 0;
                end
            end  
    end
    
    
endmodule
