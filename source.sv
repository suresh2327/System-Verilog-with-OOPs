		//	SV OOPS CODES WITH OUTPUTS

// Class: A class in SystemVerilog is a blueprint that can hold variables (data) and functions/tasks (behavior).
// It is mainly used in testbenches for verification.

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

//output 
# KERNEL: [gen] wr_rd=0 | addr=3a | data=a5e360f4 | sel=9 
# KERNEL: [gen] wr_rd=1 | addr=c5 | data=ecb9e1da | sel=8 
# KERNEL: [gen] wr_rd=1 | addr=5e | data=220516f | sel=13 
# KERNEL: [gen] wr_rd=0 | addr=c1 | data=aa5568f4 | sel=10 
# KERNEL: [gen] wr_rd=0 | addr=b3 | data=ffb244cc | sel=4 
# KERNEL: [gen] wr_rd=0 | addr=63 | data=ba68f7db | sel=6 
# KERNEL: [gen] wr_rd=0 | addr=1e | data=20d7bfbd | sel=12 
# KERNEL: [gen] wr_rd=0 | addr=ef | data=4a5b1fcb | sel=0 
# KERNEL: [gen] wr_rd=1 | addr=f9 | data=1de2f63d | sel=4 
# KERNEL: [gen] wr_rd=1 | addr=5a | data=7c97ffec | sel=13 
# KERNEL: [div] wr_rd=0 | addr=3a | data=a5e360f4 | sel=9 
# KERNEL: [div] wr_rd=1 | addr=c5 | data=ecb9e1da | sel=8 
# KERNEL: [div] wr_rd=1 | addr=5e | data=220516f | sel=13 
# KERNEL: [div] wr_rd=0 | addr=c1 | data=aa5568f4 | sel=10 
# KERNEL: [div] wr_rd=0 | addr=b3 | data=ffb244cc | sel=4 
# KERNEL: [div] wr_rd=0 | addr=63 | data=ba68f7db | sel=6 
# KERNEL: [div] wr_rd=0 | addr=1e | data=20d7bfbd | sel=12 
# KERNEL: [div] wr_rd=0 | addr=ef | data=4a5b1fcb | sel=0 
# KERNEL: [div] wr_rd=1 | addr=f9 | data=1de2f63d | sel=4 
# KERNEL: [div] wr_rd=1 | addr=5a | data=7c97ffec | sel=13 



// inheritance classes
class parent;
   int a=10;
   int b=8;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

class child extends parent;
  int c;
  function void sub();
    c=a-b;
  $display("c=%0d",c);
  endfunction
endclass

class child1 extends child;
  int d;
  function void add();
    d=a+b;
    $display("d=%0d",d);
  endfunction
endclass

module tb;
  child c;
  child1  c1;
  initial begin
     c=new();
    c1=new();
    c.print();
    c.sub();
    c1.sub();
  end
endmodule

//output:

# KERNEL: a=10,b=8
# KERNEL: c=2
# KERNEL: c=2


//local keyword operation for variable inside the function
//local keyword is used to restrict the variable scope only inside the function only
   local int a=10;
   local int b=8;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

class child extends parent;
  int c;
  function void sub();
    c=a-b;
  $display("c=%0d",c);
  endfunction
endclass

class child1 extends child;
  int d;
  function void add();
    d=a+b;
    $display("d=%0d",d);
  endfunction
endclass

module tb;
  child c;
  child1  c1;
  initial begin
     c=new();
    c1=new();
    c.print();
    c.sub();
    c1.sub();
    
  end
endmodule
  
  //output :
  ERROR VCP5248 "Cannot access local/protected member ""a"" from this scope." "testbench.sv" 14  8
ERROR VCP5248 "Cannot access local/protected member ""b"" from this scope." "testbench.sv" 14  10
ERROR VCP5248 "Cannot access local/protected member ""a"" from this scope." "testbench.sv" 22  8
ERROR VCP5248 "Cannot access local/protected member ""b"" from this scope." "testbench.sv" 22  10


//procoted keyword operation for variable inside the function
// Code your testbench here
// or browse Examples
class parent;
    protected int a=10;
   protected int b=8;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

class child extends parent;
  int c;
  function void sub();
    c=a-b;
  $display("c=%0d",c);
  endfunction
endclass

class child1 extends child;
  int d;
  function void add();
    d=a+b;
    $display("d=%0d",d);
  endfunction
endclass

module tb;
  child c;
  child1  c1;
  initial begin
     c=new();
    c1=new();
    c.print();
    c.sub();
    c1.sub(); 
  end
endmodule

//output:
# KERNEL: a=10,b=8
# KERNEL: c=2
# KERNEL: c=2

//protected keyword operation for variable inside the class and inherited child classes aslo outside the class it will not work 




//for global keyword or public
class parent;
   int a=10;
   int b=8;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

class child extends parent;
  int c;
  function void sub();
    c=a-b;
  $display("c=%0d",c);
  endfunction
endclass

class child1 extends child;
  int d;
  function void add();
    d=a+b;
    $display("d=%0d",d);
  endfunction
endclass

module tb;
  child c;
  child1  c1;
  initial begin
     c=new();
    c1=new();
    c.print();
    c.sub();
    c1.sub();
    
  end
endmodule



//tx_class, generator , driver , mailbox , dut , interface for 2 to 1 mux 
// Code your testbench here
// or browse Examples

class tx_class;
 rand bit i0;
  rand bit i1;
  rand bit sel;
  task print(string id);
       $display("[%0s] test cases : sel=%0b,i1=%0b,i0=%0b",id,sel,i1,i0);
  endtask 
endclass


class generator;
  tx_class tx;
  mailbox mbx;
  task run();
    repeat(4) begin
      tx=new();
      assert (tx.randomize());
      mbx.put(tx);
      tx.print("generator to driver ");
    end
  endtask
endclass


class driver;
  tx_class tx;
  mailbox mbx;
 virtual inter vif;
  bit [2:0]temp;
  bit sel,i1,i0;
  task run();
    repeat(4) begin
      tx=new();
      mbx.get(tx);
      tx.print("driver to interface ");
      temp={tx.sel,tx.i1,tx.i0};
      vif.sel=temp[2];
      vif.i1=temp[1];
      vif.i0=temp[0];     
 
       #1 $display("output from dut sel=%0b,i1=%0b,i0=%0b,y=%0b",vif.sel,vif.i1,vif.i0,vif.y);
    end
  endtask
