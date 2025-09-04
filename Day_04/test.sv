//using fork none
module tb;
  task one();
    #20;
    $display("task1 is started = %0t",$time);
    #10;
    $display("task1 is completed = %0t",$time);
  endtask
  task two();
    #20;
    $display("task2 is started = %0t",$time);
     #10;
    $display("task2 is completed = %0t",$time);
  endtask
  task three();
    $display("task3 is started = %0t",$time);
     #10;
    $display("task3 is completed = %0t",$time);
  endtask
  initial begin
    fork
      one();
      two();
    join_none
    three();
  end
endmodule