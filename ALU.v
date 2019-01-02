`timescale 100ns / 10ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2018 10:28:39 AM
// Design Name: 
// Module Name: ALU
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


module ALU(clk, operation, carry_in, A, B, B_invert, C, zero, overflow, carry_out);
//input and output
input clk;
input [2:0] operation;
input [31:0] A, B;
output reg [31:0] C;
output reg zero,  B_invert;
output reg overflow;
output reg carry_out;
output reg carry_in;
reg [32:0] tmp;
reg [30:0] tmp_1, tmp_2;
always@(*)
begin
    //tmp = {1'b0, A} + {1'b0,B};
    //carry_out = tmp[8];
    if (B[7] ==1) B_invert = 1'b1;
    else B_invert = 1'b0;
    tmp_1 = A[30:0];
    tmp_2 = B[30:0];  
end
always@(*)
begin
    case(operation)
    //ADD
    3'b001: begin C = A + B;
                carry_in = 0;
                carry_out = 0;
                tmp = {1'b0, A} + {1'b0,B};
                if (tmp[32]) carry_out = 1;
                if ((A[31]== 0)&&(B[31]==0)&&(C[31]==0)) overflow = 0;
                if ((A[31]== 1)&&(B[31]==1)&&(C[31]==1)) overflow = 0;
                if (A[31] != B[31]) begin
                    if((A[31] == 1)&&(B[31] == 0)) 
                        if (tmp_1 > tmp_2) 
                            begin 
                                overflow = 1;
                                carry_in = 1;
                            end
                        else overflow = 0;
                    if((A[31] == 0)&&(B[31] == 1))
                        if (tmp_1 < tmp_2) 
                            begin
                                overflow = 1;
                                carry_in = 1;
                            end
                        else overflow = 0; 
                end
            end
    //SUB
    3'b010: begin C = A - B;
                carry_out = 0;
                if ((A[31]== 0)&&(B[31]==1)&&(C[31]==0)) overflow = 0;
                if ((A[31]== 1)&&(B[31]==0)&&(C[31]==1)) overflow = 0;
                if (A[31] == B[31]) begin
                    if((A[31] == 1)&&(B[31] == 1)) 
                        if (tmp_1 >= tmp_2) overflow = 1;
                        else
                            begin 
                                overflow = 0;
                                carry_in = 1;
                            end
                    if((A[31] == 0)&&(B[31] == 0))
                        if (tmp_1 < tmp_2)
                            begin 
                                overflow = 1;
                                carry_in = 1;
                            end
                        else 
                            begin
                                overflow = 0;
                                carry_in = 0;
                        end 
                end
            end
    //AND
    3'b011: begin 
                C = A & B;
                overflow = 0;
                carry_out = 0;
                carry_in = 0;
            end
    //OR
    3'b100: begin
                C = A | B;
                overflow = 0;
                carry_out = 0;
                carry_in = 0;
            end 
    //NOR
    3'b101: begin
                C = ~(A | B);
                overflow = 0;
                carry_out = 0;
                carry_in = 0;
            end
    //SLT
    3'b110: begin
                overflow = 0;
                carry_out = 0;
                carry_in = 0;
                if (A < B) C = 1;
                else C = 0;
            end
    //BEQ
    3'b111: begin
                C = A~^B;
                overflow = 0;
                carry_out = 0;
                carry_in = 0;
            end
    default: begin
                overflow = 0;
                carry_out = 0;
                carry_in = 0;
             end
    endcase
end
always@(*)
    begin
        if (C == 0) zero = 1;
        else zero = 0;
    end
endmodule
