			SV OOPS CODES WITH OUTPUTS

// Class: A class in SystemVerilog is a blueprint that can hold variables (data) and functions/tasks (behavior). It is mainly used in testbenches for verification.

// Object: An object is a real instance of a class, created using the new() keyword. It allows access to the class’s variables and functions.

//creating a class with the name of VLSI
class vlsi;
  string str="VLSI";
  int a=90;
endclass

module tb;
  vlsi v; //creating a handle or object for an class
  initial begin
    v=new(); // allocating the memmory for class using an object or class
    $display("string =%0s,a =%0d",v.str,v.a);//we are accesing data from to module with a object
  end
endmodule

//output :
# KERNEL: string =VLSI,a =90


//5/08/2025
//sv tb sync using intial begin block

// Code your testbench here
// or browse Examples
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

//output :

# KERNEL: generated data =   303379748
# KERNEL: recived data =   303379748
# KERNEL: generated data = -1064739199
# KERNEL: recived data = -1064739199
# KERNEL: generated data = -2071669239
# KERNEL: recived data = -2071669239
# KERNEL: generated data = -1309649309
# KERNEL: recived data = -1309649309
# KERNEL: generated data =   112818957
# KERNEL: recived data =   112818957
# KERNEL: generated data =  1189058957
# KERNEL: recived data =  1189058957
# KERNEL: generated data = -1295874971
# KERNEL: recived data = -1295874971
# KERNEL: generated data = -1992863214
# KERNEL: recived data = -1992863214


//6/08/2025
//using fork join
module tb;
  task one();
    $display("task1 is started = %0t",$time);
    #10;
    $display("task1 is completed = %0t",$time);
  endtask
  task two();
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
    join
    three();
  end
endmodule

output :
# KERNEL: task1 is started = 0
# KERNEL: task2 is started = 0
# KERNEL: task1 is completed = 10
# KERNEL: task2 is completed = 10
# KERNEL: task3 is started = 10
# KERNEL: task3 is completed = 20



//same code using fork join_any
//using fork any
module tb;
  task one();
    $display("task1 is started = %0t",$time);
    #10;
    $display("task1 is completed = %0t",$time);
  endtask
  task two();
    #30;
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
    join_any
    three();
  end
endmodule

//output :
# KERNEL: task1 is started = 0
# KERNEL: task1 is completed = 10
# KERNEL: task3 is started = 10
# KERNEL: task3 is completed = 20
# KERNEL: task2 is started = 30
# KERNEL: task2 is completed = 40


//same code using fork none
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

//output :
# task3 is started = 0
# task3 is completed = 10
# task1 is started = 20
# task2 is started = 20
# task1 is completed = 30
# task2 is completed = 30

//07/08/2025
//using class sync generator and tb

class generator;
  int data=35;
  mailbox mbx;
  task run();
    mbx.put(data);
    $display("Generator Data=%0d", data);
  endtask
endclass

class driver;
  int data1=0;
  mailbox mbx;
  task run();
    mbx.get(data1);
    $display("Driver Received Data=%0d", data1);
  endtask
endclass
module tb;
  generator gen;
  driver div;
  mailbox mbx;
  initial begin
    gen=new();
    div=new();
    mbx=new();
    
    gen.mbx =mbx;
    div.mbx=mbx;
    gen.run();
    div.run();
  end
endmodule

//output 
# KERNEL: Generator Data=35
# KERNEL: Driver Received Data=35


//08/08/2025
//interface code for addition of two numbers 

//desgin code
// Code your design here
module add(a,b,c);
  input [2:0]a,b;
  output [3:0]c;
  assign c=a+b;
endmodule

//test bench code
// Code your testbench here
// or browse Examples
interface inter; 
  logic [2:0]a;
  logic [2:0]b;
  logic [3:0]c;
endinterface

module tb;
  inter aif();
  add dut(.a(aif.a),.b(aif.b),.c(aif.c));
  initial begin
    aif.a=2;aif.b=3;#5;
    aif.a=3;aif.b=4;
  end
 initial begin
   $monitor("sum of %0d and %0d is %0d",aif.a,aif.b,aif.c);
   #100;
   $finish;
 end
endmodule


//output
# KERNEL: sum of 2 and 3 is 5
# KERNEL: sum of 3 and 4 is 7


//code for half adder interface
//desgin code
// Code your design here
module ha(a,b,sum,carry);
  input a,b;
  output sum,carry;
  assign sum=a^b;
  assign carry=a&b;
endmodule

//test bench code
// Code your testbench here
// or browse Examples
interface inter;
  logic a;
  logic b;
  logic sum;
  logic carry;
endinterface

module tb;
  inter haif();
  ha dut (.a(haif.a),.b(haif.b),.sum(haif.sum),.carry(haif.carry));
  initial begin
    haif.a=0;haif.b=0;#5;
     haif.a=0;haif.b=1;#5;
     haif.a=1;haif.b=0;#5;
     haif.a=1;haif.b=1;
  end
  initial begin
    $monitor("a=%0b,b=%0b,sum=%0b,carry=%0b",haif.a,haif.b,haif.sum,haif.carry);
    #100;
    $finish;
  end
endmodule

//output
# KERNEL: a=0,b=0,sum=0,carry=0
# KERNEL: a=0,b=1,sum=1,carry=0
# KERNEL: a=1,b=0,sum=1,carry=0
# KERNEL: a=1,b=1,sum=0,carry=1

//code for d flip flop interfce
//desgin code
// Code your design here
module d_ff(clk,reset,d,q);
  input clk,d,reset;
  output reg q;
  always@(posedge clk ) begin
    if(!reset)begin
      q<=0;
    end
    else
      begin
    q<=d;
      end
  end
endmodule

//test bench code
// Code your testbench here
// or browse Examples
interface inter;
  logic reset;
  logic clk;
  logic d;
  logic q;

endinterface

