# System-Verilog-with-OOPs

This repository is a collection of SystemVerilog code examples, focusing heavily on **Object-Oriented Programming (OOP) concepts** and fundamental verification components. It serves as a practical, day-to-day reference for SystemVerilog code snippets, particularly those used in building modern UVM-style testbenches, along with basic digital logic designs.

All examples include the SystemVerilog code, a brief description (often dated), and the corresponding simulation output for immediate verification.

---

## 🚀 Key Topics Covered

The repository is structured to demonstrate the building blocks of modern SystemVerilog verification. The examples are categorized as follows:

### 1. SystemVerilog OOP Fundamentals
| Topic | Description |
| :--- | :--- |
| **Classes & Objects** | Basic class declaration, object creation (`new()`), and accessing members. |
| **Constructors** | Default and **Custom Constructors**, including the use of the `this` keyword to resolve naming conflicts. |
| **Inheritance** | Single and multi-level inheritance, demonstrating code reusability. |
| **Encapsulation/Access Control** | Examples of `local` and `protected` keywords. |
| **Polymorphism** | Runtime polymorphism using **`virtual` functions** and **`virtual` classes (Abstract Classes)**, along with the use of **`pure virtual` functions** to enforce method implementation in derived classes. |
| **Shallow vs. Deep Copy** | Detailed examples illustrating **copy-by-handle** (Object Copying), **Shallow Copy** (`new src_obj`), and **Deep Copy** (manual field-by-field copy) to manage memory for nested objects. |
| **Static Members** | Use of the `static` keyword and the scope resolution operator (`::`). |
| **Casting** | Demonstrations of **Static Casting** (for non-objects) and **Dynamic Casting** (`$cast` function/task) for safe upcasting and downcasting between class handles. |

### 2. Verification Components (UVM-Style)
This section features a structured approach to verification using key components: **Transaction, Generator, Driver, Interface, and Mailbox**.

| Design Under Test (DUT) | Components Demonstrated |
| :--- | :--- |
| **Simple Adder** (`add`) | Basic Generator-Driver-Mailbox flow for a simple combinational design. |
| **Half Adder** (`ha`) | Implementation of the `tx_class`, `generator`, `driver`, `mailbox`, and `virtual interface`. |
| **Half Subtractor** (`hs`) | Complete verification environment using the structured approach. |
| **Full Adder** (`fa`) | Complete verification environment for a 3-input logic block. |
| **Full Subtractor** (`fs`) | Complete verification environment for a 3-input logic block. |
| **2-to-1 Multiplexer** (`mux2to1`) | Complete verification environment. |
| **APB Transaction** (`apb_tx`) | Examples demonstrating **randomization** and **constraints** (`constraint sel_c`) for a bus protocol transaction class. |

### 3. Procedural Blocks and Inter-Process Communication (IPC)
| Topic | Description |
| :--- | :--- |
| **Task Synchronization** | Use of `fork/join`, `fork/join_any`, and `fork/join_none` to control parallel process execution. |
| **Task Arguments** | Demonstrations of **Pass-by-Value** (`input`) and **Pass-by-Reference** (`ref`, `const ref`) and their implications, especially with arrays/vectors. |
| **Events** | Synchronization using `event` variables and `wait(event.triggered)`. |
| **Timing & Concurrency** | Examples of interleaved execution with `$random`, `$urandom`, and different timing delays. |
| **Procedural Logic** | Comparison and use of `always@*` and `always_comb`. |
| **Edge Detection** | Use of `$rose` and `$fell` for sequential logic. |
| **Modports** | Restricting signal directionality for different modules connected to the same `interface`. |

### 4. SystemVerilog Design & Control Structures
| Topic | Description |
| :--- | :--- |
| **Combinational Logic** | Simple adders, subtractors, and multiplexers (DUTs). |
| **Sequential Logic** | D Flip-Flop (`d_ff`) with asynchronous reset. |
| **Interfaces** | Connecting the Testbench to the DUT using `interface` constructs. |
| **Conditional Assertions** | Use of `unique if`, `unique0 if`, and `priority if` to check for ambiguities and priority encoding in combinational logic. |

---

## ⚙️ How to Use This Repository

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/suresh2327/System-Verilog-with-OOPs.git](https://github.com/suresh2327/System-Verilog-with-OOPs.git)
    ```
2.  **Browse `source.sv`:**
    The core of this repository is the single file, `source.sv`, which contains all the commented and segmented examples.
3.  **Run Examples:**
    Each section is designed to be self-contained. You can copy and paste any logical block (e.g., a specific module and its testbench) into your simulator (like QuestaSim, VCS, or an online Verilog playground) to reproduce the exact output shown in the comments.

---

## 💡 Why This Resource?

This collection provides a rapid way to:
* Understand complex OOP concepts in the context of SystemVerilog verification.
* See practical implementations of Generator-Driver components.
* Quickly grab and adapt code for common tasks like task synchronization, randomization, and class deep-copying.
* Verify SystemVerilog behavior with readily available simulation outputs.

---
