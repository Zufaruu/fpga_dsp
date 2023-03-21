`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2023 15:33:14
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


module top(
    input [3:0] switch,
    output red,
    output green,
    output blue
    );
    
    assign red = ~switch[3] & ~switch[2];
    assign blue = (~switch[3] & switch[2]) | (switch[3] & ~switch[2] & ~switch[1]);
    assign green = (switch[3] & switch[2]) + (switch[3] & ~switch[2] & switch[1]);

endmodule