module tb;
  inter dif();
  d_ff dut(.d(dif.d),.q(dif.q),.clk(dif.clk),.reset(dif.reset));
  
    initial dif.clk=0;
  always #5 dif.clk=~dif.clk;
  
  
  initial begin
    dif.reset=0;#5;
    dif.reset=1;#5;
    
    dif.d=0;
    #10;
    dif.d=1;
  end
  initial begin
    $monitor("time=%0t,clk=%0b,reset=%0b,d=%0b,q=%0b",$time,dif.clk,dif.reset,dif.d,dif.q);
    #50;
    $finish;
  end
endmodule

//08/08/2025

complete code for genrator , driver and dut;
// Code your design here
module add(
  input [2:0]a,b,
  output [3:0]y
);
  assign y=a+b;
endmodule

interface inter;
  logic [2:0]a;
  logic [2:0]b;
  logic [3:0]c;
endinterface

class generator;
  int a=5;
  int b=6;
  mailbox mbx;
  task run();
    mbx.put({a[2:0],b[2:0]});
    $display("generator test cases a=%0d,b=%0d",a,b);
  endtask
endclass

class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
    bit [5:0]temp;
    bit [2:0]a,b;
    mbx.get(temp);
    a=temp[5:3];
    b=temp[2:0];
    vif.a=a;
    vif.b=b;
    #10;
    $display("driver applied :a=%0d, b=%0d DUT output c=%0d",a,b,vif.c);
  endtask
endclass
//test bench
module tb;
  mailbox mbx;
  driver div;
  generator gen;
  inter aif();
  add u1(.a(aif.a),.b(aif.b),.y(aif.c));
  initial begin
    mbx=new();
    gen=new();
    div=new();
    gen.mbx=mbx;
    div.mbx=mbx;
    div.vif=aif;
    fork
      gen.run();
      div.run();
    join
  end
endmodule


//output
# generator test cases a=5,b=6
# driver applied :a=5, b=6--DUT output c=11



//09/08/2025
//half adder code with generator , driver , mailbox, interface 

//desgin code
module ha(a,b,sum,carry);
  input a,b;
  output sum,carry;
  assign sum=a^b;
  assign carry=a&b;
endmodule

interface inter;
  logic a;
  logic b;
  logic sum;
  logic carry;
endinterface

//testbench 
// Code your testbench here
// or browse Examples
class generator;
  mailbox mbx;
  bit a;
  bit b;
  int i=0;
  
  task run();
    for(i=0;i<4;i++)begin
       {a,b}=i;
       mbx.put({a,b});
      $display("generator test cases : a=%0b, b=%0b",a,b);
    end
    
  endtask
endclass
 
class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
        bit [1:0]temp;
    bit a,b;
    forever begin
      #1;
    mbx.get(temp);
    vif.a=temp[1];
    vif.b=temp[0];
    #10;
    $display("Driver applied test cases : a=%0b,b=%0b and output from dut sum =%0b, carry=%0b",vif.a,vif.b,vif.sum,vif.carry);
    end
  endtask
endclass

module tb;
//   logic a;
//   logic b;
//   logic sum;
//   logic carry;
  ha u1(aif.a,aif.b,aif.sum,aif.carry);
  inter aif();
  generator gen;
  mailbox mbx;
  driver div;
  initial begin
    gen=new();
    mbx=new();
    div=new();
    gen.mbx=mbx;
    div.mbx=mbx;
    div.vif=aif;
    
    gen.run();
    div.run();
  end
endmodule

//output 
# generator test cases : a=0, b=0
# generator test cases : a=0, b=1
# generator test cases : a=1, b=0
# generator test cases : a=1, b=1
# Driver applied test cases : a=0,b=0 and output from dut sum =0, carry=0
# Driver applied test cases : a=0,b=1 and output from dut sum =1, carry=0
# Driver applied test cases : a=1,b=0 and output from dut sum =1, carry=0
# Driver applied test cases : a=1,b=1 and output from dut sum =0, carry=1



//half subsctrator code with gen,div,mbx,interface
// Code your design here
module hs(a,b,diff,borw);
  input a,b;
  output diff,borw;
  assign diff=a^b;
  assign borw=~a&b;
endmodule

interface inter;
  logic a;
  logic b;
  logic diff;
  logic borw;
endinterface


//test bench
// Code your testbench here
// or browse Examples
class generator;
  mailbox mbx;
  bit a,b;
  task run();
    for(int i=0;i<4;i++)begin
      {a,b}=i;
      $display("generator test cases : A=%0b,B=%0b",a,b);
      mbx.put({a,b});
    end
  endtask
endclass

class driver;
  mailbox mbx;
  virtual inter vif;
  bit [1:0]temp;
  bit a,b;
  task run();
    forever #1 begin 
      mbx.get(temp);
      vif.a=temp[1];
      vif.b=temp[0];
      #5;
      $display("driver applied test cases : A=%0b,B=%0b and output fromm dut DIFFERENCE=%0b,BORROW=%0b",vif.a,vif.b,vif.diff,vif.borw);
    end
  endtask
endclass

module tb;
  hs u1(.a(aif.a),.b(aif.b),.diff(aif.diff),.borw(aif.borw));
  inter aif();
  generator gen;
  driver div;
  mailbox mbx;
  initial begin
    gen=new();
    div=new();
    mbx=new();
    gen.mbx=mbx;
    div.mbx=mbx;
    div.vif=aif;
    
    gen.run();
    div.run();
  end
  initial begin
    #100;
    $finish;
  end
endmodule

//output
# KERNEL: generator test cases : A=0,B=0
# KERNEL: generator test cases : A=0,B=1
# KERNEL: generator test cases : A=1,B=0
# KERNEL: generator test cases : A=1,B=1
# KERNEL: driver applied test cases : A=0,B=0 and output fromm dut DIFFERENCE=0,BORROW=0
# KERNEL: driver applied test cases : A=0,B=1 and output fromm dut DIFFERENCE=1,BORROW=1
# KERNEL: driver applied test cases : A=1,B=0 and output fromm dut DIFFERENCE=1,BORROW=0
# KERNEL: driver applied test cases : A=1,B=1 and output fromm dut DIFFERENCE=0,BORROW=0

//full adder code with gen,div,mbx,interface

