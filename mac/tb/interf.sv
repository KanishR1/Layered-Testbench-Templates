`include "defines.svh"
interface intf();
  
  localparam DWIDTH = `DWIDTH;
  
  logic clk;
  logic aresetn;
  logic [DWIDTH-1 : 0] a;
  logic [DWIDTH-1 : 0] b;
  logic [(3*DWIDTH)-1 : 0] p;
  
endinterface