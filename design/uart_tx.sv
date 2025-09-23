`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2025 09:34:11 PM
// Design Name: 
// Module Name: uart_tx
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

module uart_tx(input clk,
               input wr_en,rst,
               input tx_en,
               input [7:0] data_in,
               output reg tx,
               output busy);
  
  parameter IDLE=2'b00, START=2'b01, DATA=2'b10, STOP=2'b11;
  
  reg [7:0] data;
  reg [2:0] index;
  reg [1:0] state = IDLE;
  
  always@(posedge clk)
    begin
      if(rst)
        begin
          tx <= 1'b1;
          index <= 3'd0;
          data <= 8'd0;
        end
    end
  
  always@(posedge clk)
    begin
      case(state)
        
        IDLE : begin
          if(wr_en)
            begin
              state <= START;
              data <= data_in;
              index <= 3'h0;
            end
        end
        
        START : begin
          if(tx_en)
            begin
              tx <= 1'b0;
              state <= DATA;
            end
        end
        
        DATA : begin
          if(tx_en)
            begin
              tx <= data[index];
              if(index==3'd7)
                state <= STOP;
              else
                index <= index + 1;
              
            end
        end
        
        STOP : begin
          if(tx_en)
            begin
              tx <= 1'b1;
              state <= IDLE;
            end
        end
        
        default : begin
          state <= IDLE;
          tx <= 1'b1;
        end
        
      endcase
    end
  
  assign busy = (state != IDLE);
endmodule