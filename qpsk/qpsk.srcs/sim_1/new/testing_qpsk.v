`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2023 10:17:58
// Design Name: 
// Module Name: testing_qpsk
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


module testing_qpsk();
    reg clk;
    reg [1:0] serial;
    wire [31:0] sine;
    
    qpsk_tx uut(
        .clk(clk),
        .serial(serial),
        .sine(sine)
    );
    
    initial begin
      clk = 0;
      serial = 2'b11;
      forever #1 clk = ~clk;  
    end 
    
endmodule
