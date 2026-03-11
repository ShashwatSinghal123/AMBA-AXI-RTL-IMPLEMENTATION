// master //
module axis_m(
    input  wire m_axis_aclk,
    input  wire m_axis_aresetn,
    input  wire newd,
    input  wire [7:0] din,
    input  wire m_axis_tready,
    output wire m_axis_tvalid,
    output wire [7:0] m_axis_tdata,
    output wire m_axis_tlast 
    );
    
    typedef enum bit {idle = 1'b0, tx = 1'b1} state_type;
    state_type state = idle, next_state = idle;
    
    reg [2:0] count = 0;
    
    
    always@(posedge m_axis_aclk)
    begin
    if(m_axis_aresetn == 1'b0)
        state <= idle;
    else
        state <= next_state;
    end
    
    
    always@(posedge m_axis_aclk)
    begin
    if(state == idle)
       count <= 0;       
    else if(state == tx && count != 3 && m_axis_tready == 1'b1)
        count <= count +1;
    else
        count <= count;
    end
    
    
    always@(*)
    begin
       case(state)
               idle:
               begin  
                    if(newd == 1'b1)
                      next_state = tx;
                    else
                      next_state = idle;
               end
               
               tx:
               begin
                    if(m_axis_tready == 1'b1)
                    begin                    
                        if(count != 3)
                        next_state  = tx;
                        else
                        next_state  = idle;
                    end
                    else
                    begin
                        next_state  = tx;
                    end 
                end
               
               default: next_state = idle;
               
               endcase
        
        end
        
 assign m_axis_tdata   = (m_axis_tvalid) ? din*count : 0;   
 assign m_axis_tlast   = (count == 3 && state == tx)    ? 1'b1 : 0;
 assign m_axis_tvalid  = (state == tx ) ? 1'b1 : 1'b0;
  
  
endmodule


// slave //

module axis_s(
    input  wire s_axis_aclk,
    input  wire s_axis_aresetn,
    output wire s_axis_tready,
    input  wire s_axis_tvalid,
    input  wire [7:0] s_axis_tdata,
    input  wire s_axis_tlast,
    output wire [7:0] dout
    );
 
    typedef enum bit [1:0] {idle = 2'b00, store = 2'b01, last_byte = 2'b10} state_type;
    state_type state = idle, next_state = idle;
    
    always@(posedge s_axis_aclk)
    begin
    if(s_axis_aresetn == 1'b0)
    state  <= idle;
    else
    state <= next_state;
    end
 
 
    always@(*)
        begin
               case(state)
               idle:
                begin  
                    if(s_axis_tvalid == 1'b1)
                      next_state = store;
                    else
                      next_state = idle;
                end
               
               store:
                begin
                if(s_axis_tlast == 1'b1 && s_axis_tvalid == 1'b1 ) 
                      next_state = idle;
                 else if (s_axis_tlast == 1'b0 && s_axis_tvalid == 1'b1)
                      next_state = store;
                 else
                      next_state = idle;
               end
                
               default: next_state = idle;
               
               endcase
         end
        
 
 
assign s_axis_tready = (state == store);
assign dout          = (state == store ) ? s_axis_tdata : 8'h00;
 
 
endmodule

// master and slave connected //

module top 
(
input clk,rst, newd,
input [7:0] din,
output [7:0] dout,
output last
);
wire last_t, valid_t, ready_t;
wire [7:0] data;
 
axis_m m1 (clk,rst,newd,din, ready_t, valid_t, data, last_t);
axis_s s1 (clk, rst,ready_t,valid_t,data,last_t, dout);
 
assign last = last_t;
 
endmodule

module top_tb();
 
 
reg clk = 0;
reg rst;
reg newd;
reg [7:0] din;
wire [7:0] dout;
wire last;
 
 
top dut(clk,rst, newd, din, dout, last);
 
 
 always #10 clk = ~clk;
 
 initial 
    begin
        rst = 1'b0;
        repeat(10) @(posedge clk);
        rst = 1'b1;
        for(int i = 0; i <10; i++)
        begin
        @(posedge clk);
        newd = 1;
        din = $urandom_range(0,15);
        @(negedge last);
        end
        $finish;
    end
 
  initial begin
    $dumpfile("combined.vcd");
    $dumpvars(0,top_tb);
  end
  
endmodule

