# 32bit-RiscV-implementation

This repository contains a 32-bit RISC-V implementation written in Verilog. The implementation includes support for the following instructions:

## R-type Instructions
- `add rd, rs1, rs2`: Performs addition and stores the result in `rd` (rd = rs1 + rs2)
- `sub rd, rs1, rs2`: Performs subtraction and stores the result in `rd` (rd = rs1 - rs2)
- `and rd, rs1, rs2`: Performs bitwise AND and stores the result in `rd` (rd = rs1 & rs2)
- `or rd, rs1, rs2`: Performs bitwise OR and stores the result in `rd` (rd = rs1 | rs2)

## I-type Instructions
- `addi rd, rs1, imm`: Performs addition with an immediate value and stores the result in `rd` (rd = rs1 + imm)
- `lw rd, imm(rs1)`: Loads a word from memory and stores it in `rd` (rd = Memory[rs1 + imm])
- `lb rd, imm(rs1)`: Loads a byte from memory and stores it in `rd` (rd = Memory[rs1 + imm])

## S-type Instructions
- `sw rs2, imm(rs1)`: Stores a word into memory (Memory[rs1 + imm] = rs2)
- `sb rs2, imm(rs1)`: Stores a byte into memory (Memory[rs1 + imm] = rs2[7:0])

## SB-type Instructions
- `beq rs1, rs2, imm`: Branches if the values in `rs1` and `rs2` are equal. Updates the program counter (PC) accordingly (PC = (rs1 == rs2) ? PC + imm : PC + 4)
- `blt rs1, rs2, imm`: Branches if the value in `rs1` is less than the value in `rs2`. Updates the program counter (PC) accordingly (PC = (rs1 < rs2) ? PC + imm : PC + 4)
- `bge rs1, rs2, imm`: Branches if the value in `rs1` is greater than or equal to the value in `rs2`. Updates the program counter (PC) accordingly (PC = (rs1 >= rs2) ? PC + imm : PC + 4)

## UJ-type Instructions
- `jal rd, imm`: Performs a jump and link operation. Stores the address of the next instruction in `rd` and updates the program counter (PC = PC + imm)

## I-type (Jump Register) Instructions
- `jalr rd, rs1, imm`: Performs a jump and link register operation. Stores the address of the next instruction in `rd` and updates the program counter (PC = (rs1 + imm) & ~1)

# System Architecture
All data pertaining to how the system works

### System Hardware Design
![Design](./Images/Design.png)

### Instruction Format
![Format](./Images/Instruction_format.png)

### Instruction Encoding
![Encoding](./Images/Instruction_encoding.png)

### Control Unit
![Control](./Images/Control.png)
