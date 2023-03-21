`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2023 09:20:08
// Design Name: 
// Module Name: top
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


module sine_gen(
    input clk,
    output reg [15:0] sine
    );

    parameter SIZE = 1000;    
    reg [15:0] rom_memory [SIZE-1:0];
    
    integer i;
    initial begin
        $readmemh("sine270.mem", rom_memory); //File with the signal
        i = 0;
    end    

    always@(posedge clk)
    begin
        sine = rom_memory[i];
        i = i+ 1;
        if(i == SIZE)
            i = 0;
    end
endmodule
