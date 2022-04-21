//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball ( input Reset, frame_clk,
					input [7:0] keycode, keycode1,
               output [9:0]  BallX, BallY, BallSX, BallSY,
					output [5:0] logx);
    
	 
	 logic [1:0] set_parabola;
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size_X, Ball_Size_Y, y_deltadist;
	 logic up_on, going_up;
    parameter [9:0] Ball_X_Center = 80;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center = 378;// Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=699;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis

    //assign Ball_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
   
		assign Ball_Size_X = 10'd10;
		assign Ball_Size_Y = 10'd20;
		// assign set_parabola = 2'b00;
	
		always_comb
		begin
			set_parabola = 2'b00;
			if(keycode == 8'h1A || keycode1 == 8'h1A)
				set_parabola = 2'b01;
			if (keycode == 8'h07 || keycode1 == 8'h07)
				set_parabola = set_parabola | 2'b10;
			
		end
		
		
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
				logx <= 0;
        end
           
        else 
		  
        begin 
		 
				 if ( (Ball_Y_Pos + Ball_Size_Y) >= Ball_Y_Max )	 // Ball is at the bottom edge, BOUNCE!
					begin 
					 Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
					  //Ball_X_Motion <= 0; 
					end
				 else if ( (Ball_Y_Pos - Ball_Size_Y) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
					 begin
					  Ball_Y_Motion <= Ball_Y_Step;
					  //Ball_X_Motion <= 0; 
					 end
					  
				  else if ( (Ball_X_Pos + Ball_Size_X + logx) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
					 begin
					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
					  //Ball_Y_Motion <= 0; 
					 end
					  
				 else if ( (Ball_X_Pos - Ball_Size_X) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
					 begin 
					  Ball_X_Motion <= Ball_X_Step;
					  //Ball_Y_Motion <= 0;
					 end 
				 else 
				 
				begin
					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
					  
				
						
				 
				case (set_parabola)
					/*8'h04 : begin
								//if (~(Ball_Y_Pos + Ball_Size_Y) >= Ball_Y_Max )
								//begin
										Ball_X_Motion <= -1;//A
										Ball_Y_Motion<= 0;
								//end
							  end*/ 
					        
					2'b10 : begin
								//if (~(Ball_Y_Pos - Ball_Size_Y) <= Ball_Y_Min )
								//begin
									Ball_X_Motion <= 1;//D
									Ball_Y_Motion <= 0;
								//end
							  end

							  
					/*8'h16 : begin
							//if (~(Ball_X_Pos + Ball_Size_X) >= Ball_X_Max )
							//begin
									Ball_Y_Motion <= 1;//S
									Ball_X_Motion <= 0;
							//end
							end*/ 
							  
					2'b01 : begin
							
								going_up <= 1;  // up
							 Ball_Y_Motion <= -3;
							 Ball_X_Motion <= 0;

							 end
							 
					2'b11: begin
								going_up <= 1;   //up and right
								Ball_Y_Motion <= -3;
								Ball_X_Motion <= 1;
								end
								
								
					default: 
						begin
							//Ball_Y_Motion <= 0;// no motion
							Ball_X_Motion <= 0;
						end
			   endcase
				end

																						
							// keep this part - jump
							if(Ball_Y_Pos < 300 ||  (Ball_Y_Pos < 378 && !going_up) )// <
								begin 
								Ball_Y_Motion <= 3;
								going_up <= 0;
								end
							else if(!going_up && Ball_Y_Pos > 378) // >
							begin
								Ball_Y_Motion <= 0;
								Ball_Y_Pos <= 378;
							end
							else if (Ball_Y_Pos > 300 && (keycode == 8'h07 || keycode1 == 8'h07) && going_up)
								Ball_Y_Motion <= -3;
					
						// scrolling screen
				 if(Ball_X_Pos >= 320 && (keycode == 8'h07 || keycode1 == 8'h07) && logx < 60)
					begin
					Ball_X_Motion<= 0;
					logx <= logx+1;
					end
				 if(Ball_X_Pos+logx >= 380 && Ball_X_Pos+logx < 699 && (keycode == 8'h07 || keycode1 == 8'h07) )
					begin
						Ball_X_Motion <= 1;
					end
				 
				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
			
		end  
    end
       
    assign BallX = Ball_X_Pos;
   
    assign BallY = Ball_Y_Pos;
   
    assign BallSX = Ball_Size_X;
	 
	 assign BallSY = Ball_Size_Y;
    

endmodule
