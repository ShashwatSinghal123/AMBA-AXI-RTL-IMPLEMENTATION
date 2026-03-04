`timescale 1ns / 1ps

module handshake_tb;

    
    handshake dut();

    integer transfer_count = 0;

    initial begin
        $display("Starting Handshake Verification...");
        $monitor("Time=%0t | valid=%b ready=%b | m_data=%0d s_data=%0d",
                  $time,
                  dut.m_validout,
                  dut.s_readyout,
                  dut.m_data,
                  dut.s_data);

        
        #1000;

        $display("Total Transfers = %0d", transfer_count);
        $display("Simulation Finished.");
        $finish;
    end

    
    always @(posedge dut.clk) begin
        if (dut.m_validout && dut.s_readyout) begin
            transfer_count = transfer_count + 1;

            
            #1;  
            if (dut.s_data !== dut.m_data) begin
                $display("ERROR: Data mismatch at time %0t", $time);
                $stop;
            end
        end
    end

  initial begin
    $dumpfile("file.vcd");
    $dumpvars(0, handshake_tb);
  end
  
endmodule
