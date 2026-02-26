## Section-4 Getting started with AXI Lite
- This section covers topics such as difference between transaction, beat and transfer, understanding write/read address, data and response channel, understanding different channel ID's as well as differnet types of responses

## Difference between transaction, beat and transfer
- A beat is an individual data transfer within an AXI burst
- Data can be a transfer or a beat 
- We can have multiple beats in a transfer
- Entire flow from address to response is called transaction

FSM and waveform diagrams

## Write address channel
- 1) awvalid -> from master to slave to initiate the transaction
  2) awready -> from slave to master to accept the data
  3) awaddr -> first address of a beat/transfer
  4) awsize -> size of each beat [2:0]
  5) awburst -> denotes the size of a burst
  6) awlen -> denotes the length of a burst (burst len = awlen + 1)
  7) awid -> to distinguish between two transactions. It is useful in pipeline as each transaction has a unique id.

## Understanding channel ID's
1) single beat + no pipeline
- waveform picture

2) single beat + pipeline
- In this, we do not have to wait for rdata after every araddr
- waveform diagram 

## Understanding write data channel
- 1) wvalid and wready -> used for handshake
  2) wdata -> where we can apply actual data
  3) wstrb -> works as a bit mask for a data . If 1 then valid data, else invalid data
  4) wid -> id of the transaction
  5) wlast -> to indicate last beat of the transfer

## Understanding write response channel 
- 1) bready -> goes from master to slave. By this, master wants to indicate that I am ready to receive the response
  2) bvalid -> goes from slave to master
  3) bid -> id of the response. It matches with address id.
  4) bresp -> response of the transcation whether it is successful or unsuccessful

## Different types of response
- 1) okay(b00) -> Normal access is successful. Can also indicate an exclusive access failure
  2) exokay(b01) -> Either the read or write portion of an exclusive access has been successful
  3) slverr(b10) -> access has reached to the slave successfully, but the slave wishes to return an error condition to the originating master
  4) decerr(b11) -> typically by an interconnect component to indicate that there is no slave at the transaction address

- For exclusive access, we have one more signal in write channel
-AWLOCK -> used to get an exclusive access of certain variable.
  1) 00 -> Normal access ( no lock)
  2) 01 -> Reserved (typically not used)
  3) 10 -> exclusive access request
  4) 11 -> locked access request

  In excluive access request (10), other master will not be able to access shared resource for a single transaction
  To lock for multiple transactions, use 11

  It is generally used for multi-master system.

## Understanding different read address and data channel

- We don't have independent response channel for a read operation
- 1) Read address channel -> arvalid, arready, araddr, arsize, arburst, arlen, arid
  2) Read data channel -> rvalid, rready, rdata, rstrb, rwid, rlast, rresp

  In these signals, rready goes from master to slave. Rest other signals go from slave to master

  block diagram 

## Transaction waveforms
- 

## Repository Structure
Refer to the directory structure for RTL, UVM components, assertions, and documentation.

## Author
*Shashwat Singhal*

































