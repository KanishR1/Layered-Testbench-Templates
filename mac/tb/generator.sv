class generator;
  
  localparam DWIDTH = `DWIDTH;
  
  transaction t;
  mailbox #(transaction) gen2drv;
  
  event gen_next;
  event done;
  
  int num_transactions = 2**(DWIDTH+1);
  
  function new(mailbox #(transaction) gen2drv);
    this.gen2drv = gen2drv;
    t = new();
  endfunction
  
  task run();
    for(int i=0; i<num_transactions; i++) begin
      assert(t.randomize()) else $display("Randomization Failed @ %0t",$time);
//       t.display("[GEN]");
      gen2drv.put(t.copy);
      @(gen_next); 
    end
    ->done;
  endtask
    
endclass