class scoreboard;
  
  localparam DWIDTH = `DWIDTH;
  
  transaction t;
  mailbox #(transaction) mon2sco;
  longint correct; 
  
  bit [(3*DWIDTH)-1 : 0] macOut;
  bit [(3*DWIDTH)-1 : 0] prevP;  
  bit [DWIDTH-1 : 0] aQ[$];
  bit [DWIDTH-1 : 0] bQ[$];
  
  
  function new(mailbox #(transaction) mon2sco);
    this.mon2sco = mon2sco;
    t = new();
    prevP = '0;
    aQ = {0,0};
    bQ = {0,0};
    this.correct = 0;
  endfunction
  
  function bit [(3*DWIDTH)-1 : 0] mac(input [DWIDTH-1:0] a, input [DWIDTH-1 : 0] b, input [(3*DWIDTH)-1 : 0] p);
    mac = (a*b) + p ;
  endfunction
  
  
  task run();
    forever begin
      mon2sco.get(t);      
      aQ.push_back(t.a);
      bQ.push_back(t.b);
      macOut = mac(aQ.pop_front(), bQ.pop_front(), prevP);
//      t.display("[SCO]");
      assert(t.p == macOut)begin
            correct = correct + 1;
      end
      else begin
        $display("Golden Value : %d, Obtained Value : %d",macOut,t.p);
        $error("Incorrect Result @ %0t",$time);
      end
      prevP = macOut;
    end
  endtask
    
endclass