endclass



module tb;
  mux_2x1 u2(.sel(aif.sel),.i0(aif.i0),.i1(aif.i1),.y(aif.y));
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
    fork
    gen.run();
    div.run();
    join
   //div.display();
  end
endmodule

// 2 to 1 mux dut
// Code your design here
module mux_2x1(i1,i0,sel,y);
  input i1,i0,sel;
  output y;
  assign y=sel?i1:i0;
endmodule

interface inter;
  logic i0;
  logic i1;
  logic sel;
  logic y;
endinterface

//output:
# KERNEL: [generator to driver ] test cases : sel=0,i1=0,i0=0
# KERNEL: [generator to driver ] test cases : sel=0,i1=1,i0=1
# KERNEL: [generator to driver ] test cases : sel=1,i1=0,i0=1
# KERNEL: [generator to driver ] test cases : sel=0,i1=1,i0=0
# KERNEL: [driver to interface ] test cases : sel=0,i1=0,i0=0
# KERNEL: output from dut sel=0,i1=0,i0=0,y=0
# KERNEL: [driver to interface ] test cases : sel=0,i1=1,i0=1
# KERNEL: output from dut sel=0,i1=1,i0=1,y=1
# KERNEL: [driver to interface ] test cases : sel=1,i1=0,i0=1
# KERNEL: output from dut sel=1,i1=0,i0=1,y=0
# KERNEL: [driver to interface ] test cases : sel=0,i1=1,i0=0
# KERNEL: output from dut sel=0,i1=1,i0=0,y=0



//tx_class, generator , driver , mailbox , dut , interface for half adder
class tx_class;
  rand bit a;
  rand bit b;
  task print(string id);
    $display("[%0s] a=%0b,b=%0b",id,a,b);
  endtask
endclass

class generator;
  tx_class tx;
  mailbox mbx;
  task run();
    repeat(4)begin
    tx=new();
    assert (tx.randomize());
    mbx.put(tx);
    tx.print("generator to driver"); 
  end
  endtask
endclass

class driver;
  tx_class tx;
  virtual inter vif;
  mailbox mbx;
  bit [1:0]temp;
  task run();
    repeat(4)begin
    tx=new();
      mbx.get(tx);
    tx.print("driver to interface");
      vif.a=tx.a;
      vif.b=tx.b;
      #1; $display("output from dut sum=%0b,carry=%0b",vif.sum,vif.carry);
   end 
  endtask
endclass

module tb;
  ha u1(.a(aif.a),.b(aif.b),.sum(aif.sum),.carry(aif.carry));
  inter aif();
  mailbox mbx;
  generator gen;
  driver div;
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


//dut
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

//output;
# KERNEL: [generator to driver] a=0,b=0
# KERNEL: [generator to driver] a=1,b=1
# KERNEL: [generator to driver] a=1,b=0
# KERNEL: [generator to driver] a=0,b=1
# KERNEL: [driver to interface] a=0,b=0
# KERNEL: output from dut sum=0,carry=0
# KERNEL: [driver to interface] a=1,b=1
# KERNEL: output from dut sum=0,carry=1
# KERNEL: [driver to interface] a=1,b=0
# KERNEL: output from dut sum=1,carry=0
# KERNEL: [driver to interface] a=0,b=1
# KERNEL: output from dut sum=1,carry=0

//non static keyword
// Code your testbench here
// or browse Examples
class parent;
   int a=10;
   int b=20;
  function void print ();
    $display(" a=%0d,b=%0d",a,b);
  endfunction 
endclass

class child extends parent;
  int c;
  function void  add();
    c=a+b;
  $display(" c=%0d", c);
  endfunction 
endclass

module tb;
  child c1,c2;
  //parent p;
  initial begin
    c1=new();   // c1= c1.a + c1.b
    c2=new();   // c2 = c2.a + c2.b
    //p=new();
    c1.print();
    //p.print();
    c1.a=30;
    c2.b=40;
   // parent :: a=30;
   // parent :: b=40;
    c1.print();
    c2.print();
  end
endmodule

//output:
# KERNEL:  a=10,b=20
# KERNEL:  a=30,b=20
# KERNEL:  a=10,b=40

//scope resolution operator without static keyword
// Code your testbench here
// or browse Examples
class parent;
   int a=10;
   int b=20;
  function void print ();
    $display(" a=%0d,b=%0d",a,b);
  endfunction 
endclass

class child extends parent;
  int c;
  function void  add();
    c=a+b;
  $display(" c=%0d", c);
  endfunction 
endclass

module tb;
  child c1,c2;
  //parent p;
  initial begin
    c1=new();   // c1= c1.a + c1.b
    c2=new();   // c2 = c2.a + c2.b
    //p=new();
  //  c1.print();
    //p.print();
   // c1.a=30;
   // c2.b=40;
   parent :: a=30;
   parent :: b=40;
    c1.print();
    c2.print();
  end
endmodule

//output:
ERROR VCP5240 "Cannot access non-static class member 'parent.a' using scope operator '::'." "testbench.sv" 30  15
ERROR VCP5240 "Cannot access non-static class member 'parent.b' using scope operator '::'." "testbench.sv" 31  15


//scope resolution operator with static keyword
// Code your testbench here
// or browse Examples
class parent;
   static int a=10;
   static int b=20;
  function void print ();
    $display(" a=%0d,b=%0d",a,b);
  endfunction 
endclass

class child extends parent;
  int c;
  function void  add();
    c=a+b;
  $display(" c=%0d", c);
  endfunction 
endclass

module tb;
  child c1,c2;
  //parent p;
  initial begin
    c1=new();   // c1= c1.a + c1.b
    c2=new();   // c2 = c2.a + c2.b
    //p=new();
  //  c1.print();
    //p.print();
   // c1.a=30;
   // c2.b=40;
   parent :: a=30;
   parent :: b=40;
    c1.print();
    c2.print();
  end
endmodule

//output:
# KERNEL:  a=30,b=40
# KERNEL:  a=30,b=40

//inheritace 
class parent;
int a=10;
int b=15;
function void pdisplay ();
  $display(" a=%0d, b=%0d", a,b);
endfunction
endclass

class child extends parent;
  int c=20;
  function void cdisplay();
    $display(" c=%0d",c);
    endfunction
