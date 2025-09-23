`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2025 09:33:03 PM
// Design Name: 
// Module Name: baud_rate_gen
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


//module baud_rate_gen();
//endmodule



module baud_rate_gen(input clk,rst,
                     output rx_en,tx_en );
  
//   parameter RX_CNTR_MAX = 50000000/(9600*16);
//   parameter TX_CNTR_MAX = 50000000/(9600);
//   parameter RX_CNTR_WIDTH = $clog2(RX_CNTR_MAX);
//   parameter TX_CNTR_WIDTH = $clog2(TX_CNTR_MAX);
  
//   reg [RX_CNTR_WIDTH-1:0] rx_counter = 0;
//   reg [TX_CNTR_WIDTH-1:0] tx_counter = 0;
  
  reg [12:0] tx_counter=0;
  reg [8:0] rx_counter=0;
  
  assign rx_en = (rx_counter==9'd0);
  assign tx_en = (tx_counter==13'd0);
  
  always@(posedge clk)
    begin
      if(rst)
        rx_counter <= 0;
      else if(rx_counter==325)
        rx_counter <= 0;
      else
        rx_counter <= rx_counter + 1;
    end
  
  always@(posedge clk)
    begin
      if(rst)
        tx_counter <= 0;
      else if(tx_counter==5208)
        tx_counter <= 0;
      else
        tx_counter <= tx_counter + 1;
    end
endmodule