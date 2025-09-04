// Class: A class in SystemVerilog is a blueprint that can hold variables (data) and functions/tasks (behavior). It is mainly used in testbenches for verification.
// Object: An object is a real instance of a class, created using the new() keyword. It allows access to the class’s variables and functions.

//code for class and object
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