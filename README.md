# System-Verilog-with-OOPs: Foundational Verification Principles

This repository contains a comprehensive collection of **SystemVerilog** code examples focusing exclusively on **Object-Oriented Programming (OOP) principles** and the creation of essential, modular verification components.

This project demonstrates how to build a robust, scalable testbench environment using pure SystemVerilog classes and constructs, **without relying on the UVM framework.**

All examples are self-contained and include the SystemVerilog code, a brief description, and the corresponding simulation output for immediate reference.

---

## 🚀 Key Topics and Concepts

The examples are logically grouped to showcase fundamental OOP theory applied directly to hardware verification needs.

### 1. Core SystemVerilog OOP Fundamentals

| Topic | Description |
| :--- | :--- |
| **Classes & Objects** | Basic class structure, object handles, and object creation (`new()`). |
| **Custom Constructors** | Defining user-defined constructors and using the **`this`** keyword for member initialization. |
| **Access Control** | Demonstrations of **`local`** (restricted to the class) and **`protected`** (restricted to the class and its derivatives) variable scoping. |
| **Inheritance** | Implementing single and multi-level class hierarchy for code extension. |
| **Method Overriding & `super`** | Overriding parent class methods in the child class and using the **`super`** keyword to explicitly call the parent's implementation. |
| **Polymorphism** | Runtime method resolution using the **`virtual`** keyword on methods. |
| **Abstract Classes** | Using **`virtual class`** to define an un-instantiable base class, and **`pure virtual function`** to enforce method implementation in all derived classes. |
| **Static Properties** | Using **`static`** class members, which are shared across all objects, and accessing them via the **Scope Resolution Operator (`::`)**. |
| **Copying Mechanisms** | Detailed examples comparing **Object Copying** (copy-by-handle), **Shallow Copy** (`new src_obj`), and **Deep Copy** (manual recursive copying) for managing memory with nested objects. |
| **Casting** | Safe type conversion between class handles using the **`$cast`** system function/task for upcasting and downcasting. |

### 2. Modular Testbench Architecture (Generator/Driver/Mailbox)

This section demonstrates the modular, component-based approach to testbench construction—the architectural foundation for methodologies like UVM.

| Component Demonstrated | Design Under Test (DUT) |
| :--- | :--- |
| **Transaction Class** | Defining data packets with **`rand`** variables and **`constraint`** blocks for randomization (e.g., APB Transaction). |
| **Generator** | Creates transaction objects, randomizes them, and sends them to the Driver. |
| **Driver** | Receives transaction objects and drives stimulus onto the virtual interface connected to the DUT. |
| **Mailbox** | Used as the standard **Inter-Process Communication (IPC)** channel between the Generator and Driver. |
| **DUT Examples** | **2-to-1 MUX**, **Half/Full Adder**, **Half/Full Subtractor**. |

### 3. Concurrency and Synchronization

| Topic | Description |
| :--- | :--- |
| **Concurrency Control** | Use of **`fork/join`**, **`fork/join_any`**, and **`fork/join_none`** to manage parallel threads in the testbench. |
| **Task Argument Passing** | Practical differences between **Pass-by-Value** (`input`) and **Pass-by-Reference** (`ref`, `const ref`) in tasks. |
| **Events** | Synchronization using the **`event`** construct (e.g., `->done; wait(done.triggered)`). |
| **Interfaces & Modports** | Using **`interface`** to bundle signals and **`modport`** to define directional access (e.g., `teacher` vs. `student` access). |

### 4. Advanced Logic & Control

| Topic | Description |
| :--- | :--- |
| **Procedural Blocks** | Comparison of sensitivity list usage with `always@*` and the explicit **`always_comb`**. |
| **Signal Edge Detection** | Using sequential logic constructs like **`$rose`** and **`$fell`** within an `always_ff` block. |
| **Conditional Assertions** | Use of **`unique if`**, **`unique0 if`**, and **`priority if`** to formally verify that combinational logic implements desired priority or exclusivity. |

---

## 💡 How to Use This Resource

This repository is designed as a direct reference and learning tool:

1.  **Code is in `source.sv`**: All complete examples are located within the single, heavily commented file.
2.  **Self-Contained Examples**: Each code snippet is complete with its testbench structure, making it easy to copy and paste into any SystemVerilog simulator (e.g., EDA Playground, QuestaSim, VCS) to observe the output directly.
3.  **Focus on Output**: The comments include the exact simulation output, allowing you to confirm correct behavior and fully grasp the underlying SystemVerilog mechanism demonstrated.

This is an ideal repository for learning and mastering the core OOP concepts that underpin all advanced SystemVerilog verification.
