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
    integer counter;
    reg [1:0] serial;
    wire [31:0] sine;
    
    qpsk_tx uut(
        .clk(clk),
        .serial(serial),
        .sine(sine)
    );
    
    initial begin
      clk = 0;
      counter = 0;
      serial = 2'b10;
      
      forever #1 begin 
          if(counter > 0 && counter % 2000 == 0) begin
            serial = (serial == 4) ? 0 : serial + 1;
          end
          clk = ~clk;
          counter = counter + 1; 
      end
    end 
    
endmodule
