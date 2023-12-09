//is implementation of 8 bits correct in ram and ram_large and is the implementation of 64x8bit and 256 byte memory correct
//how does our splitting of instructions affect ir

`timescale 1 ns / 1 ps

module test_cpu;
  
  reg osc;
  localparam period = 10;

  wire clk; 
  assign clk = osc; 

  reg cs;
  reg we;
  reg oe;
  integer i;
  reg [7:0] MAR;
  wire [7:0] data;
  reg [7:0] testbench_data;
  assign data = !oe ? testbench_data : 'hz;

  single_port_sync_ram_large  #(.DATA_WIDTH(8)) ram
  (   .clk(clk),
   .addr(MAR),
      .data(data[7:0]),
      .cs_input(cs),
      .we(we),
      .oe(oe)
  );
  
  reg [7:0] A;
  reg [7:0] B;
  reg [7:0] ALU_Out;
  reg [3:0] ALU_Sel;
  alu alu8(
    .a(A),
    .b(B),  // ALU 8-bit Inputs
    .aluMode(ALU_Sel),// ALU Selection
    .s(ALU_Out) // ALU 8-bit Output
     );
  
  reg [7:0] PC = 'h00;
  reg [7:0] IRA = 'h00;
  reg [7:0] IRB = 'h00;
  reg [7:0] MBR = 'h00;//goes through ALU, has to be 8 bit
  reg [7:0] AC = 'h00; //goes through ALU, has to be 8 bit

  initial osc = 1;  //init clk = 1 for positive-edge triggered
  always begin  // Clock wave
     #period  osc = ~osc;
  end

  initial begin
   
     $dumpfile("dump.vcd");
     $dumpvars;
    // Multiplication by addition program
      @(posedge clk) MAR <= 'h00; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10;//load
      @(posedge clk) MAR <= 'h01; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1C;//N

      @(posedge clk) MAR <= 'h02; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h30;//sub
      @(posedge clk) MAR <= 'h03; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1D;//Pos1

      @(posedge clk) MAR <= 'h04; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h30;//Store
      @(posedge clk) MAR <= 'h05; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1E;//num

      @(posedge clk) MAR <= 'h06; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;//load anchor 2
      @(posedge clk) MAR <= 'h07; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1F;//num

      @(posedge clk) MAR <= 'h08; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10;//load
      @(posedge clk) MAR <= 'h09; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1D;//prod

      @(posedge clk) MAR <= 'h0A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;//add
      @(posedge clk) MAR <= 'h0B; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1E;//N

      @(posedge clk) MAR <= 'h0C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10;//store
      @(posedge clk) MAR <= 'h0D; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1F;//prod

      @(posedge clk) MAR <= 'h0E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;//load
      @(posedge clk) MAR <= 'h0F; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h1D;//ctr

      @(posedge clk) MAR <= 'h10; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10;//sub
      @(posedge clk) MAR <= 'h11; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;//pos1

      @(posedge clk) MAR <= 'h12; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h40;//store
      @(posedge clk) MAR <= 'h13; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h21;//ctr

      @(posedge clk) MAR <= 'h14; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;//skip cond 400
      @(posedge clk) MAR <= 'h15; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;//blank

      @(posedge clk) MAR <= 'h16; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h81;//skip cond 400
      @(posedge clk) MAR <= 'h17; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;//unneccessary

      @(posedge clk) MAR <= 'h18; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h90;//jump
      @(posedge clk) MAR <= 'h19; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;//00

      @(posedge clk) MAR <= 'h1A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h70;//halt
      @(posedge clk) MAR <= 'h1B; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;//halt

      @(posedge clk) MAR <= 'h1C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;//zero=0
      @(posedge clk) MAR <= 'h1D; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h01;//t1=1
      @(posedge clk) MAR <= 'h1E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;//t2=0
      @(posedge clk) MAR <= 'h1F; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;//sum=0
      @(posedge clk) MAR <= 'h20; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0A;//ctr=b
      @(posedge clk) MAR <= 'h21; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h01;//pos1=1

    
    
    
    @(posedge clk) PC <= 'h00;
    
    for (i = 0; i < 250; i = i+1) begin
          // Fetch
          @(posedge clk) MAR <= PC; we <= 0; cs <= 1; oe <= 1;
          @(posedge clk) IRA <= data;
          @(posedge clk) PC <= PC + 1;
          @(posedge clk) MAR <= PC;
          @(posedge clk) IRB <= data;
          @(posedge clk) PC <= PC + 1;
          // Decode and execute
      case(IRA[7:4])
      //load
        4'b0001: begin
              @(posedge clk) MAR <= IRB;
              @(posedge clk) MBR <= data;
              @(posedge clk) AC <= MBR;
        end 
        //store
		4'b0010: begin
              @(posedge clk) MAR <= IRB;
              @(posedge clk) MBR <= AC;
              @(posedge clk) we <= 1; oe <= 0; testbench_data <= MBR;      
        end
        //add
        4'b0011: begin
              @(posedge clk) MAR <= IRB;
              @(posedge clk) MBR <= data;
              @(posedge clk) ALU_Sel <= 'b0011; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        //subtract
        4'b0100: begin
              @(posedge clk) MAR <= IRB;
              @(posedge clk) MBR <= data;
              @(posedge clk) ALU_Sel <= 'b0100; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        //and
        4'b0100: begin
              @(posedge clk) MAR <= IRB;
              @(posedge clk) MBR <= data;
              @(posedge clk) ALU_Sel <= 'b0101; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        //or
        4'b0100: begin
              @(posedge clk) MAR <= IRB;
              @(posedge clk) MBR <= data;
              @(posedge clk) ALU_Sel <= 'b0110; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        //not
        4'b0100: begin
              @(posedge clk) MAR <= IRB;
              @(posedge clk) MBR <= data;
              @(posedge clk) ALU_Sel <= 'b1111; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        //halt
        4'b0111: begin
              @(posedge clk) PC <= PC - 2;
        end
        //skip
        4'b1000: begin
          @(posedge clk)
          if(IRA[1:0]==2'b01 && AC == 0) PC <= PC + 2;
          else if(IRA[1:0]==2'b00 && AC < 0) PC <= PC + 2;
          else if(IRA[1:0]==2'b10 && AC > 0) PC <= PC + 2;
        end
        //jump
        4'b1001: begin
              @(posedge clk) PC <= IRB;
        end
        //return
        4'b1011: begin
              @(posedge clk) MAR <= IRB;
              @(posedge clk) MBR <= data;
              @(posedge clk) MAR <= MBR;
              @(posedge clk) MBR <= data;
              @(posedge clk) PC <= MBR;
        end
        //jump with linking
        4'b1100: begin
            @(posedge clk) MAR <= IRB;
            @(posedge clk) ALU_Sel <= 'b0011; A <= PC; B <= 'b0001;
            @(posedge clk) MBR <= ALU_Out;
            @(posedge clk) we <= 1;
            @(posedge clk) testbench_data <= MBR;
            @(posedge clk) we <= 0;
            @(posedge clk) ALU_Sel <= 'b0011; A <= IRB; B <= 'b0001;
            @(posedge clk) AC <= ALU_Out;
            @(posedge clk) PC <= AC;
        end
        //clear
        4'b1010: begin
          @(posedge clk) AC <= 0;
        end
          
      endcase
         
    end
    
      
    @(posedge clk) MAR <= 'h0D; we <= 0; cs <= 1; oe <= 1;
    
    @(posedge clk)
        
   #20 $finish;
  end

endmodule