// Code your design here
// Code your design here
module fa(a,b,c,sum,carry);
  input a,b,c;
  output sum,carry;
  assign sum=a^b^c;
  assign carry=((a&b)|(b&c)|(c&a));
endmodule

interface inter;
  logic a;
  logic b;
  logic c;
  logic sum;
  logic carry;
endinterface


//test bench

class generator;
  mailbox mbx;
  bit a;
  bit b;
  bit c;
  int i=0;
  
  task run();
    for(i=0;i<8;i++)begin
      {a,b,c}=i;
      mbx.put({a,b,c});
      $display("generator test cases : a=%0b, b=%0b c=%0b",a,b,c);
    end
  endtask
endclass
 
class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
    bit [2:0]temp;
    bit a,b;
    forever begin
      #1;
    mbx.get(temp);
      vif.a=temp[2];
      vif.b=temp[1];
      vif.c=temp[0];
      
    #10;
      $display("Driver applied test cases : a=%0b,b=%0b c=%0b and output from dut sum =%0b, carry=%0b",vif.a,vif.b,vif.c,vif.sum,vif.carry);
    end
  endtask
endclass

module tb;
//   logic a;
//   logic b;
//   logic sum;
//   logic carry;
  fa u1(aif.a,aif.b,aif.c,aif.sum,aif.carry);
  inter aif();
  generator gen;
  mailbox mbx;
  driver div;
  initial begin
    gen=new();
    mbx=new();
    div=new();
    gen.mbx=mbx;
    div.mbx=mbx;
    div.vif=aif;
    
    gen.run();
    div.run();
  end
endmodule


//output:
# KERNEL: generator test cases : a=0, b=0 c=0
# KERNEL: generator test cases : a=0, b=0 c=1
# KERNEL: generator test cases : a=0, b=1 c=0
# KERNEL: generator test cases : a=0, b=1 c=1
# KERNEL: generator test cases : a=1, b=0 c=0
# KERNEL: generator test cases : a=1, b=0 c=1
# KERNEL: generator test cases : a=1, b=1 c=0
# KERNEL: generator test cases : a=1, b=1 c=1
# KERNEL: Driver applied test cases : a=0,b=0 c=0 and output from dut sum =0, carry=0
# KERNEL: Driver applied test cases : a=0,b=0 c=1 and output from dut sum =1, carry=0
# KERNEL: Driver applied test cases : a=0,b=1 c=0 and output from dut sum =1, carry=0
# KERNEL: Driver applied test cases : a=0,b=1 c=1 and output from dut sum =0, carry=1
# KERNEL: Driver applied test cases : a=1,b=0 c=0 and output from dut sum =1, carry=0
# KERNEL: Driver applied test cases : a=1,b=0 c=1 and output from dut sum =0, carry=1
# KERNEL: Driver applied test cases : a=1,b=1 c=0 and output from dut sum =0, carry=1
# KERNEL: Driver applied test cases : a=1,b=1 c=1 and output from dut sum =1, carry=1


//full subsctrator with gen,div,mbx,interface

// Code your design here
module fs(a,b,c,diff,borw);
  input a,b,c;
  output diff,borw;
  assign diff=a^b^c;
  assign borw=((~(a^b)&c)+(~a&b));
endmodule

interface inter;
  logic a;
  logic b;
  logic c;
  logic diff;
  logic borw;
endinterface


//testbench code
// Code your testbench here
// or browse Examples
// Code your testbench here
// or browse Examples
class generator;
  mailbox mbx;
  bit a;
  bit b;
  bit c;
  int i=0;
  
  task run();
    for(i=0;i<8;i++)begin
      {a,b,c}=i;
      mbx.put({a,b,c});
      $display("generator test cases : a=%0b, b=%0b c=%0b",a,b,c);
    end
  endtask
endclass
 
class driver;
  mailbox mbx;
  virtual inter vif;
  task run();
    bit [2:0]temp;
    bit a,b;
    forever begin
      #1;
    mbx.get(temp);
      vif.a=temp[2];
      vif.b=temp[1];
      vif.c=temp[0];
      
    #10;
      $display("Driver applied test cases : a=%0b,b=%0b c=%0b and output from dut difference =%0b, borrow=%0b",vif.a,vif.b,vif.c,vif.diff,vif.borw);
    end
  endtask
endclass

module tb;
//   logic a;
//   logic b;
//   logic sum;
//   logic carry;
  fs u1(aif.a,aif.b,aif.c,aif.diff,aif.borw);
  inter aif();
  generator gen;
  mailbox mbx;
  driver div;
  initial begin
    gen=new();
    mbx=new();
    div=new();
    gen.mbx=mbx;
    div.mbx=mbx;
    div.vif=aif;
    
    gen.run();
    div.run();
  end
endmodule

//output
# KERNEL: ASDB file was created in location /home/runner/dataset.asdb
# KERNEL: generator test cases : a=0, b=0 c=0
# KERNEL: generator test cases : a=0, b=0 c=1
# KERNEL: generator test cases : a=0, b=1 c=0
# KERNEL: generator test cases : a=0, b=1 c=1
# KERNEL: generator test cases : a=1, b=0 c=0
# KERNEL: generator test cases : a=1, b=0 c=1
# KERNEL: generator test cases : a=1, b=1 c=0
# KERNEL: generator test cases : a=1, b=1 c=1
# KERNEL: Driver applied test cases : a=0,b=0 c=0 and output from dut difference =0, borrow=0
# KERNEL: Driver applied test cases : a=0,b=0 c=1 and output from dut difference =1, borrow=1
# KERNEL: Driver applied test cases : a=0,b=1 c=0 and output from dut difference =1, borrow=1
# KERNEL: Driver applied test cases : a=0,b=1 c=1 and output from dut difference =0, borrow=1
# KERNEL: Driver applied test cases : a=1,b=0 c=0 and output from dut difference =1, borrow=0
# KERNEL: Driver applied test cases : a=1,b=0 c=1 and output from dut difference =0, borrow=0
# KERNEL: Driver applied test cases : a=1,b=1 c=0 and output from dut difference =0, borrow=0
# KERNEL: Driver applied test cases : a=1,b=1 c=1 and output from dut difference =1, borrow=1



