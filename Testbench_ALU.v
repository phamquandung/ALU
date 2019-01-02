`timescale 100ns / 10ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2018 10:29:39 AM
// Design Name: 
// Module Name: Testbench_ALU
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


module Testbench_ALU();
reg clk;
reg [2:0] operation;
reg [31:0] A, B;
wire [31:0] C;
wire  B_invert;
wire zero;
wire overflow;
wire carry_out;
wire carry_in;
//integer i;
always #0.5 clk = ~clk;
always #1 operation = operation + 3'b001;
ALU alu(.clk(clk), .operation(operation), .carry_in(carry_in), .A(A), .B(B), .B_invert(B_invert), .C(C), .zero(zero), .overflow(overflow), .carry_out(carry_out));

initial 
    begin
        clk = 1;
        A = 32'b00000000000000000000000000000000;
        B = 32'b00000000000000000000000000000001;
        operation = 3'b001;
//        for (i = 0; i <= 8; i= i+1)
//            begin
//                operation = operation + 3'b001;
//                #1;
//            end
         #8
         A = 32'b11111111111111111111111111111111;
         B = 32'b11111111111111111111111111111111;
         
         //#20 $finish; 
    end
endmodule