endclass

module tb;
  child c1;
  initial begin
    c1=new();
    c1.pdisplay();
    c1.cdisplay();
  end
endmodule
//output:
# KERNEL:  a=10, b=15
# KERNEL:  c=20

//multi level inheritance
class parent;
   int pdata=10;
  function void pprint();
    $display(" pdata=%0d", pdata);
  endfunction 
endclass

class child extends parent;
  int cdata=15;
  function void cprint();
    $display(" cdata=%0d", cdata);
  endfunction
endclass

class child1 extends parent;
  int c1data=20;
  function void c1print();
    $display(" c1data=%0d", c1data);
  endfunction
endclass

class child2 extends child;
  int c2data=25;
  function void c2print();
    $display(" c2data=%0d", c2data);
  endfunction
endclass
  
module tb;
  child c;
  child1 c1;
  child2 c2;
  initial begin
    c=new();
    c.cprint();
    c.pprint();
    c.pdata=50;
    c.pprint();
    c1=new();
    c1.c1print();
    c1.pprint();
    c1.pdata=60;
    c1.pprint();
    c2=new();
    c2.c2print();
    c2.cprint();
    c2.pprint();
    c2.cdata=70;
    c2.pdata=80;
    c2.c2data=90;
    c2.c2print();
    c2.cprint();
    c2.pprint();
  end
endmodule

//output:
# KERNEL:  cdata=15
# KERNEL:  pdata=10
# KERNEL:  pdata=50
# KERNEL:  c1data=20
# KERNEL:  pdata=10
# KERNEL:  pdata=60
# KERNEL:  c2data=25
# KERNEL:  cdata=15
# KERNEL:  pdata=10
# KERNEL:  c2data=90
# KERNEL:  cdata=70
# KERNEL:  pdata=80

//base class overriding
class parent;
  int a=20;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a=40;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass
module tb;
  child c;
  initial begin
    c=new();
    c.display();
  end
endmodule
//output:
# KERNEL:  a=40



// To the Above Problem the first solution is creating parent class Handle.

class parent;
  int a=20;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a=40;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass
module tb;
  parent p;
  child c;
  initial begin
    p=new();
    c=new();
    p.display();
    c.display();
  end
endmodule
//output:
# KERNEL:  a=20
# KERNEL:  a=40


//Correct Solution is " Super Keyword "

// Super keyword used in Child class only..

