## Section-1 Introduction
This section covers topics such as used cases of different AXI Interfaces, simple memory vs AXI memory and Valid-ready handshake mechanism

## Used cases of different AXI Interfaces
- 3 types of interfaces are there 
- First is AXI Stream for high speed streaming data and is unidirectional
- All point-to-point communications where we need to communicate stream of data are handled by AXI Stream Interface
  <img width="833" height="469" alt="image" src="https://github.com/user-attachments/assets/c149e13f-2a6a-478d-811b-4a20cba32959" />

- Second is AXI Lite for simple, low throughput memory mapped interfaces
- For communication of single bit of data or for working with a slow peripheral, we use AXI Lite. It does not support burst transfer.
  <img width="866" height="791" alt="image" src="https://github.com/user-attachments/assets/0de0a2e1-e606-414c-bf96-204748f7876d" />

- Third is AXI Full for high performance memory mapped data transfer
- For high performance requirement or high BW requirement, we use AXI Full.

- Difference between AXI Stream, AXI lite and AXI Full is 
  <img width="940" height="233" alt="image" src="https://github.com/user-attachments/assets/ae4d353f-ed7e-45df-b40f-b05a246cf62e" />



## Simple Memory vs AXI Memory
- Simple memory is a basic memory model without a complex control logic, typically involving straightforward read and write operations. It is less flexible amd less optimization is there.
   1) It does not have valid signals
   2) It does not have a memory update flag signals 
   3) It does not have signals which show whether memory is free or busy.

- AXI memory supports complex control logic for high performance data transfer.
- In this, we have 5 different channels between master and slave.
  <img width="875" height="694" alt="image" src="https://github.com/user-attachments/assets/68897f03-2df0-4218-a9bb-6c5d28d0d8a5" />

- 1) Write Address ( Master -> Slave) -> Used to convey address as well as control information.
  <img width="723" height="330" alt="image" src="https://github.com/user-attachments/assets/2760a33b-ce74-4302-94cd-2ed12ed0cdfb" />

- 2) Write data (Mater -> Slave) -> for providing the data
  <img width="589" height="297" alt="image" src="https://github.com/user-attachments/assets/b0b85deb-17d7-4b1a-8889-4b4cfcfded6f" />

- 3) Write repsonse (Slave -> Master) ->  response of a write transaction
  <img width="940" height="264" alt="image" src="https://github.com/user-attachments/assets/fb80f6bb-f7b9-479e-aa89-aa102e6956f1" />

- 4) Read address (Master -> Slave) -> specify address and control during read
  <img width="623" height="403" alt="image" src="https://github.com/user-attachments/assets/bb247e85-846a-4b32-8284-b6e792e4963b" />

- 5) Read data (Slave -> Master) -> we get the data which is read from memory
  <img width="889" height="448" alt="image" src="https://github.com/user-attachments/assets/1638dbc6-f44a-4ba0-b416-0cb2816872de" />


## Valid-ready Handshake
<img width="940" height="422" alt="image" src="https://github.com/user-attachments/assets/e824c65a-0bba-455c-87a0-6bb189ac096e" />

- Both valid and ready are synchronized with clk
- 3 rules of valid-ready handshake mechanism are :-
  1) Ready and valid should be independent
  2) Ready could be asserted prior to or after valid
  3) valid must remain high until completion of transfer or until ready becomes high
- When both valid and ready are high, this marks the completion of the transfer
- Valid means that master has valid data 
- Ready means that slave is ready to accept the data from master
<img width="940" height="282" alt="image" src="https://github.com/user-attachments/assets/4ae26c4c-fa83-464f-891b-2a592141705d" />

## Author
*Shashwat Singhal*

