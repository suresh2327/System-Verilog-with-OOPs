module tb;
  int data1,data2;
  event done;
  int i=0;
  //generator code
  initial begin
    for(i=0;i<8;i++)begin
      data1=$random();
      $display("generated data = %d",data1);
      #1;
      #9;
    end
    ->done;
  end
  //driver code
  initial begin
    forever begin
    #10;
    data2=data1;
    $display("recived data = %d",data2);
  end
  end
  //simulation hold
 initial begin
   wait(done.triggered);
   $finish;
 end
endmodule