class parent;
  int a=20;
  function void display();
    $display(" a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a=40;
  function void display();
    super.display();
    $display(" a=%0d",a);
  endfunction
endclass
module tb;
  child c;
  initial begin
    c=new();
    c.display();
  end
endmodule
//output:
# KERNEL:  a=20
# KERNEL:  a=40

//Super keyword with Constructor: 

class parent;
  int a;
  function new(int a);
    this.a=a;
    $display("Parent  a=%0d",a);
  endfunction
endclass

class child extends parent;
  int a;
  function new(int p,int c);
    super.new(p);
    a=c;
    //super.display();
    $display("child  a=%0d",a);
  endfunction
endclass
module tb;
  child c;
  initial begin
    c=new(9,5);
    //c.display();
  end
endmodule

// --> super.variable_name;( super.display)
// 	--> Used to Access the Properties of the Parent whenever the parent 	is Overried.

// --> super.new(); 
// 	--> Is Used to Initialize the Parent class Data member.
//output:
# KERNEL: Parent  a=9
# KERNEL: child  a=5


//polymorphsim
class remote;
  virtual function void presspower();
    $display("default : No Device is Connected");
  endfunction
endclass
 
class fan extends remote;
  function void presspower();
    $display("Fan is ON/OFF");
  endfunction
endclass

class ac extends remote;
  function void presspower();
    $display("AC is ON/OFF");
  endfunction
endclass

class light extends remote;
  function void presspower();
    $display("LIGHT is ON/OFF");
  endfunction
endclass

module tb;
  remote device[3];
  initial begin
    device[0]=fan::new();
    device[1]=ac::new();
    device[2]=light::new();
    foreach(device[i]) device[i].presspower();
  end
endmodule

//output:
# KERNEL: Fan is ON/OFF
# KERNEL: AC is ON/OFF
# KERNEL: LIGHT is ON/OFF
  

// virtual class or abstract class
// Code your testbench here
// or browse Examples
virtual class base;
  int a=10;
  int b=20;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass


module tb;
  base b;
  initial begin
    b=new();
    b.print();
    b.a=3;
    b.b=2;
    b.print();  
    
  end
endmodule


//output:
ERROR VCP2937 "Cannot instantiate abstract class: base." "testbench.sv" 15  12



//the soultion for above problem create a child class and access the parernt class through child class object or handle
// Code your testbench here
// or browse Examples
virtual class base;
  int a=10;
  int b=20;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

class child extends base;
endclass


module tb;
  child c;
  initial begin
    c=new();
    c.print();
    c.a=3;
    c.b=2;
    c.print();  
    
  end
endmodule

//output:
# KERNEL: a=10,b=20
# KERNEL: a=3,b=2

//absctract class and pure virtual function
virtual class base;
  int a;
  int b;
  pure virtual function void print();
    //when we used pure virtual keyword in abstract class we does not allowed to write method logics in absctract 
    // we are allowed too create only templates and blue prints of logics which are implemeted and bulit in child classes
endclass

class child extends base;
  function void print();
    $display("a=%0d,b=%0d",a,b);
  endfunction
endclass

module tb;
  base b;
  child c;
  initial begin
    c=new();
    b=c;
    c.a=3;
    c.b=2;
    b.print();
  end
endmodule

//output:
# KERNEL: a=3,b=2


//in polymorphism , iin sub classess we didnot mention any methods 
//even we use the virtual keyword in base class it again going point ot the base class only

class remote;
  virtual function void presspower();
    $display("default : No Device is Connected");
  endfunction
endclass
 
class fan extends remote;
  function void presspower();
    $display("Fan is ON/OFF");
  endfunction
endclass

class ac extends remote;
//   function void presspower();
//     $display("AC is ON/OFF");
//   endfunction
endclass

class light extends remote;
  function void presspower();
    $display("LIGHT is ON/OFF");
  endfunction
endclass

module tb;
  remote device[3];
  initial begin
    device[0]=fan::new();
    device[1]=ac::new();
    device[2]=light::new();
    foreach(device[i]) device[i].presspower();
  end
endmodule


//output:
# KERNEL: Fan is ON/OFF
# KERNEL: default : No Device is Connected
# KERNEL: LIGHT is ON/OFF



//this problem is overcome by using absctract class and pure virtual function , which is mandotary to implement the method in sub classess, if not it will give error
virtual class remote;
 pure virtual function void presspower();
    
endclass
 
class fan extends remote;
  function void presspower();
    $display("Fan is ON/OFF");
  endfunction
endclass

class ac extends remote;
//   function void presspower();
//     $display("AC is ON/OFF");
//   endfunction
endclass

class light extends remote;
  function void presspower();
    $display("LIGHT is ON/OFF");
  endfunction
endclass

module tb;
  remote device[3];
  initial begin
    device[0]=fan::new();
    device[1]=ac::new();
    device[2]=light::new();
    foreach(device[i]) device[i].presspower();
  end
endmodule


//same code with abstract class and pure virtual function , which gives error
virtual class remote;
 pure virtual function void presspower();
    
endclass
 
class fan extends remote;
  function void presspower();
    $display("Fan is ON/OFF");
  endfunction
endclass

class ac extends remote;
//   function void presspower();
//     $display("AC is ON/OFF");
//   endfunction
endclass

class light extends remote;
  function void presspower();
    $display("LIGHT is ON/OFF");
  endfunction
endclass

module tb;
  remote device[3];
  initial begin
    device[0]=fan::new();
    device[1]=ac::new();
    device[2]=light::new();
    foreach(device[i]) device[i].presspower();
  end
endmodule

//output:
ERROR VCP2938 "Cannot declare class ac as non abstract class due to not implemented pure virtual methods:" "testbench.sv" 12  9
ERROR VCP2941 "... see pure virtual method: presspower declaration." "testbench.sv" 2  39


//with asbctract and working
virtual class remote;
 pure virtual function void presspower();
    
endclass
 
class fan extends remote;
  function void presspower();
    $display("Fan is ON/OFF");
  endfunction
endclass

class ac extends remote;
  function void presspower();
    $display("AC is ON/OFF");
  endfunction
endclass

class light extends remote;
  function void presspower();
    $display("LIGHT is ON/OFF");
  endfunction
endclass

module tb;
  remote device[3];
  initial begin
    device[0]=fan::new();
    device[1]=ac::new();
    device[2]=light::new();
    foreach(device[i]) device[i].presspower();
  end
endmodule

//output:
# KERNEL: Fan is ON/OFF
# KERNEL: AC is ON/OFF
# KERNEL: LIGHT is ON/OFF

//after dhusera holidays
//unique if condition when more than 1 statement is true it will show the error

module tb;
  initial begin
    int a=5;
    int b=10;
   unique if(a==b)
      $display("a is equal to b");
    else if(a<b)
      $display("a is less than b");
    else if(a<100)
      $display("a is less than 100");
      else
        $display("exit conditon");
    end
endmodule

//output 
# KERNEL: a is less than b
# ASSERT: Error: Assertion 'unique_if_1' FAILED at time: 0, testbench.sv(7), scope: tb.0unnblk. Two or more conditions are true simultaneously: a<b (line: 9), a<100. (line: 11)


//unique if when no statements are true and without else conditon
module tb;
  initial begin
    int a=5;
    int b=10;
   unique if(a==b)
      $display("a is equal to b");
    else if(a>b)
      $display("a is less than b");
    else if(a>100)
      $display("a is less than 100");
//       else
//         $display("exit conditon");
    end
endmodule

//output
# KERNEL: Warning: unique_if_1: testbench.sv(5), scope: tb.0unnblk, time: 0. None of 'if' branches matched.


//unique0  when two or more  statements are true it will not show the error
module tb;
  initial begin
    int a=5;
    int b=10;
   unique0   if(a==b)
      $display("a is equal to b");
    else if(a<b)
      $display("a is less than b");
    else if(a<100)
      $display("a is less than 100");
      else
        $display("exit conditon");
    end
endmodule

//output
# ASSERT: Error: Assertion 'unique_if_1' FAILED at time: 0, testbench.sv(5), scope: tb.0unnblk. Two or more conditions are true simultaneously: a<b (line: 7), a<100. (line: 9

//unique0 when no statements are true and without else conditon it will not show the warning
module tb;
  initial begin
    int a=5;
    int b=10;
   unique0   if(a==b)
      $display("a is equal to b");
    else if(a>b)
      $display("a is less than b");
    else if(a>100)
      $display("a is less than 100");
      
    end
endmodule

//output
no output no warning

//priority if when two or more  statements are true it will not show the error , and execute the first true statement only
module tb;
  initial begin
    int a=5;
    int b=10;
  priority  if(a==b)
      $display("a is equal to b");
    else if(a<b)
      $display("a is less than b");
    else if(a<100)
      $display("a is less than 100");
      else
        $display("exit conditon");
    end
endmodule

//output
# KERNEL: a is less than b

//priority if when no statements are true and without else conditon it will  show the warning
module tb;
  initial begin
    int a=5;
    int b=10;
  priority  if(a==b)
      $display("a is equal to b");
    else if(a>b)
      $display("a is less than b");
    else if(a>100)
      $display("a is less than 100");
      
    end
endmodule

//output
# KERNEL: Warning: priority_if_1: testbench.sv(5), scope: tb.0unnblk, time: 0. None of 'if' branches matched.


//difference between alaways@* and always_comb
module tb;
  int a,b,c,x,y;
  always@(a)
    x=a^b^c;
  always_comb
    y=a^b^c;
  initial begin
        a=0;b=0;c=0;
    #5; a=0;b=0;c=1;
    #5; a=0;b=1;c=0;
    #5; a=0;b=1;c=1;
    #5; a=1;b=0;c=0;
    #5; a=1;b=0;c=1;
  end
  initial begin
    $monitor("time=%0t a=%0b,b=%0b,c=%0b,x=%0b,y=%0b",$time,a,b,c,x,y);
  end
endmodule

//output
# KERNEL: time=0 a=0,b=0,c=0,x=0,y=0
# KERNEL: time=5 a=0,b=0,c=1,x=0,y=1
# KERNEL: time=10 a=0,b=1,c=0,x=0,y=1
# KERNEL: time=15 a=0,b=1,c=1,x=0,y=0
# KERNEL: time=20 a=1,b=0,c=0,x=1,y=1
# KERNEL: time=25 a=1,b=0,c=1,x=1,y=0

//$rose and $fell code
module door_controller (
  input logic  clk,
  input logic  rst_n,
  input logic  sensor_mat,
   output logic  door_open
);
  always_ff@ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      door_open<=1'b0;
    end
      else if ($rose(sensor_mat)) begin
       door_open<=1'b1; 
      end
        else if ($fell(sensor_mat)) begin
       door_open<=1'b0; 
        end
      end
endmodule
module tb;
  logic clk,rst_n, sensor_mat, door_open;
 
  door_controller dut (.clk(clk),.rst_n(rst_n),.sensor_mat(sensor_mat),.door_open (door_open));
  //clk=0;
  initial clk=0;
  always #5 clk=~clk;
  
  initial begin
     clk=0;
     rst_n=0;
     sensor_mat=0; 
     #10 rst_n=1;
     #10 sensor_mat=1;
     #10 sensor_mat=0;
     #10 sensor_mat=1;
     #10 sensor_mat=0;
     #100; $finish;
  end
  always@(door_open)
    $display("sensor_mat=%0b,door_open=%0b",sensor_mat,door_open);
endmodule

//output
# KERNEL: sensor_mat=0,door_open=0
# KERNEL: sensor_mat=1,door_open=1
# KERNEL: sensor_mat=0,door_open=0
# KERNEL: sensor_mat=1,door_open=1
# KERNEL: sensor_mat=0,door_open=0

//modports
interface college_if;
  logic [7:0] classroom_math;
  logic [7:0] classroom_physics;
  logic [7:0] classroom_lab;
  
  modport teacher (output classroom_math, output classroom_physics, output classroom_lab);
  
  modport student (input classroom_math, input classroom_physics, input classroom_lab);
  
  modport principal (input classroom_math, input classroom_physics, output classroom_lab);
endinterface  

//tb
module teacher_module(college_if.teacher c_if);
  initial begin
    c_if.classroom_math     = 8'd85;  
    c_if.classroom_physics  = 8'd90;  
    c_if.classroom_lab      = 8'd95;   
    #10;
    $display("T=%0t,Teacher evaluates: Math=%0d, Physics=%0d , Lab=%0d",$time, c_if.classroom_math, c_if.classroom_physics,c_if.classroom_lab);
    
  end
endmodule

module principal_module(college_if.principal c_if);
  initial begin
    #15;
    $display("T=%0t,Principal checks: Math=%0d, Physics=%0d , Lab=%0d",$time, c_if.classroom_math, c_if.classroom_physics,c_if.classroom_lab);
    c_if.classroom_lab = 8'd99; 
    $display("T=%0t,Principal modifed: Math=%0d, Physics=%0d , Lab=%0d",$time, c_if.classroom_math, c_if.classroom_physics,c_if.classroom_lab);
  end
endmodule

module student_module(college_if.student c_if);
  initial begin
    #20;
    $display("T=%0t,Student learns: Math=%0d, Physics=%0d, Lab=%0d",$time,
             c_if.classroom_math, c_if.classroom_physics, c_if.classroom_lab);
  end
endmodule

module testbench;
  college_if c_if();

  teacher_module   T1 (c_if);
  principal_module P1 (c_if);
  student_module   S1 (c_if);

  initial begin
//     $dumpfile("college_if_tb.vcd");
//     $dumpvars(0, testbench);
    #30;
    $finish;
  end
endmodule
//output
# KERNEL: T=10,Teacher evaluates: Math=85, Physics=90 , Lab=95
# KERNEL: T=15,Principal checks: Math=85, Physics=90 , Lab=95
# KERNEL: T=15,Principal modifed: Math=85, Physics=90 , Lab=99
# KERNEL: T=20,Student learns: Math=85, Physics=90, Lab=99

//alias keyword
//alias keyword is bidirectional , when compared to the unidirectional assign statement
module tb;
 wire  a,b,c;
  alias a=b;
  alias c=b;
  assign c=1'b1;
  initial begin
    #1;
    $display("a=%0b,b=%0b c=%0b",a,b,c);
  end
endmodule

//output
# KERNEL: a=1,b=1 c=1

//lifo code using queue

class lifo;
  int intQ[$];
  function void put(int a);
    intQ.push_back(a);
  endfunction
  function void get(output int a);
   a=intQ.pop_back();
  endfunction
endclass

module tb;
  lifo h_lifo=new();
  int num;
  initial begin
    repeat(5)
      begin
        num=$urandom_range(10,100);
        h_lifo.put(num);
        $display("put=%0d",num);
      end
    repeat(5)
      begin
        h_lifo.get(num);
        $display("get=%0d",num);
      end
  end
    endmodule
        
  //output:
  # KERNEL: put=33
# KERNEL: put=92
# KERNEL: put=89
# KERNEL: put=21
# KERNEL: put=24
# KERNEL: get=24
# KERNEL: get=21
# KERNEL: get=89
# KERNEL: get=92
# KERNEL: get=33


//fifo code using queue
class fifo;
  int intQ[$];
  function void put(int a);
    intQ.push_back(a);
  endfunction
  function void get(output int a);
   a=intQ.pop_front();
  endfunction
endclass

module tb;
  fifo h_fifo=new();
  int num;
  initial begin
    repeat(5)
      begin
        num=$urandom_range(10,100);
        h_fifo.put(num);
        $display("put=%0d",num);
      end
    repeat(5)
      begin
        h_fifo.get(num);
        $display("get=%0d",num);
      end
  end
    endmodule
        
//output
# KERNEL: put=33
# KERNEL: put=92
# KERNEL: put=89
# KERNEL: put=21
# KERNEL: put=24
# KERNEL: get=33
# KERNEL: get=92
# KERNEL: get=89
# KERNEL: get=21
# KERNEL: get=24


//lifo and fifo using parametrization
`define lifo 1
`define fifo 0
class lifo_fifo # (bit ds_type=`lifo);
  int intQ[$];
  function void put (int a);
    intQ.push_back(a);
  endfunction
  function void get (output int a);
    if(ds_type == `lifo ) a= intQ.pop_back();
    if(ds_type == `fifo ) a= intQ.pop_front();
  endfunction
endclass

module tb;
  lifo_fifo #(.ds_type(`lifo)) lifo_i=new();
  int num;
  initial begin
    repeat (5) begin
      num=$urandom_range (100,600);
      lifo_i.put(num);
      $display("Putting num=%0d", num);
    end
    repeat (5) begin
      //num=$urandom_range (100,600);
      lifo_i.get(num);
      $display("Getting num=%0d", num);
    end
    
  end
endmodule

//output for lifo
# KERNEL: Putting num=531
# KERNEL: Putting num=437
# KERNEL: Putting num=119
# KERNEL: Putting num=286
# KERNEL: Putting num=136
# KERNEL: Getting num=136
# KERNEL: Getting num=286
# KERNEL: Getting num=119
# KERNEL: Getting num=437
# KERNEL: Getting num=531


//output for fifo
# KERNEL: Putting num=531   
# KERNEL: Putting num=437
# KERNEL: Putting num=119
# KERNEL: Putting num=286
# KERNEL: Putting num=136
# KERNEL: Getting num=531
# KERNEL: Getting num=437
# KERNEL: Getting num=119
# KERNEL: Getting num=286
# KERNEL: Getting num=136

  
//inside constraint 
class sample;
  rand int x;//rand bit[31:0]x;
  constraint c1 {x inside{[20:35]};}
endclass

module tb;
  sample s;
  initial begin
    s=new();
    repeat(10)begin
      assert(s.randomize());
      $display("x=%0d",s.x);
    end
  end
endmodule
  
//output
# KERNEL: x=22
# KERNEL: x=26
# KERNEL: x=34
# KERNEL: x=29
# KERNEL: x=27
# KERNEL: x=33
# KERNEL: x=33
# KERNEL: x=30
# KERNEL: x=22
# KERNEL: x=24
  
//inside constraint with different ways
`define starting_range 70
`define ending_range 90

class sample # (int p1=100,int p2=110);
  rand bit[7:0]a;
  rand bit[7:0]b;
  rand bit[7:0]c;
  rand bit[7:0]d;
  rand bit[7:0]e;
  constraint c1{a inside {[10:20]};}
  constraint c2{b inside {21,22};}
  constraint c3{c inside {[10:20],21,22};}
  constraint c4{d inside {[`starting_range:`ending_range]};}
  constraint c5{e inside {[p1:p2]};}
endclass

module tb;
  sample s;
  initial begin
    s=new();
    repeat(5)begin
    assert(s.randomize());
      $display("a=%0d,b=%0d,c=%0d,d=%0d,e=%0d",s.a,s.b,s.c,s.d,s.e);
    end
  end
endmodule

//output
# KERNEL: a=17,b=21,c=14,d=76,e=102
# KERNEL: a=12,b=21,c=18,d=90,e=106
# KERNEL: a=18,b=21,c=16,d=80,e=101
# KERNEL: a=15,b=22,c=17,d=89,e=106
# KERNEL: a=13,b=22,c=17,d=83,e=110


//dist constraint
class sample;
  rand int a;
  constraint cd{a dist {[100:290]:/2,400:/3,600:/5};}
  //constraint cd{a dist {[100:290]:=2,400:=3,600:=5};}
endclass

module tb;
  sample s=new();
  initial begin
    repeat(10)begin
      assert(s.randomize());
      $display("a=%0d",s.a);
    end
  end
endmodule

//output
# KERNEL: a=400
# KERNEL: a=600
# KERNEL: a=600
# KERNEL: a=600
# KERNEL: a=600
# KERNEL: a=600
# KERNEL: a=600
# KERNEL: a=600
# KERNEL: a=267
# KERNEL: a=265


//unique constraint for static array
// Code your testbench here
// or browse Examples
class sample;
  rand bit[2:0] a;
  constraint ca { unique {a};}
endclass

module tb;
  sample s=new();
  initial begin
    repeat(5) begin
      assert(s.randomize());
      $display("a=%0d",s.a);
    end
  end
endmodule

//output
# KERNEL: a=5
# KERNEL: a=2
# KERNEL: a=7
# KERNEL: a=1
# KERNEL: a=4 


//unique constraint for dynamic array
class sample;
  rand bit[7:0]arr [];
  constraint cu{unique {arr};arr.size==5;};
endclass

module tb;
  
  //int i=0;
  sample s=new();
  initial begin
    //repeat(5)begin
     assert(s.randomize());
    foreach(s.arr[i])
      $display("a[%0d]=%0d",i,s.arr[i]); 
  end
endmodule

//output
# KERNEL: a[0]=23
# KERNEL: a[1]=45
# KERNEL: a[2]=67
# KERNEL: a[3]=89
# KERNEL: a[4]=12


//unique constraint for associative array 
class sample;
  rand bit [7:0] arr [int]; 
  constraint cu {unique {arr};}
endclass

module tb;
  int i=0;
  sample s=new();
  initial begin
      s.arr[10]=0;
      s.arr[20]=0;
      s.arr[30]=0;
      s.arr[40]=0;
      s.arr[50]=0;
    //repeat(5)begin  
     assert(s.randomize());
    foreach(s.arr[i])
      $display("a[%0d]=%0d",i,s.arr[i]); 
  end
endmodule

//output
# KERNEL: a[10]=23
# KERNEL: a[20]=45
# KERNEL: a[30]=67
# KERNEL: a[40]=89
# KERNEL: a[50]=12

//soft constraint
//soft constraint 
class sample;
  rand bit[7:0]t;
  constraint c1{soft {t==10};}
endclass
module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    $display("t=%0d",s.t);
    assert(s.randomize() with {t==11;});
    $display("t=%0d",s.t);
  end
endmodule

//output
# KERNEL: t=10
# KERNEL: t=11


//same code without soft keyword
# KERNEL: t=10
# RCKERNEL: Warning: RC_0024 testbench.sv(11): Randomization failed. The condition of randomize call cannot be satisfied.
# RCKERNEL: Info: RC_0109 testbench.sv(11): ... after reduction s.t to 10
# RCKERNEL: Info: RC_0103 testbench.sv(11): ... the following condition cannot be met: (8'(10)==11)
# RCKERNEL: Info: RC_1007 testbench.sv(2): ... see class 'sample' declaration.
# ASSERT: Error: ASRT_0301 testbench.sv(11): Immediate assert condition (s.randomize(...)) FAILED at time: 0ns, scope: tb
# KERNEL: t=10


//solve before constarint 
//solve before constraint
class sample;
  rand bit[7:0]a,b;
  constraint c1 {solve a before b;}
  constraint c2 {b==a+15;}
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    $display("a=%0d b=%0d",s.a,s.b);
  end
endmodule

//output
# KERNEL: a=51 b=66


//same code first b then a
//solve before constraint
class sample;
  rand bit[7:0]a,b;
  constraint c1 {solve b before a;}
  constraint c2 {b==a+15;}
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    $display("a=%0d b=%0d",s.a,s.b);
  end
endmodule

//output
# KERNEL: a=24 b=39

//another example for solve before constraint
//solve before constraint
class sample;
  rand bit[7:0]a,b;
  constraint c1 {solve a before b;}
  constraint c2 {b inside {[10:a]};}
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    $display("a=%0d b=%0d",s.a,s.b);
  end
endmodule

//output
# KERNEL: a=85 b=34


//conditional constarint without without with keyword in module tb;
//conditional constraint
class sample;
  rand bit [7:0]a,b;
  constraint c1 {
    if(a==1)
      b==25;
    else
      b==15;
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    $display("a=%0d b=%0d",s.a,s.b);
  end
endmodule
  
  //output
  # KERNEL: a=71 b=15


//conditional constraint with with keyword in module tb;
//conditional constraint
class sample;
  rand bit [7:0]a,b;
  constraint c1 {
    if(a==1)
      b==25;
    else
      b==15;
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize() with {a==1;});
    $display("a=%0d b=%0d",s.a,s.b);
  end
endmodule
  
//output
# KERNEL: a=1 b=25


//conditional constraint with with keyword in module tb;
//conditional constraint
class sample;
  rand bit [7:0]a,b;
  constraint c1 {
    if(a==1)
      b==25;
    else
      b==15;
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize() with {a==1;});
    $display("a=%0d b=%0d",s.a,s.b);
    assert(s.randomize() with {a==0;});
    $display("a=%0d b=%0d",s.a,s.b);
  end
endmodule
  
//output
# KERNEL: a=1 b=25
# KERNEL: a=0 b=15

//conditonal constraint with implication operator
//conditional constraint
class sample;
  rand bit [7:0]a,b;
  constraint c1 {
    a==1 -> b==25;
    a==0 -> b==15;
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize() with {a==1;});
    $display("a=%0d b=%0d",s.a,s.b);
    assert(s.randomize() with {a==0;});
    $display("a=%0d b=%0d",s.a,s.b);
  end
endmodule
  
//output
# KERNEL: a=1 b=25
# KERNEL: a=0 b=15

//mode of rand, rand_mode(1) and rand_mode(0)
class sample;
  rand bit[7:0]a,b,c;
  constraint c1{a+b+c==80;}
endclass

module tb;
  sample s=new();
  initial begin
    s.a=10;
    s.a.rand_mode(0); // a is disabled
    assert(s.randomize());
    $display("a=%0d b=%0d c=%0d sum=%0d",s.a,s.b,s.c,{s.a+s.b+s.c});
    s.a.rand_mode(1); // a is enabled
    assert(s.randomize());
    $display("a=%0d b=%0d c=%0d sum=%0d",s.a,s.b,s.c,{s.a+s.b+s.c});
    s.rand_mode(0); // complete sample class s is disabled
    assert(s.randomize());
    $display("a=%0d b=%0d c=%0d sum=%0d",s.a,s.b,s.c,{s.a+s.b+s.c});
    s.rand_mode(1); // complete sample class s is enabled
    assert(s.randomize());
    $display("a=%0d b=%0d c=%0d sum=%0d",s.a,s.b,s.c,{s.a+s.b+s.c});
  end
endmodule

//output
# KERNEL: a=10 b=35 c=35 sum=80
# KERNEL: a=24 b=28 c=28 sum=80
# KERNEL: a=24 b=28 c=28 sum=80
# KERNEL: a=20 b=30 c=30 sum=80


//constraint_mode(0) and constraint_mode(1)
class sample;
  rand bit [7:0]a,b;
  constraint c1{a inside {[40:60]};}
  constraint c2{b inside {10,20,30};}
endclass
module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    $display("a=%0d b=%0d",s.a,s.b);
    s.c1.constraint_mode(0);//c1 constraint disable other than c1 values are pritnting
    assert(s.randomize());
    $display("a=%0d b=%0d",s.a,s.b);
    s.c1.constraint_mode(1); //c1 is enabled
    assert(s.randomize());
    $display("a=%0d b=%0d",s.a,s.b);
    s.c2.constraint_mode(0); //c2 is disabled
    assert(s.randomize());
    $display("a=%0d b=%0d",s.a,s.b);
  end
endmodule


//output
# KERNEL: a=47 b=20
# KERNEL: a=160 b=10
# KERNEL: a=48 b=20
# KERNEL: a=41 b=74



//consider a 4 bit dynamic array in such a way that the size of the given dynamic array varies from 10 to 15,and store even values in odd locations and odd values in even locations
class sample;
  rand bit [3:0] a[];

  constraint c1 {
    a.size inside {[10:15]};
    foreach (a[i]) {
      if (i%2==0)
        a[i]%2==1; 
      else
        a[i]%2==0;
    }
  }
endclass


module tb;
  sample s=new();
  initial begin
    repeat (5) begin
      assert (s.randomize())
      foreach (s.a[i])
        $display("a[%0d]=%0d", i, s.a[i]);
    end
  end
endmodule

//output
# KERNEL: a[1]=2
# KERNEL: a[2]=3
# KERNEL: a[3]=8
# KERNEL: a[4]=11
# KERNEL: a[5]=12
# KERNEL: a[6]=1
# KERNEL: a[7]=8
# KERNEL: a[8]=5
# KERNEL: a[9]=0


//consider a 4bit dynamic array with a size of 10 and store the unique values into the given dynamic array without unique keyword

class sample;
  rand bit[3:0]a[];
  int i,j;
  constraint c1 {a.size==10;
                 foreach(a[i])
                   foreach(a[j])
                     if(i!=j)  a[i]!=a[j];
                }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    foreach(s.a[i])
      $display("a[%0d]=%0d",i,s.a[i]);
  end
endmodule
         
//output:

  # KERNEL: a[0]=7
# KERNEL: a[1]=8
# KERNEL: a[2]=0
# KERNEL: a[3]=2
# KERNEL: a[4]=4
# KERNEL: a[5]=5
# KERNEL: a[6]=12
# KERNEL: a[7]=13
# KERNEL: a[8]=9
# KERNEL: a[9]=1


//write a constraint for 4 bit dynamic array with soze of 10 and store the random values into the given dynamic array in assceding orde

class sample;
  rand bit[3:0]a[];
  int i;
  constraint c1 {a.size==10;
                 foreach(a[i])
                   if(i>=0)
                     a[i]>a[i-1];
                }
endclass

module tb;
  sample s=new();
  initial begin
    
    assert(s.randomize());
    foreach(s.a[i])
      $display("a[%0d]=%0d",i,s.a[i]);
  end
endmodule
                 
//output
# KERNEL: a[0]=1
# KERNEL: a[1]=3
# KERNEL: a[2]=5
# KERNEL: a[3]=6
# KERNEL: a[4]=9
# KERNEL: a[5]=10
# KERNEL: a[6]=11
# KERNEL: a[7]=12
# KERNEL: a[8]=13
# KERNEL: a[9]=14


//write a constraint for 4 bit dynamic array with soze of 10 and store the random values into the given dynamic array in desendeding orde

class sample;
  rand bit[3:0]a[];
  int i;
  constraint c1 {a.size==10;
                 foreach(a[i])
                   if(i>0)
                     a[i]<a[i-1];
                }
endclass

module tb;
  sample s=new();
  initial begin
    
    assert(s.randomize());
    foreach(s.a[i])
      $display("a[%0d]=%0d",i,s.a[i]);
  end
endmodule

//output
# KERNEL: a[0]=14
# KERNEL: a[1]=13
# KERNEL: a[2]=11
# KERNEL: a[3]=9
# KERNEL: a[4]=8
# KERNEL: a[5]=5
# KERNEL: a[6]=4
# KERNEL: a[7]=2
# KERNEL: a[8]=1
# KERNEL: a[9]=0

//fibbanoci series

class sample;
  rand bit[7:0]a[];
  int i;
  constraint c1 {a.size==12;
                 foreach(a[i])
                   if(i==0) a[i]==0;
                 else if(i==1) a[i]==1;
                 else
                   a[i]==a[i-2]+a[i-1];
                   
                }
endclass

module tb;
  sample s=new();
  initial begin
    
    assert(s.randomize());
    foreach(s.a[i])
      $write("%0d ",s.a[i]);
  end
endmodule

//output
# KERNEL: 0 1 1 2 3 5 8 13 21 34 55 89 


//factorial of a given number 
class sample;
  rand bit[7:0]a[];
  int i;
  constraint c1 {
    a.size==5;
    a[0]==1;
    foreach(a[i])
      if(i>0) a[i]==a[i-1]*(i+1);  
  }
endclass

module tb;
  sample s=new();
  initial begin
    assert(s.randomize());
    foreach(s.a[i])
      $write("%0d ",s.a[i]);
  end
endmodule

//output
# KERNEL: 1 2 6 24 120 






//write a constraint for below scenario for a is lessthan 20 than b value should generate form 10-30 and if b is greater than 20 the value should be generated 30 to 50 


//writer a constraint for 16 bit address which should contain 8th bit as 1 

//write a constrint for 16 bit address to generate power of 2
//write a constarint for apb slave select signal 

// declare a queue fill with 20 random values between 300 to 500 with no repatation 


//16/10/2025
// Code your design here
//Palindrome number

class sample;
  rand bit [2:0]a[];
  constraint c1{
    a.size inside{5};
    foreach(a[i])
      a[i-1]==a[a.size-i];
  }
  
endclass

module tb;
  sample s=new();
  initial begin
    repeat(10)begin
      assert(s.randomize());
      $display("%0p",s.a);
    end
  end
endmodule

//output
# KERNEL: 2 2 7 2 2
# KERNEL: 4 2 1 2 4
# KERNEL: 5 1 0 1 5
# KERNEL: 0 3 0 3 0
# KERNEL: 2 0 5 0 2
# KERNEL: 3 5 6 5 3
# KERNEL: 4 5 1 5 4
# KERNEL: 0 7 6 7 0
# KERNEL: 6 0 0 0 6
# KERNEL: 4 3 0 3 4


//another way to write the above code
//only logic 
// Code your testbench here
// or browse Examples
//palindrome 
class sample;
  rand bit[2:0]a[];
  constraint c1 {
    a.size==5;
    foreach(a[i])
      a[i]==a[(a.size-1)-i];
  }
endclass

module tb;
  sample s=new();
  initial begin
    repeat(10) begin
    assert(s.randomize());
    foreach(s.a[i])
      $write("%0d ",s.a[i]);
      $display("\n");
  end
  end
endmodule
//output
# KERNEL: 2 2 7 2 2 
# KERNEL: 
# KERNEL: 4 2 1 2 4 
# KERNEL: 
# KERNEL: 5 1 0 1 5 
# KERNEL: 
# KERNEL: 0 3 0 3 0 
# KERNEL: 
# KERNEL: 2 0 5 0 2 
# KERNEL: 
# KERNEL: 3 5 6 5 3 
# KERNEL: 
# KERNEL: 4 5 1 5 4 
# KERNEL: 
# KERNEL: 0 7 6 7 0 
# KERNEL: 
# KERNEL: 6 0 0 0 6 
# KERNEL: 
# KERNEL: 4 3 0 3 4 
# KERNEL: 

//another way to write the above code
//palindrome
//Palindrome number

class sample;
  rand bit [2:0]a[];
  constraint c1{
    a.size inside{5};
    foreach(a[i])
      if(i>0 && i<=a.size/2) a[i-1]==a[a.size-i];
  }
  
endclass

module tb;
  sample s=new();
  initial begin
    repeat(10)begin
      assert(s.randomize());
      $display("%0p",s.a);
    end
  end
endmodule
//output
# KERNEL: 7 2 1 2 7
# KERNEL: 0 2 6 2 0
# KERNEL: 7 6 0 6 7
# KERNEL: 0 1 4 1 0
# KERNEL: 5 6 7 6 5
# KERNEL: 1 4 5 4 1
# KERNEL: 3 5 5 5 3
# KERNEL: 3 3 2 3 3
# KERNEL: 3 2 4 2 3
# KERNEL: 3 7 5 7 3












