`timescale 10ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.02.2023 15:43:33
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg [3:0] switch = 0;
    wire red;
    wire green;
    wire blue;
    
    top uut(
    .switch(switch),
    .red(red),
    .green(green),
    .blue(blue)
    );
    
    integer k = 0;
    initial
    begin
        switch = 0;
        
        for(k=0; k<16; k = k+1)
            #10 assign switch = k; //delay 10*10ns
            #5 $finish;
        
    end
endmodule
