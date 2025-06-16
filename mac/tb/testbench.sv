`include "interf.sv"
`include "mac_tb_files_pkg.sv"

`timescale 1ns/1ps

import mac_tb_pkg::*;

module testbench;
  
  intf intff();
  environment env;
  
  localparam DWIDTH = `DWIDTH;
  
  mac #(.DWIDTH(DWIDTH)) dut (
    .clk(intff.clk), 
    .a(intff.a), 
    .b(intff.b), 
    .p(intff.p), 
    .aresetn(intff.aresetn)
  );
  
  initial begin
    intff.clk = 1'b0;
    forever #5 intff.clk = ~intff.clk;
  end
  
  

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    env = new(intff);
    env.run();
  end
  
//   initial $monitor("%s \t a_reg = %d \t b_reg = %d \t p_val = %d @ %0t", "[TB]", dut.a_reg, dut.b_reg, dut.p_val, $time);

endmodule