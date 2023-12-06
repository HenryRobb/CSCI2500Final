// Code your testbench here
// or browse Examples
//hello:)
module test;
  
  reg [7:0] a;
  reg [7:0] b;
  reg [3:0] aluMode;
  reg [7:0] s;
  
  //initiate add8
  alu myAlu(s, a, b, aluMode);
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1,test);
 	
    aluMode = 4'b0000;
    a = 0'hab;
    b = 0'hcb;
    
    #10;
    
    aluMode = 4'b0001;
    
    #10;
    
    aluMode = 4'b0010;
    
    #10;
    
    aluMode = 4'b0011;
    
    #10;
    
    aluMode = 4'b0000;
    a = 0'h6f;
    b = 0'he1;
    
    #10;
    
    aluMode = 4'b0001;
    
    #10;
    
    aluMode = 4'b0010;
    
    #10;
    
    aluMode = 4'b0011;
    
    #10;
    
    $finish;
  end
endmodule