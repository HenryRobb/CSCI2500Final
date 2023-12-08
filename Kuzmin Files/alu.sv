// Adopted from https://www.fpga4student.com/2017/06/Verilog-code-for-ALU.html
`timescale 1ns / 1ps

module alu(
           input [7:0] A,B,  // ALU 8-bit Inputs
           input [3:0] ALU_Sel,// ALU Selection
           output [7:0] ALU_Out // ALU 8-bit Output
    );
    reg [7:0] ALU_Result;
    wire [7:0] tmp;
    assign ALU_Out = ALU_Result; // ALU out
    always @(*)
    begin
        case(ALU_Sel)
        4'b0011: // Addition
           ALU_Result = A + B ;
        4'b0100: // Subtraction
           ALU_Result = A - B ;
        4'b11: // Clear
           ALU_Result = 0;
        default: ALU_Result = A;
        endcase
    end

endmodule

// 0001 not
//   0011 add
//   0100 sub
//   0101 and
//   0110 or
//   0111 halt
//   0010 store
//   1010 clear
//   1000 skip
//   1001 jump
