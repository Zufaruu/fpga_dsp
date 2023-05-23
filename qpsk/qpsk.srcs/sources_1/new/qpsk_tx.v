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
    
    integer i;
    reg isStart;
    reg I, Q;
    
    initial begin
        i = 0;
        isStart = 1;
    end    

    always@(posedge clk || isStart)
    begin
        isStart = 0;
        
        if(i == 0)
            begin
            I = serial[0];
            Q = serial[1];
            
            if(I == 0) $readmemh("sine90.mem", rom_memory_I);
            else $readmemh("sine270.mem", rom_memory_I);
            
            if(Q == 0) $readmemh("sine.mem", rom_memory_Q);
            else $readmemh("sine180.mem", rom_memory_Q);
            
            end
            
        else if (i == SIZE)
            begin
            i = 0;
            end
        sine = rom_memory_I[i] + rom_memory_Q[i]; 
        i = i+ 1;
    end
    
    
endmodule
