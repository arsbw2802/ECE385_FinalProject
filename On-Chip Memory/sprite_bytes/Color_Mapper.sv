//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size_X, Ball_size_Y,
                       input  		[7:0] green_mariodata, blue_mariodata, red_mariodata, red_bgdata,
							  blue_bgdata, green_bgdata, red_brickdata, green_brickdata, blue_brickdata, 
							  input blank, 
								input [5:0] logx,
							  
							  output logic [7:0]  Red, Green, Blue );
    
    logic ball_on, block_brick_on;
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.*/
	 	  
		  
    int DistX, DistY, Size;
	 
    /*always_comb
	 begin
	 if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
			DistX*DistX + DistY*DistY = (Size * Size);
	end*/
		/*New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */

	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size_X = Ball_size_X;
	 assign Size_Y = Ball_size_Y;
	  
    always_comb
    begin:Ball_on_proc
	 
		 if ((DrawX > BallX - Ball_size_X) &&
       (DrawX < BallX + Ball_size_X) &&
       (DrawY > BallY - Ball_size_Y) &&
       (DrawY < BallY + Ball_size_Y))
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
				
		 if( (DrawX + logx > 220 ) &&
       (DrawX + logx < 220 + 90) &&
       (DrawY > 300 ) &&
       (DrawY < 300 + 20 ))
				block_brick_on  = 1'b1;
		 else
				block_brick_on = 1'b0;
     end 
       
    always_comb
    begin:RGB_Display
	 
			if(~blank)
			begin
				Red = 8'b0;
				Green  = 8'b0;
				Blue = 8'b0;
			end
			
			else 
			begin
			if ((ball_on == 1'b1)) 
			begin 
		  
			if (red_mariodata == 8'hFE && green_mariodata == 8'h06 && blue_mariodata == 8'hFF )
			begin
				Red = red_bgdata; 
            Green = green_bgdata;
            Blue = blue_bgdata;
			end
		  
			else
			begin
            Red = red_mariodata;
            Green = green_mariodata;
            Blue = blue_mariodata;
			end
			
			end

			
			else 
			if ( block_brick_on)
			begin
				if (red_brickdata == 8'hFE && green_brickdata == 8'h06 && blue_brickdata == 8'hFF )
				begin
					Red = red_bgdata; 
					Green = green_bgdata;
					Blue = blue_bgdata;
				end
		  
				else
				begin
					Red = red_brickdata;
					Green = green_brickdata;
					Blue = blue_brickdata;
				end
			end
			else
				begin
					Red = red_bgdata; 
					Green = green_bgdata;
					Blue = blue_bgdata;
				end 

			end // end of else blank
    end  // end of always_comb
    
endmodule
