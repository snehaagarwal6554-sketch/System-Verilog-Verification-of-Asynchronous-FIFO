# SystemVerilog Verification of Asynchronous FIFO

## Overview

This project implements and verifies an **Asynchronous FIFO (First-In-First-Out)** using Verilog/SystemVerilog.

An asynchronous FIFO is used to transfer data safely between two independent clock domains. The design uses separate read and write clock domains and handles synchronization between them.

## Features

- Asynchronous FIFO design
- Independent read and write clock domains
- FIFO read and write operations
- Full and empty status flags
- Reset handling
- Testbench-based functional verification
- Simulation output and waveform analysis

## Files

- `asynch.v` – Asynchronous FIFO design
- `asynctb.v` – Testbench for verifying the FIFO
- `Output of System Verilog Verification of Asynchronous FIFO.png` – Simulation/verification output

## Verification

The testbench verifies the basic FIFO functionality, including:

- Writing data into the FIFO
- Reading data from the FIFO
- Reset operation
- FIFO full condition
- FIFO empty condition
- Operation across independent clock domains

## Tools Used

- Verilog / SystemVerilog
- EDA Playground
- GitHub

## Output

The simulation output is included in the repository as an image for reference.

## Author

Sneha Agarwal