//mux 2 to 1 code with gen,div,mbx,interface


// Code your design here
module mux2to1(i0,i1,y,s);
  input i0,i1,s;
  output y;
  assign y = (~s&i0)+(s&i1);
  endmodule

interface inter;
  logic i0;
  logic i1;
  logic s;
  logic y;
endinterface


// Code your testbench here
// or browse Examples
class generator;
  mailbox mbx;
  bit i0,i1,s;
  task run();
    for(int i=0;i<8;i++)begin
      {s,i1,i0}=i;
      $display("generator test cases : sel=%0b,i1=%0b,i0=%0b",s,i1,i0);
      mbx.put({s,i1,i0});
    end
  endtask
endclass

class driver;
  mailbox mbx;
  virtual inter vif;
  bit [2:0]temp;
  bit s,i0,i1;
  task run();
    forever begin
      mbx.get(temp);
      vif.s=temp[2];
      vif.i1=temp[1];
      vif.i0=temp[0];
      #10;
      $display("driver recived test cases : sel=%0b,i1=%0b,i0=%0b output from dut Y=%0b",vif.s,vif.i1,vif.i0,vif.y);
    end
  endtask
endclass

module tb;
  inter aif();
  mux2to1 u1(aif.i0,aif.i1,aif.y,aif.s);
  generator gen;
  mailbox mbx;
  driver div;
  initial begin
    gen=new();
    div=new();
    mbx=new();
    gen.mbx=mbx;
    div.mbx=mbx;
    div.vif=aif;
    gen.run();
    div.run();
  end
  
  initial begin
    $display("Simulation completed");
    #100;
    $finish;
  end
endmodule


//output
# generator test cases : sel=0,i1=0,i0=0
# generator test cases : sel=0,i1=0,i0=1
# generator test cases : sel=0,i1=1,i0=0
# generator test cases : sel=0,i1=1,i0=1
# generator test cases : sel=1,i1=0,i0=0
# generator test cases : sel=1,i1=0,i0=1
# generator test cases : sel=1,i1=1,i0=0
# generator test cases : sel=1,i1=1,i0=1
# driver recived test cases : sel=0,i1=0,i0=0 output from dut Y=0
# driver recived test cases : sel=0,i1=0,i0=1 output from dut Y=1
# driver recived test cases : sel=0,i1=1,i0=0 output from dut Y=0
# driver recived test cases : sel=0,i1=1,i0=1 output from dut Y=1
# driver recived test cases : sel=1,i1=0,i0=0 output from dut Y=0
# driver recived test cases : sel=1,i1=0,i0=1 output from dut Y=0
# driver recived test cases : sel=1,i1=1,i0=0 output from dut Y=1
# driver recived test cases : sel=1,i1=1,i0=1 output from dut Y=1


//task calling code
// Code your testbench here
// or browse Examples
module top;
  bit [2:0]x,y;
  bit [3:0]z;
  bit clk;
  initial clk=0;
  always #10 clk=~clk;
  task add();
    z=x+y;
    $display("time =%0t : %0d + %0d = %0d",$time,x,y,z);
  endtask
  
// creating a manual test cases for addition operation
  task simulation();
    x=1;y=1;#10;
    add();
    x=2;y=2;#10;
    add();
    x=3;y=3;#10;
    add();
  endtask
  
  //creating a test cases randomly for every posedge of clk
  task clock();
    @(posedge clk)
    x=$urandom();
    y=$urandom();
    add();
    clock();
  endtask
  
initial begin
    x=2;
    y=5;
  add();
  simulation();
  clock();
  end
  
  initial begin
    #200;
    $finish;
  end
endmodule

//output :
# KERNEL: time =0 : 2 + 5 = 7
# KERNEL: time =10 : 1 + 1 = 2
# KERNEL: time =20 : 2 + 2 = 4
# KERNEL: time =30 : 3 + 3 = 6
# KERNEL: time =50 : 6 + 3 = 9
# KERNEL: time =70 : 6 + 7 = 13
# KERNEL: time =90 : 4 + 3 = 7
# KERNEL: time =110 : 4 + 3 = 7
# KERNEL: time =130 : 5 + 3 = 8
# KERNEL: time =150 : 3 + 6 = 9
# KERNEL: time =170 : 5 + 0 = 5
# KERNEL: time =190 : 1 + 5 = 6


//code for pass by values 
module tb;
  task swap(input [3:0]a,b);
    bit [3:0]temp;
    temp=a;
    a=b;
    b=temp;
    $display("a=%0d b=%0d",a,b);
  endtask
  bit [3:0]a,b;
  initial begin
    a=5;
    b=9;
    $display("a=%0d b=%0d",a,b);
    swap(a,b);
  end
endmodule

//output 
# KERNEL: a=5 b=9
# KERNEL: a=9 b=5


//code for pass by reference 
module tb;
  task automatic  swap( ref bit [3:0] a,b);
    bit [3:0]temp;
    temp=a;
    a=b;
    b=temp;
    $display("a=%0d b=%0d",a,b);
  endtask
  bit [3:0]a,b;
  initial begin
    a=5;
    b=9;
    swap(a,b);
    $display("a=%0d b=%0d",a,b);
  end
endmodule

//output 
# KERNEL: a=9 b=5
# KERNEL: a=9 b=5

//code for constant pass by reference
module tb;
  task automatic swap(const ref bit [3:0] a,ref bit [3:0] b);
    bit [3:0]temp;
    temp=a;
   // a=b;
    b=temp;
    $display("a=%0d b=%0d",a,b);
  endtask
  bit [3:0]a,b;
  initial begin
    a=5;
    b=9;
    swap(a,b);
    $display("a=%0d b=%0d",a,b);
  end
endmodule

//output
# KERNEL: a=5 b=5
# KERNEL: a=5 b=5

//case 2 for constant pass by reference
module tb;
  task automatic swap(ref bit [3:0] a,const ref bit [3:0] b);
    bit [3:0]temp;
    temp=a;
    a=b;
   // b=temp;
    $display("a=%0d b=%0d",a,b);
  endtask
  bit [3:0]a,b;
  initial begin
    a=5;
    b=9;
    swap(a,b);
    $display("a=%0d b=%0d",a,b);
  end
