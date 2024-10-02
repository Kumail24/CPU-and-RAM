# CPU-and-RAM
Simple CPU and RAM simulated in Verilog to perform ALU, load and store to RAM operations based on a 1-byte input.

# Components
  This project contains a:
  * ALU with 2-bit OPCODE
  * RAM with 16 1-byte address slots.
  * Control Unit.
    
All these components are wired together within the top-level module named 'cpu.v'.    
# Types Of Operations

The input contains 1 byte in the form of ABCD_EFGH.

The first 2 MSB (AB) will tell the control module what type of operation will be performed.
### If AB == 2b'00: Perform an ALU operation.
  * CD refers to the type of ALU operation to be performed
    * If CD == 2'b00: Perform an addition operation.
    * If CD == 2'b01: Perform a subtraction operation.
    * If CD == 2'b10: Perform an AND operation.
    * If CD == 2'b11: Perform an OR operation.
  * EF and GH refer to the specific register whose value will be sent to the ALU.
    
  Once the ALU operation is performed, the result will be sent to the first register from the input code ('EF').
    
  Example: Input Register == 8'b00101101.
  
  Solution: perform an AND operation with the values from Registers 4 and 2 and store the result in register 4.
    
### If AB == 2b'01: Perform a 'Load from RAM' operation.
  * The value of CD refers to the register that the RAM's value will be sent to.
  * EFGH refers to the address of the value we want to load from RAM.

  Example: Input Register == 8'b01101010.

  Solution: load value at address 10 to register 3.
    
### If AB == 2b'10: Perform a 'Store to RAM' operation.
  * The value of CD tells the control unit which register to send to RAM.
  * The value of EFGH specifics which RAM address to send to.

  Example: Input Register == 8'b10111100.

  Solution: Store values of register 4 into RAM address of 12.

