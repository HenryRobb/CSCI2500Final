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
  reg [15:0] testbench_data;
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
    .A(A),
    .B(B),  // ALU 8-bit Inputs
    .ALU_Sel(ALU_Sel),// ALU Selection
    .ALU_Out(ALU_Out) // ALU 8-bit Output
     );
  
  reg [7:0] PC = 'h00;
  reg [7:0] IR = 'h00;
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
    @(posedge clk) MAR <= 'h00; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h110C;
    @(posedge clk) MAR <= 'h01; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h210E;
    @(posedge clk) MAR <= 'h02; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h110D;
    @(posedge clk) MAR <= 'h03; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h310B;
    @(posedge clk) MAR <= 'h04; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h210D;
    @(posedge clk) MAR <= 'h05; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h110E;
    @(posedge clk) MAR <= 'h06; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h310F;
    @(posedge clk) MAR <= 'h07; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h210E;
    @(posedge clk) MAR <= 'h08; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h8400;
    @(posedge clk) MAR <= 'h09; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h9102;
    @(posedge clk) MAR <= 'h0A; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h7000;
    @(posedge clk) MAR <= 'h0B; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0005;
    @(posedge clk) MAR <= 'h0C; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0007;
    @(posedge clk) MAR <= 'h0D; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0000;
    @(posedge clk) MAR <= 'h0E; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'h0000;
    @(posedge clk) MAR <= 'h0F; we <= 1; cs <= 1; oe <= 0; testbench_data <= 'hFFFF;
    
    
    @(posedge clk) PC <= 'h100;
    
    for (i = 0; i < 62; i = i+1) begin
          // Fetch
          @(posedge clk) MAR <= PC; we <= 0; cs <= 1; oe <= 1;
          @(posedge clk) IR <= data;
          @(posedge clk) PC <= PC + 1;
          // Decode and execute
      case(IR[15:12])
        4'b0001: begin
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= data;
              @(posedge clk) AC <= MBR;
        end 
		4'b0010: begin
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= AC;
              @(posedge clk) we <= 1; oe <= 0; testbench_data <= MBR;      
        end
        4'b0011: begin
              @(posedge clk) MAR <= IR[11:0];
              @(posedge clk) MBR <= data;
              @(posedge clk) ALU_Sel <= 'b01; A <= AC; B <= MBR;
              @(posedge clk) AC <= ALU_Out;
        end
        4'b0111: begin
              @(posedge clk) PC <= PC - 1;
        end
        4'b1000: begin
          @(posedge clk)
          if(IR[11:10]==2'b01 && AC == 0) PC <= PC + 1;
          else if(IR[11:10]==2'b00 && AC < 0) PC <= PC + 1;
          else if(IR[11:10]==2'b10 && AC > 0) PC <= PC + 1;
        end
        4'b1001: begin
              @(posedge clk) PC <= IR[11:0];
        end
        4'b1010: begin
          @(posedge clk) AC <= 0;
        end
          
      endcase
         
    end
    
      
    @(posedge clk) MAR <= 'h10D; we <= 0; cs <= 1; oe <= 1;
    
    @(posedge clk)
        
   #20 $finish;
  end

endmodule
