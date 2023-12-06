// Code your design here
//edit
module fadd (co, s, a, b, c);
  input a, b ,c;
  output co, s;
  wire n1, n2, n3;
    xor(n1, a, b);
    xor(s, n1, c);
    nand(n2, a, b);
    nand(n3, n1, c);
    nand(co, n3, n2);
endmodule

module not8(s, a);
  input [7:0] a;
  output [7:0] s;
  not(s[0], a[0]);
  not(s[1], a[1]);
  not(s[2], a[2]);
  not(s[3], a[3]);
  not(s[4], a[4]);
  not(s[5], a[5]);
  not(s[6], a[6]);
  not(s[7], a[7]);
endmodule

module add8 (s, cout, ci, a, b);
  input [7:0] a,b ; // port declarations
  input ci ;
  output [7:0] s ; // vector
  output cout ;
  wire [6:0] co ;
    fadd a0 (co[0], s[0], a[0], b[0], ci);
    fadd a1 (co[1], s[1], a[1], b[1], co[0]);
    fadd a2 (co[2], s[2], a[2], b[2], co[1]);
    fadd a3 (co[3], s[3], a[3], b[3], co[2]);
    fadd a4 (co[4], s[4], a[4], b[4], co[3]);
    fadd a5 (co[5], s[5], a[5], b[5], co[4]);
    fadd a6 (co[6], s[6], a[6], b[6], co[5]);
    fadd a7 (cout, s[7], a[7], b[7], co[6]);
endmodule

module sub8 (s, cout, ci, a, b);
  input [7:0] a,b ; // port declarations
  input ci ;
  output reg [7:0] s ; // vector
  output cout ;
  reg [7:0] invv;
  not8 n0 (invv, b);//invert b
  reg [7:0] one = 00000001;
  reg[7:0] hold;
  add8 a0(hold, cout, ci, invv, one);//add 1 to b
  add8 a1(s, cout, ci, a, hold); //add a and negative b
endmodule


module and8(s, a, b);
  input [7:0] a, b;
  output [7:0] s;
  and(s[0], a[0], b[0]);
  and(s[1], a[1], b[1]);
  and(s[2], a[2], b[2]);
  and(s[3], a[3], b[3]);
  and(s[4], a[4], b[4]);
  and(s[5], a[5], b[5]);
  and(s[6], a[6], b[6]);
  and(s[7], a[7], b[7]);
endmodule


module or8(s, a, b);
  input [7:0] a, b;
  output [7:0] s;
  or(s[0], a[0], b[0]);
  or(s[1], a[1], b[1]);
  or(s[2], a[2], b[2]);
  or(s[3], a[3], b[3]);
  or(s[4], a[4], b[4]);
  or(s[5], a[5], b[5]);
  or(s[6], a[6], b[6]);
  or(s[7], a[7], b[7]);
endmodule

module alu(s, cout, ci, a, b, aluMode);
  input [7:0] a,b ; // port declarations
  input ci ;
  input [3:0] aluMode; //switch between functions
  output reg [7:0] s ; // vector
  output cout ;
  reg [7:0] s0, s1, s2, s3, s4;

  //function declerations
  add8 adde(s0, cout, ci, a, b);
  sub8 sube(s1, cout, ci, a, b);
  and8 ande(s2,a,b);
  or8 ore(s3,a,b);
  not8 note(s4, a);


  always @(a,b,ci,aluMode) begin
    if(aluMode==4'b0000) begin//add
      s <= s0;
    end
    else if(aluMode==4'b0001) begin//subtract
      s <= s1;
    end
    else if(aluMode==4'b0010) begin//and
	  s <= s2;
    end
    else if(aluMode==4'b0011) begin//or
	  s <= s3;
    end
    else if(aluMode==4'b0100) begin//not
	  s <= s4;
    end
  end
endmodule