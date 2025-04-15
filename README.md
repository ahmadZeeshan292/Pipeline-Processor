# Pipelined Processor with Floating-Point Arithmetic

## Overview

This project implements a **pipelined processor** based on the **Von Neumann architecture**. It features a **4-stage pipeline** capable of executing **20 unique instructions** from four categories: `R-type`, `I-type`, `J-type`, and `B-type`. The design also integrates a **Floating-Point Arithmetic Logic Unit (FP ALU)** supporting IEEE-754 compliant operations.

---

## Key Features

- **4-stage pipeline**: Fetch → Decode → Execute → Memory
- **Instruction formats supported**:
  - **R-type**: Register-based (e.g., `add`, `sub`, `mul`, `shift_right`,`Shift_left`,`And`, `Or`, `Slt`)
  - **I-type**: Immediate (e.g., `addi`, `lw`, `sw`)
  - **J-type**: Unconditional jump
  - **B-type**: Conditional branch (e.g., `beq`)
- **Floating-Point ALU**:
  - Supports `add`, `sub`, `mul`, and `div` (IEEE 754 format)
  - Handles special cases: `NaN`, `Infinity`, `Zero`
- **Forwarding Unit** to resolve data hazards
- **Hazard Detection** to avoid pipeline stalls
- **Instruction & Data Memory**
- **Modular Verilog Design**

---

## Pipeline Stages

### 1️⃣ Fetch Stage
- Fetches the next instruction from `inst_rom`.
- Computes `PC + 1`, or jumps/branches to a new address if required.
- Handles pipeline flushing on mispredicted branches or jumps.

### 2️⃣ Decode Stage
- Parses instruction fields: `opcode`, `rs`, `rt`, `rd`, `shamt`, `funct`, etc.
- Generates control signals via the `Control Unit`.
- Reads values from the `Register File`.
- Sign-extends immediate values.
- Calculates potential branch targets.

### 3️⃣ Execute Stage
- ALU or FP ALU performs the operation.
- Supports all arithmetic, logic, and shift operations.
- Floating-point operations handled by `FP_ALU` module.
- Uses the `Forwarding Unit` to resolve data hazards.
- Determines the outcome of branch conditions.

### 4️⃣ Memory Stage
- Accesses `data_mem` for `lw` and `sw` operations.
- Selects between ALU result and memory data for write-back.
- Result is passed to the next instruction via pipeline forwarding.

---

## Floating-Point ALU (FP_ALU)

- IEEE 754 single-precision (32-bit) operations:
  - `FP_Addition_Subtraction`
  - `FP_Multiply`
  - `FP_Divide`
- Handles edge cases:
  - `NaN` (Not a Number)
  - Division by zero → `Infinity`
  - Proper normalization and rounding
- Integrated into the main execution pipeline

---
## Pipeline Architecture Diagram

This diagram illustrates the complete pipelined processor with an integrated Floating Point ALU (FP_ALU).

[Pipeline-Processor](Pipelined_processor_with_Floating_point_ALU)

## 📁 Project Structure

```text
├── inst_rom.v             # Instruction memory
├── register_file.v        # Register file (int + FP regs)
├── data_mem.v             # Data memory
├── ALU.v                  # Integer ALU
├── FP_ALU.v               # Floating-point ALU (add, sub, mul, div)
├── Control_unit.v         # Main control logic
├── ALU_control.v          # ALU operation selector
├── Hazard_control.v       # Detects hazards & stalls pipeline
├── forwarding_unit.v      # Handles data forwarding
├── Pipeline_registers.v   # IF/ID, ID/EX, EX/MEM, MEM/WB pipeline regs
└── Pipelined_Processor.v  # Top module integrating all components

