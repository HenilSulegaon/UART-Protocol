`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2025 09:36:53 PM
// Design Name: 
// Module Name: uart_top
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


// Code your design here

module uart_top(input rst,
                input [7:0] data_in,
                input wr_en,clk,
                input ready_clr,
                output ready,busy,
                output [7:0] data_out);
  
  wire rx_clk_en;
  wire tx_clk_en;
  wire tx_temp;  // connecting the output of tx module
  
  baud_rate_gen brg(clk,rst,rx_clk_en,tx_clk_en);
  
  uart_tx trans(clk,wr_en,rst,tx_clk_en,data_in,tx_temp,busy);
  
  uart_rx reciev(clk,rst,tx_temp,ready_clr,rx_clk_en,ready,data_out);
endmodule