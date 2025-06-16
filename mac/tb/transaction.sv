class transaction;
  
  localparam DWIDTH = `DWIDTH;

  randc bit [DWIDTH-1 : 0] a;
  randc bit [DWIDTH-1 : 0] b;
  bit [(3*DWIDTH)-1 : 0] p;

  
  function void display(input string classtag);
    $display("%s \t a = %d \t b = %d \t p = %d @ %0t", classtag, a, b, p, $time);    
  endfunction
  
  function transaction copy();
    copy = new();
    copy.a = a;
    copy.b = b;
    copy.p = p;
  endfunction
    
endclass