endmodule


//output 
# KERNEL: a=9 b=9
# KERNEL: a=9 b=9



// proof for pass by value is applicable for only scalars
// Code your testbench here
// or browse Examples
module tb;
  task arr(input bit[2:0] a[8]);
    //bit[2:0] indicates size of the array
    //a[8] indicates the number of elements in given array
    for (int i=0;i<=7;i++)begin
      a[i]=i;
    //  $display("a[%0d]=%0d",i,a[i]);
    end
  endtask
  bit [2:0] a[8];
  initial begin
    arr(a);
    for(int i=0;i<=7;i++)
      begin
        $display("a[%0d]=%0d",i,a[i]);
      end
  end

endmodule

//output 
# KERNEL: a[0]=0
# KERNEL: a[1]=0
# KERNEL: a[2]=0
# KERNEL: a[3]=0
# KERNEL: a[4]=0
# KERNEL: a[5]=0
# KERNEL: a[6]=0
# KERNEL: a[7]=0

//Note : You decleared that the taskk arguments as an input that indicates pass by value
..pass b values copies the values (copies all zeros)
//pass by value only for scalars/single


//proof for pass by refence is applicable for vector 

// Code your testbench here
// or browse Examples
module tb;
  task automatic arr(ref bit[2:0] a[8]);
    //bit[2:0] indicates size of the array
    //a[8] indicates the number of elements in given array
    for (int i=0;i<=7;i++)begin
      a[i]=i;
    end
  endtask
  bit [2:0] a[8];
  initial begin
    arr(a);
    for(int i=0;i<=7;i++)
      begin
        $display("a[%0d]=%0d",i,a[i]);
      end
  end
endmodule


//output 
# KERNEL: a[0]=0
# KERNEL: a[1]=1
# KERNEL: a[2]=2
# KERNEL: a[3]=3
# KERNEL: a[4]=4
# KERNEL: a[5]=5
# KERNEL: a[6]=6
# KERNEL: a[7]=7



//example code for custom constructor or user defiened construct
// Code your testbench here
// or browse Examples
class vlsi;
  int data;
  function new(input int datain=0);
    data=datain;
  endfunction
endclass

module tb;
  vlsi v;
  initial begin
    v=new(4);
    $display("Data=%0d",v.data);
  end
endmodule

//output 
# KERNEL: Data=4



//second version of custom construcor code
//with different class members and different functions aruguments


class vlsi;
  int data;
  bit [7:0]data1;
  shortint data2;
  function new(input int datain=0,input bit [7:0] datain1, input shortint datain2);
    data=datain;
    data1=datain1;
    data2=datain2;
  endfunction
endclass

module tb;
  vlsi v;
  initial begin
    v=new(4,3,2);
    $display("Data=%0d Data1=%0d,Data2=%0d",v.data,v.data1,v.data2);
  end
endmodule

//output :
# KERNEL: Data=4 Data1=3,Data2=2

//code for custom constructor using same name of class members and function aruguments using this keyword

class vlsi;
  int data;
  bit [7:0]data1;
  shortint data2;
  function new(input int data=0,input bit [7:0] data1, input shortint data2);
    this.data=data;
    this.data1=data1;
    this.data2=data2;
  endfunction
endclass

module tb;
  vlsi v;
  initial begin
    v=new(.data1(17),.data(29),.data2(555));
    $display("Data=%0d Data1=%0d,Data2=%0d",v.data,v.data1,v.data2);
  end
endmodule

//outputs
# KERNEL: Data=29 Data1=17,Data2=555

//class in class code 
// Code your testbench here
// or browse Examples
class first;
  int data=50;
endclass

class second;
  first f;
  function new();
    f=new();
  endfunction
endclass
module tb;
  second s;
  initial begin
    s=new();
    $display("data=%0d",s.f.data);
    s.f.data=45;
        $display("data=%0d",s.f.data);
  end
endmodule

//output:
# KERNEL: data=50
# KERNEL: data=45


/number copying :- non object properties uses the separate memory
// here varibels are stored in the different memory locations
//in number copying separate memory locationa re used for the given varibale
module tb;
  int a,b;
  initial begin
    a=9;
    b=6;
    $display("a=%0d,b=%0d",a,b);
    b=a;
     $display("a=%0d,b=%0d",a,b);
    a=20;
    $display("b=%0d",b);     
  end
endmodule

//output:
# KERNEL: a=9,b=6
# KERNEL: a=9,b=9
# KERNEL: b=9


/* 
 	object copying :
     1) when we assign destinaion object with source object the memory of the destination object will be deleted and both destinationa nd source objects will point out to the source memory.
     2) that is the reason why when we update the any changes in source object it refelect and update the whole code 
*/

class vlsi;
  int a;
  int b;
endclass
module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v2=new();
    v2.a=10;
    v1=v2;
    $display("v1.a=%0d",v1.a);
    $display("V1=%0p",v1);
    v2.a=20;
    $display("v1.a=%0d",v1.a);
    $display("V1=%0p",v1);
    
  end
endmodule

//output :
# KERNEL: v1.a=10
# KERNEL: V1=10 0
# KERNEL: v1.a=20
# KERNEL: V1=20 0


/*
shallow copying :
  				--> it can be used to overcome the prohlems with copy with handle
               --> in shallow opy memory is created for destination handle or object
*/


//shallow copy for non objected property

class vlsi;
  int a;  //Non object property
  int b;  //Non object property
endclass
module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v2=new();
    v2.a=10;
    
    v1=new v2;
    $display("v1.a=%0d",v1.a);
    $display("V1=%0p",v1);
    v2.a=20;
    $display("v1.a=%0d",v1.a);
    $display("V1=%0p",v1);
    
  end
endmodule


//output:
# KERNEL: v1.a=10
# KERNEL: V1=10 0
# KERNEL: v1.a=10
# KERNEL: V1=10 0


