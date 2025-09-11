`include "core_struct.vh"
module RegFile (
  input clk,
  input rst,
  input we,
  input CorePack::reg_ind_t  read_addr_1,
  input CorePack::reg_ind_t  read_addr_2,
  input CorePack::reg_ind_t  write_addr,
  input  CorePack::data_t write_data,
  output CorePack::data_t read_data_1,
  output CorePack::data_t read_data_2
);
  import CorePack::*;

  integer i;
  data_t register [1:31]; // x1 - x31, x0 keeps zero

  // fill your code
  
  // initialize the RegFile
  initial begin
    for (i = 0; i < 32; i = i + 1)
      register[i] = 0;
  end

  // write
  always @(posedge clk) begin
    if (we && write_addr)                               // if write_addr == 0 ,then it can't be wirtten
      register[write_addr] <= write_data;
  end

  // read
    assign read_data_1 = register[read_addr_1];
    assign read_data_2 = register[read_addr_2];


endmodule
