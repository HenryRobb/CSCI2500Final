//is implementation of 8 bits correct in ram and ram_large and is the implementation of 64x8bit and 256 byte memory correct
//how does our splitting of instructions affect ir

`timescale 1 ns / 1 ps

module test_cpu;
  parameter ADDR_WIDTH = 8;
  parameter DATA_WIDTH = 8;
  
  reg osc;
  localparam period = 10;

  wire clk; 
  assign clk = osc; 

  reg cs;
  reg we;
  reg oe;
  integer i;
  reg [ADDR_WIDTH-1:0] MAR;
  wire [DATA_WIDTH-1:0] data;
  reg [ADDR_WIDTH-1:0] testbench_data;
  assign data = !oe ? testbench_data : 'hz;

  single_port_sync_ram_large  #(.DATA_WIDTH(DATA_WIDTH)) ram
  (   .clk(clk),
   .addr(MAR),
      .data(data[DATA_WIDTH-1:0]),
      .cs_input(cs),
      .we(we),
      .oe(oe)
  );
  
  reg [7:0] A;
  reg [7:0] B;
  reg [7:0] ALU_Out;
  reg [3:0] ALU_Sel;
  alu alu16(
    .a(A),
    .b(B),  // ALU 8-bit Inputs
    .aluMode(ALU_Sel),// ALU Selection
    .s(ALU_Out) // ALU 8-bit Output
     );
  
  reg [7:0] PC = 'h00;
  reg [7:0] IR1 = 'h00;
  reg [7:0] IR2 = 'h00;
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
      @(posedge clk) MAR <= 'h00; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10;
      @(posedge clk) MAR <= 'h01; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0C;

      @(posedge clk) MAR <= 'h02; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;
      @(posedge clk) MAR <= 'h03; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0E;

      @(posedge clk) MAR <= 'h04; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10;
      @(posedge clk) MAR <= 'h05; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0D;

      @(posedge clk) MAR <= 'h06; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h30;
      @(posedge clk) MAR <= 'h07; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0B;

      @(posedge clk) MAR <= 'h08; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;
      @(posedge clk) MAR <= 'h09; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0D;

      @(posedge clk) MAR <= 'h0A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h10;
      @(posedge clk) MAR <= 'h0B; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0E;

      @(posedge clk) MAR <= 'h0C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h30;
      @(posedge clk) MAR <= 'h0D; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0F;

      @(posedge clk) MAR <= 'h0E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h20;
      @(posedge clk) MAR <= 'h0F; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0E;

      @(posedge clk) MAR <= 'h10; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h84;
      @(posedge clk) MAR <= 'h11; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;

      @(posedge clk) MAR <= 'h12; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h90;
      @(posedge clk) MAR <= 'h13; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h02;

      @(posedge clk) MAR <= 'h14; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h70;
      @(posedge clk) MAR <= 'h15; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;

      @(posedge clk) MAR <= 'h16; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;
      @(posedge clk) MAR <= 'h17; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h05;

      @(posedge clk) MAR <= 'h18; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;
      @(posedge clk) MAR <= 'h19; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h07;

      @(posedge clk) MAR <= 'h1A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;
      @(posedge clk) MAR <= 'h1B; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;

      @(posedge clk) MAR <= 'h1C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;
      @(posedge clk) MAR <= 'h1D; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h00;

      @(posedge clk) MAR <= 'h1E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'hF0;
      @(posedge clk) MAR <= 'h1F; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'hFF;

    
    
    
    @(posedge clk) PC <= 'h00;
    
    for (i = 0; i < 64; i = i+1) begin
          // Fetch
          @(posedge clk) MAR <= PC; we <= 0; cs <= 1; oe <= 1;
          @(posedge clk) IR1 <= data;
          @(posedge clk) PC <= PC + 1;

          @(posedge clk) IR2 <= data;
          @(posedge clk) PC <= PC + 1;
          // Decode and execute
      case(IR1[7:4])
      //load
        4'b0001: begin
              @(posedge clk) MAR <= IR2;
              @(posedge clk) MBR <= data;
              @(posedge clk) AC <= MBR;
        end 
        //store
		4'b0010: begin
              @(posedge clk) MAR <= IR2;
              @(posedge clk) MBR <= AC;
              @(posedge clk) we <= 1; oe <= 0; testbench_data <= MBR;      
        end
        //add
        4'b0011: begin
              @(posedge clk) MAR <= IR2;
              @(posedge clk) MBR <= data;
              @(posedge clk) ALU_Sel <= 'b01; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        //halt
        4'b0111: begin
              @(posedge clk) PC <= PC - 2;
        end
        //skip
        4'b1000: begin
          @(posedge clk)
          if(IR1[5:4]==2'b01 && AC == 0) PC <= PC + 2;
          else if(IR1[5:4]==2'b00 && AC < 0) PC <= PC + 2;
          else if(IR1[5:4]==2'b10 && AC > 0) PC <= PC + 2;
        end
        4'b1001: begin
              @(posedge clk) PC <= IR2;
        end
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
