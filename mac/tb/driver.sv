
class driver;
  
  localparam DWIDTH = `DWIDTH;
  
  transaction t;
  mailbox #(transaction) gen2drv;
  virtual intf intff;
 event gen_next;
  
  function new(virtual intf intff, mailbox #(transaction) gen2drv);
    this.gen2drv = gen2drv;
    this.intff = intff;
  endfunction
  
  task run();
    forever begin
    @(posedge intff.clk);
      gen2drv.get(t);
//       t.display("[DRV]");
      intff.a <= t.a;        
      intff.b <= t.b;
     ->gen_next;        
    end
  endtask
  
task reset();
  intff.aresetn <= 1'b1;   // Assert reset (active low)
  intff.a <= '0;
  intff.b <= '0;
  @(negedge intff.clk);
  intff.aresetn <= 1'b0;
  @(negedge intff.clk);
  @(negedge intff.clk);    // Hold for 2 cycles
  intff.aresetn <= 1'b1;   // Deassert reset
  $display("[DRV] : RESET DONE @ %0t", $time);
  $display("-------------------------------------------------------");
endtask
    
endclass