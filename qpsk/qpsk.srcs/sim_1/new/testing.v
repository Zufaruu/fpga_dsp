`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.02.2023 09:32:28
// Design Name: 
// Module Name: testing
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


module testing();
    reg clk;
    wire [15:0] sine;
    
    sine_gen uut(
        .clk(clk),
        .sine(sine)
    );
    
    initial begin
      clk=0;
      forever #1 clk = ~clk;  
    end 
endmodule