/*
shallow copying :
  				--> it can be used to overcome the prohlems with copy with handle
               --> in shallow opy memory is created for destination handle or object
                --> **shallow copy work only with non objected properties(data types) only 
                --> it will not work for (objects) object properties
                 --> it is better for non object properties


  drawback :
            shallow copy fail to copy the value whenever there is an object is created below the class
 
*/


//shallow copying for fails conditon for objected property
class packet;
  int count;
endclass

class vlsi;
  int a;  //Non object property
  int b;  //Non object property
  packet pck=new(); //object property
endclass
module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v2=new();
    v2.a=10;
    v2.pck.count=50;
    v1=new v2;
    $display("v1.a=%0d",v1.a);
    $display("V1=%0p",v1);
    v2.a=20;
    $display("v1.a=%0d",v1.a);
    $display("V1=%0p",v1);
    
  end
endmodule

//output:
# KERNEL: v1.a=10
# KERNEL: V1=10 0 <class handle>
# KERNEL: v1.a=10
# KERNEL: V1=10 0 <class handle>




//shallow copy
class packet;
  int count;
endclass

class vlsi;
  int a;  //Non object property
  int b;  //Non object property
  packet pck=new(); //object property
  function void print();
    $display("a=%0d",a);
    $display("b=%0d",b);
    $display("pck=%0p",pck);
  endfunction
endclass

module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v2=new();
    v2.a=10;
    v2.b=20;
    v2.pck.count=100;
    v1=new v2;
    $display("v1=%0p",v1);
    //this is one of draback of shallow copy when object properties is there it will copy the class handle not the actual values and it is properly working with non object properties
    v2.a=30;
    v2.b=40;
    v2.pck.count=200;
    // this is another problem of shallow copy the non object properties have separate memory locations and object properties have same memory locations so, even we changes a,,b values it doesn't updated the a,b values and the object pck.count is updated it has same memory location.
    v1.print();
    v2.print();
  end
endmodule

//output 
# KERNEL: v1=10 20 <class handle>
# KERNEL: a=10
# KERNEL: b=20
# KERNEL: pck=200
# KERNEL: a=30
# KERNEL: b=40
# KERNEL: pck=200


//07//09//10
/*
Deep Copy: 
	<Source_handle> copy (<Dest_handle>);
--> Creat Memory for the Destination Object 
--> Also Creat memory for the objects below the class also.
--> Copy Field by field from source to destination.
*/

class packet;
  int count;
  function void display(string prefix="");
    $display("%s packet: count=%0d", prefix, count);
  endfunction
endclass


class sample;
  int a;       // Non-object variable
  int b;       // Non-object variable 
  packet pck;  // Object variable

  function new();
    pck = new();  
  endfunction

  // Deep copy
  function void deep_copy(sample src);
    this.a = src.a;
    this.b = src.b;
    this.pck = new();               
    this.pck.count = src.pck.count;  
  endfunction

 
  function void display(string prefix="");
    $display("%s sample: a=%0d b=%0d", prefix, a, b);
    pck.display({prefix,"  "});
  endfunction
endclass


module tb;
  sample s1, s2;

  initial begin
    s1 = new();
    s2 = new();

    s2.a = 100;
    s2.pck.count = 50;

    s1.deep_copy(s2);   
    s1.display("s1");
    s2.display("s2");

    $display("---- Modify s2 ----");
    s2.a = 200;
    s2.b = 300;
    s2.pck.count = 600;

    s1.display("s1");
    s2.display("s2");
  end
endmodule

//output
# KERNEL: s1 sample: a=100 b=0
# KERNEL: s1   packet: count=50
# KERNEL: s2 sample: a=100 b=0
# KERNEL: s2   packet: count=50
# KERNEL: ---- Modify s2 ----
# KERNEL: s1 sample: a=100 b=0
# KERNEL: s1   packet: count=50
# KERNEL: s2 sample: a=200 b=300
# KERNEL: s2   packet: count=600



//deep copy simpled versionn
class packet;
  int count;
endclass

class vlsi;
  int a;  //Non object property
  int b;  //Non object property
  packet pck=new(); //object property
  function void print();
    $display("a=%0d",a);
    $display("b=%0d",b);
    $display("pck=%0p",pck); 
  endfunction
  function void copy(output vlsi v);
    v=new();
    v.a=a;
    v.b=b;
    v.pck=new();
    v.pck.count=pck.count;
  endfunction
endclass

module tb;
  vlsi v1,v2;
  initial begin
    v1=new();
    v2=new();
    v2.a=10;
    v2.b=20;
    v2.pck.count=100;
    
    v2.copy(v1);
    //$display("v1=%0p",v1);
    v1.print();
    v2.a=30;
    v2.b=40;
    v2.pck.count=200;
    v1.print();
    //v2.print();
  end
endmodule


//output:
# KERNEL: a=10
# KERNEL: b=20
# KERNEL: pck=100
# KERNEL: a=10
# KERNEL: b=20
# KERNEL: pck=100


Casting: 

Analogy : Melt the metal and put into different shapes.

*Converting onee Variable into the Another Variable Format*
** Casting can only be done for Singular Variables.**
--> int a; // Singular Variable 
--> int b[3:0]; // Non_ Singular

/*Variable can be a Object / Non_ Object
**Non Object: Data Type is Known at the time of Compile. Hence this type of Casting is called Static Casting.
--> Static Casting Does not use the $cast .
EX: */
	module top;
 	 int a;
 	 byte unsigned b;
  	initial begin
  	a=-30;
    	b=a;
    	$display(" b=%0d", b);
    	b=byte'(a);
    	$display(" b=%0d", b);
  	end
	endmodule
// Here byte' Performs the Static Casting.

//“Convert the value of a (an int, 32-bit signed) into a byte (8-bit signed), then assign it to b.”






/*This is called upcasting.

Upcasting is always safe because every eth_good_pkt is also an eth_pkt.

So this cast will succeed.

Upcasting (derived → base) always succeeds.

Downcasting (base → derived) may fail if the object is not really of derived type.

$cast = safe runtime check when converting between object handles (especially base ↔ derived).
*/
/*** Object : Data Type is Decided at the Run time.
--> The Object can be of any class type( it can be base / Derived class). Hence it is called the Dynamic Casting.

Note: 
	No Inheritance → $cast fails
	With Inheritance → $cast works

--> It is mainly used in class inheritance when you want to safely convert a base-class handle into a derived-class handle.
*/
//code
class eth_pkt;
  int count ;
