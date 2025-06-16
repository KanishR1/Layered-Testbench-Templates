class environment;
  generator gen;
  driver drv;
  monitor mon;
  scoreboard scb;
  
  
  mailbox #(transaction) gen2drv;
  mailbox #(transaction) mon2scb;
  virtual intf vif;
  
  function new (virtual intf vif);
    this.vif = vif;
    
    gen2drv = new();
    mon2scb = new();
    gen = new(gen2drv);
    drv = new(vif, gen2drv);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
    gen.gen_next =  drv.gen_next;
    
  endfunction
  
  task test_run();
    fork
      gen.run();
      drv.run();
      mon.run();
      scb.run();
    join_any
  endtask
  
  task pre_test();
    drv.reset(); 
  endtask
  
  task post_test();
    wait(gen.done.triggered);
    repeat(3) @(posedge vif.clk);
    $display("-------- Simulation Over, Correct Matches : %f ------------", scb.correct);
    $finish;
  endtask
  
  
  task run();
    pre_test();
    test_run();
    post_test();
  endtask
  
endclass