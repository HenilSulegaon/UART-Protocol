`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2025 09:42:23 PM
// Design Name: 
// Module Name: uart_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Code your testbench here
// or browse Examples


module uart_tb;
  reg clk,rst;
  reg [7:0] data_in;
  reg wr_en;
  wire ready;
  reg ready_clr;
  wire [7:0] data_out;
  wire busy;
  
  uart_top dut(rst,data_in,wr_en,clk,ready_clr,ready,busy,data_out);
  
  initial begin
    {clk,rst,data_in,ready_clr,wr_en} = 0;
  end
  
  always #5 clk = ~clk;
  
  task send_byte(input [7:0] din);
    begin
      @(negedge clk);
      data_in = din;
      wr_en=1;
      @(negedge clk);
      wr_en=0;
    end
  endtask
  
  task clear_ready;
    begin
      @(negedge clk);
      ready_clr=1;
      @(negedge clk);
      ready_clr=0;
    end
  endtask
  
  initial begin
    
    @(negedge clk)
    rst=1;
    @(negedge clk)
    rst=0;
    
    send_byte(8'h25);
    wait(!busy);
    wait(ready);
    $display("Received data is %h",data_out);
    clear_ready;
    
    send_byte(8'h77);
    wait(!busy);
    wait(ready);
    $display("Received data is %h",data_out);
    clear_ready;
    
    #400 $finish;
  end
  
  initial begin
    $dumpfile("uart.vcd");
    $dumpvars;
    #150000 $finish;
  end
  
endmodule