endclass

class eth_good_pkt extends eth_pkt;
  int a;
endclass

module top;
bit f;
  eth_pkt pkt=new();
  eth_good_pkt g_pkt=new();	
  initial begin
    //$cast ( pkt,g_pkt) ; // $cast is called System Task
    f=$cast ( pkt,g_pkt) ; // System Function
  end
endmodule

//$cast(pkt, g_pkt);

//Here you are casting a derived-class handle (g_pkt) into a base-class handle (pkt).


//down casting
class eth_pkt;
  int count ;
endclass

class eth_good_pkt extends eth_pkt;
  int a;
endclass

module top;
 bit f;
  eth_pkt pkt=new();
  eth_good_pkt g_pkt=new();	
  initial begin
    $cast( g_pkt,pkt) ; // $cast is called System Task
    //f=$cast ( pkt,g_pkt) ; // System Function
  end
endmodule

//output:
# RUNTIME: Error: RUNTIME_0197 testbench.sv (28): Illegal conversion to object of class eth_good_pkt from object of class eth_pkt.


//up casting

class eth_pkt;
  int count ;
endclass

class eth_good_pkt extends eth_pkt;
  int a;
endclass

module top;
bit f;
  eth_pkt pkt=new();
  eth_good_pkt g_pkt=new();	
  initial begin
    $cast(pkt,g_pkt) ; // $cast is called System Task
    //f=$cast ( pkt,g_pkt) ; // System Function
  end
endmodule

//output : No error
    

/*
$cast Possibilities: 

eth_pkt pkt1, pkt2;
eth_good_pkt  g_pkt;
eth_bad_pkt     b_pkt;

$cast(g_pkt, pkt1)
--> Not Possible
--> Above usage is as a  task , we get the run time error.

$cast (pkt1,g_pkt)
--> Possible 

$cast (g_pkt, b_pkt)
--> Not Possible, since they are not directly realted through inheritance.


Conclusion: 
	$cast → Type Conversion (runtime check)

=> Purpose: Change a handle type (Base ↔ Derived).

=> Does not copy the object, only reinterprets the handle safely.


*/


//clone
/*$clone → Making a new copy (duplicate object)
Use $clone when you care about getting your own independent copy.*/

//09//09//2025
//up casting
class ethernet_pck;
  int a;
endclass

class good_ethernet_pck extends ethernet_pck;
  int b;
endclass
module tb;
  bit y;
    ethernet_pck eth_pck;
  good_ethernet_pck good_pck;
    
  initial begin
    eth_pck=new();
    good_pck=new();
    //upcasting using system task and system fucntion
   $cast(eth_pck,good_pck);//up casting using system task
    y=$cast(eth_pck,good_pck);//up casting using system function
    $display("y=%0b",y);
  end
endmodule
    
//output :
   # KERNEL: y=1


//down casting
class ethernet_pck;
  int a;
endclass

class good_ethernet_pck extends ethernet_pck;
  int b;
endclass
module tb;
  bit y;
    ethernet_pck eth_pck;
  good_ethernet_pck good_pck;
    
  initial begin
    eth_pck=new();
    good_pck=new();

   //$cast(good_pck,ethernet_pck);//down casting
    y=$cast(good_pck,eth_pck);//down casting using system function
    $display("y=%0b",y);
  end
endmodule

//output :
//case:1
 ERROR VCP5220 "Variable reference to a non-variable ethernet_pck." "testbench.sv" 21  30
 ERROR VCP5118 "Non-typed object used in expression: ethernet_pck [class]." "testbench.sv"
//case:2  
# KERNEL: y=0
    

 //transsaction class example
 // for apb transcation using properites , methods , constraints for 1 transacation:

 // Code your testbench here
// or browse Examples
class apb_tx;
 rand bit wr_rd;
 rand bit [7:0]addr;
 rand bit [31:0]data;
 rand bit [3:0]sel;
  
   function void print();
    $display("wr_rd=%0b | addr=%0h | data=%0h | sel=%0d",wr_rd,addr,data,sel);
  endfunction


