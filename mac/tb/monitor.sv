class monitor;
  
  localparam DWIDTH = `DWIDTH;
  
  transaction t;
  mailbox #(transaction) mon2scb;  
  virtual intf intff;
  
  function new(virtual intf intff, mailbox #(transaction) mon2scb);
    this.mon2scb = mon2scb;
    this.intff = intff;
    t = new(); 
  endfunction
  
  task run();
    forever begin
      @(posedge intff.clk);
      t.a = intff.a;
      t.b = intff.b;
      t.p = intff.p;
      mon2scb.put(t.copy);
//      t.display("[MON]");
    end
  endtask
    
endclass