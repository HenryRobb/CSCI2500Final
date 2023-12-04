'timescale 1ns / 1ps

module ram
  #	(parameter ADDR_WIDTH = 12,
     parameter DATA_WIDTH = 8,
     parameter LENGTH = (1<<ADDR_WIDTH)
    );
  (input clk,
   input[ADDR_WIDTH-1:0] addr,
   inout [DATA_WIDTH-1:0] data,
   input cs,
   input we,
   input oe
  );
  
  reg [DATA_WIDTH-1:0] mem[LENGTH];
  reg [DATA_WIDTH-1:0] tmp_data;
  always @ (posedge clk) begin
    if (cs & we)
      mem[addr] <= data;
  end
  
  always @ (negedge clk) begin
    if (cs & !we)
      tmp_data <= mem[addr];
  end
  
  assign data = cs & oe & !we ? tmp_data : 'hz;
endmodule