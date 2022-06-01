`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/01/2022 10:09:41 PM
// Design Name: 
// Module Name: test
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
module accessdoor(
		clk,
  		rst,
  		tx,
  		identityNumber,
        pass
);
  input clk;
  input rst;
  input tx;
  input [3:0] identityNumber;
  output reg pass;
  
  integer counter;  
  integer state ; // for state machine
  /*
  	state {0: Idle , 1: Check , 2: pass}
  */
  
  // executed only in the rising edge of clock
  always @ (posedge clk)
    begin
      if (rst)
        begin
          counter <= 0;
          state <= 0;
          pass <= 0;
        end 
      else
        begin
          counter <= counter + 1;
          case (state)
            0:
              begin
                counter <=0;
                if (tx)
                  begin
                    state <= 1;
                  end 
              end
            1:
              begin
                /*
                identityNumber = 4'd1 // ceo 
                identityNumber = 4'd2 // manager
                identityNumber = 4'd3 // Employee
                identityNumber = 4'd4 // trainee
                */
                counter <= 0;
                if (identityNumber ==4'd1 )
                  begin
                    state <= 2;
                    //counter <= 0;
                  end 
                else if (identityNumber ==4'd2 )
                  begin
                    state <= 2;
                    //counter <= 0;
                  end 
                else if (identityNumber == 4'd3)
                  begin
                    state <= 2;
                    //counter <= 0;
                  end
                else if (identityNumber == 4'd4)
                  begin
                    state <= 2;
                    counter <= 0;
                  end 
                else
                  begin
                    //denied access 
                    state <= 1;
                  end 
              end 
            2:
              begin
                if (counter == 5)
                  begin
                    state <= 0;
                  end 
              end 

          endcase
        end 
    end 
  
  always @ (negedge clk)
    begin
      case (state)
        0:
          begin
            pass <= 0;
          end 
        1:
          begin
            pass <= 0;
          end 
        2:
          begin
            pass <= 1;
          end 
      endcase
    end 
endmodule
/*
module testb ();
  reg clk;
  reg rst;
  reg tx;
  reg [3:0] identityNumber;
  wire  pass;
  
  accessdoor uut(
		clk,
  		rst,
  		tx,
  		identityNumber,
        pass
);
  
  initial
    begin
      clk = 0;
      rst = 1;
      tx = 0;
      identityNumber = 4'd8;
      #10
      rst = 0;
      #100
      tx = 1;
      #100
      identityNumber = 4'd2;
    end 
  
  always 
    begin
      #5 clk = ! clk;
    end 
endmodule
*/
