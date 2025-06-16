`include "defines.svh"

module mac #(
  parameter DWIDTH = `DWIDTH
)(
  // Global signals
  input clk,
  input aresetn,
  
  // Data Signals
  input [DWIDTH-1 : 0] a,
  input [DWIDTH-1 : 0] b,
  output logic [(3*DWIDTH)-1 : 0] p
);
  
  logic [DWIDTH-1 : 0] a_reg;
  logic [DWIDTH-1 : 0] b_reg;
  logic [(3*DWIDTH)-1 : 0] p_val;
  
  // Input Buffereing
  always_ff @(posedge clk, negedge aresetn) begin
    if(!aresetn) begin
      a_reg <= '0;
      b_reg <= '0;
    end
    else begin
      a_reg <= a;
      b_reg <= b;
    end
  end
  
  
  // Output Buffering
  always_ff @(posedge clk, negedge aresetn) begin
    if(!aresetn) p_val <= '0;
    else p_val <= (a_reg * b_reg) + p_val;
  end
  
  assign p = p_val;
  
endmodule // mac - multiply and accumulate