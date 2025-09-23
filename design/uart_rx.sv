`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/23/2025 09:35:33 PM
// Design Name: 
// Module Name: uart_rx
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

module uart_rx(input clk,rst,
               input rx,
               input ready_clr,rx_en,
               output reg ready,
               output reg [7:0] data_out);
  
  parameter START=2'b00;
  parameter DATA=2'b01;
  parameter STOP=2'b10;
  
  reg [1:0] state = START;
  reg [3:0] sample = 0;
  reg [2:0] index = 0;
  reg [7:0] temp_register = 8'h0;
  
  always@(posedge clk)
    begin
      if(rst)
        begin
          ready <= 0;
          data_out <= 0;
        end
    end
  
  always@(posedge clk)
    begin
      if(ready_clr)
        ready <= 0;
      
      if(rx_en)
        begin
          case(state)
            
            START : begin
              if(rx == 0 || sample !=0)
                sample <= sample + 1;
              
              if(sample == 15)
                begin
                  state <= DATA;
                  sample <= 0;
                  index <= 0;
                  temp_register <= 0;
                end
            end
            
            DATA : begin
              sample <= sample + 1;
              
              if(sample == 8)
                begin
                  temp_register[index] <= rx;
                  index <= index + 1;
                end
              
              if(index==7 && sample==15)  /// changes made
                begin
                  state <= STOP;
                end
            end
            
            STOP : begin
              if(sample == 15)
                begin
                  state <= START;
                  data_out <= temp_register;
                  ready <= 1'b1;
                  sample <= 0;
                end
              else
                sample <= sample + 1;
            end
            
            default : begin
              state <= START;
            end
            
          endcase
        end
    end
endmodule