constraint sel_c{
  sel inside {4'b0000,4'b0010,4'b0100,4'b1000,4'b1010};
}
endclass

module tb;
  apb_tx tx=new();
  initial begin
   
      tx.randomize();
    tx.print();
    
  end
endmodule


//output:
# KERNEL: wr_rd=0 | addr=59 | data=6001c9ca | sel=10



// for apb transcation using properites , methods , constraints for 10 transacation:
class apb_tx;
 rand bit wr_rd;
 rand bit [7:0]addr;
 rand bit [31:0]data;
 rand bit [3:0]sel;
  
  function void print();
    $display("wr_rd=%0b | addr=%0h | data=%0h | sel=%0d",wr_rd,addr,data,sel);
  endfunction

constraint sel_c{
  sel inside {4'b0000,4'b0010,4'b0100,4'b1000,4'b1010};
}
endclass

module tb;
  apb_tx tx=new();
  initial begin
    repeat(10) begin
       tx.randomize();
    tx.print();
    end 
  end
endmodule


//output:
Compile success 0 Errors 1 Warnings 
# KERNEL: wr_rd=0 | addr=59 | data=6001c9ca | sel=10
# KERNEL: wr_rd=0 | addr=59 | data=35194105 | sel=2
# KERNEL: wr_rd=0 | addr=25 | data=aefa8798 | sel=8
# KERNEL: wr_rd=1 | addr=ab | data=16d29409 | sel=10
# KERNEL: wr_rd=0 | addr=7 | data=317de130 | sel=0
# KERNEL: wr_rd=0 | addr=a0 | data=247f3c23 | sel=0
# KERNEL: wr_rd=0 | addr=e4 | data=1c19d11d | sel=4
# KERNEL: wr_rd=1 | addr=70 | data=d649db16 | sel=2
# KERNEL: wr_rd=1 | addr=f8 | data=7b0fd5f8 | sel=10
# KERNEL: wr_rd=0 | addr=cd | data=13f43acd | sel=8



//for apb transcation using properites , methods , constraints for 10 transacation , without warnings:

class apb_tx;
 rand bit wr_rd;
 rand bit [7:0]addr;
 rand bit [31:0]data;
 rand bit [3:0]sel;
  
  function void print();
    $display("wr_rd=%0b | addr=%0h | data=%0h | sel=%0d",wr_rd,addr,data,sel);
  endfunction

constraint sel_c{
  sel inside {4'b0000,4'b0010,4'b0100,4'b1000,4'b1010};
}
endclass

module tb;
  apb_tx tx=new();
  initial begin
    repeat(10) begin
      assert ( tx.randomize());
    tx.print();
    end 
  end
endmodule

//output:
Compile success 0 Errors 0 Warnings 
# KERNEL: wr_rd=0 | addr=59 | data=6001c9ca | sel=10
# KERNEL: wr_rd=0 | addr=59 | data=35194105 | sel=2
# KERNEL: wr_rd=0 | addr=25 | data=aefa8798 | sel=8
# KERNEL: wr_rd=1 | addr=ab | data=16d29409 | sel=10
# KERNEL: wr_rd=0 | addr=7 | data=317de130 | sel=0
# KERNEL: wr_rd=0 | addr=a0 | data=247f3c23 | sel=0
# KERNEL: wr_rd=0 | addr=e4 | data=1c19d11d | sel=4
# KERNEL: wr_rd=1 | addr=70 | data=d649db16 | sel=2
# KERNEL: wr_rd=1 | addr=f8 | data=7b0fd5f8 | sel=10
# KERNEL: wr_rd=0 | addr=cd | data=13f43acd | sel=8


//for apb transcation using properites , methods , constraints for 10 transacation , without warnings only for write operation:
class apb_tx;
  bit wr_rd;
 rand bit [7:0]addr;
 rand bit [31:0]data;
 rand bit [3:0]sel;
  
  function void print();
    $display("wr_rd=%0b | addr=%0h | data=%0h | sel=%0d",wr_rd,addr,data,sel);
  endfunction

constraint sel_c{
  sel inside {4'b0000,4'b0010,4'b0100,4'b1000,4'b1010};
}
endclass

module tb;
  apb_tx tx=new();
  initial begin
    tx.wr_rd=1;
    repeat(10) begin
      assert ( tx.randomize());
    tx.print();
    end 
  end
endmodule

//output:
# KERNEL: wr_rd=1 | addr=e2 | data=56bc4659 | sel=10
# KERNEL: wr_rd=1 | addr=bc | data=1da9b9a0 | sel=10
# KERNEL: wr_rd=1 | addr=c0 | data=947db9eb | sel=0
# KERNEL: wr_rd=1 | addr=98 | data=25abb74a | sel=2
# KERNEL: wr_rd=1 | addr=ab | data=16d29409 | sel=0
# KERNEL: wr_rd=1 | addr=44 | data=9e3bf206 | sel=2
# KERNEL: wr_rd=1 | addr=b8 | data=f8103438 | sel=0
# KERNEL: wr_rd=1 | addr=23 | data=e00bb17c | sel=0
# KERNEL: wr_rd=1 | addr=e4 | data=1c19d11d | sel=0
# KERNEL: wr_rd=1 | addr=70 | data=d649db16 | sel=8


//for apb transcation using properites , methods , constraints for 10 transacation , without warnings only for write operation for one slave only:
class apb_tx;
  bit wr_rd;
 rand bit [7:0]addr;
 rand bit [31:0]data;
 rand bit [3:0]sel;
  
  function void print();
    $display("wr_rd=%0b | addr=%0h | data=%0h | sel=%0d",wr_rd,addr,data,sel);
  endfunction

constraint sel_c{
  sel inside {4'b1010};
}
endclass

module tb;
  apb_tx tx=new();
  initial begin
    tx.wr_rd=1;
    repeat(10) begin
      assert ( tx.randomize());
    tx.print();
    end 
  end
endmodule


//output :
# KERNEL: wr_rd=1 | addr=e7 | data=49d7df22 | sel=10
# KERNEL: wr_rd=1 | addr=e2 | data=56bc4659 | sel=10
# KERNEL: wr_rd=1 | addr=ca | data=cafc69bc | sel=10
# KERNEL: wr_rd=1 | addr=a0 | data=69867559 | sel=10
# KERNEL: wr_rd=1 | addr=5 | data=74817bc0 | sel=10
# KERNEL: wr_rd=1 | addr=eb | data=5329a5e0 | sel=10
# KERNEL: wr_rd=1 | addr=25 | data=aefa8798 | sel=10
# KERNEL: wr_rd=1 | addr=4a | data=c3b56ade | sel=10
# KERNEL: wr_rd=1 | addr=c5 | data=30a1b9ab | sel=10
# KERNEL: wr_rd=1 | addr=9 | data=4c378f0d | sel=10

//22/09/2025

class apb_tx;
  rand bit wr_rd;
 rand bit [7:0]addr;
 rand bit [31:0]data;
 rand bit [3:0]sel;
  
  function void print(string thub);
    $display("[%0s] wr_rd=%0b | addr=%0h | data=%0h | sel=%0d ",thub,wr_rd,addr,data,sel);
  endfunction
endclass

class generator;
  apb_tx tx;
  mailbox mbx;
  task run();
    repeat(10) begin
       tx=new();
     tx.randomize();
      mbx.put(tx);
      tx.print("gen");
    end
  endtask  
endclass

class driver;
  mailbox mbx;
  apb_tx tx;
  
  task run();
    repeat (10) begin
      tx=new();
      mbx.get(tx);
      tx.print("div");
    end
  endtask
endclass


module tb;
   
  generator gen;
  driver div;
  mailbox mbx;
  initial begin
    gen=new();
    div=new();
    mbx=new();
    gen.mbx=mbx;
    div.mbx=mbx;

    fork
     gen.run();
     div.run();
    join
  end
endmodule

      
