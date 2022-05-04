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
							  blue_bgdata, green_bgdata, red_lpipedata, green_lpipedata, blue_lpipedata, red_coindata, green_coindata, 
							  blue_coindata, red_spipedata, green_spipedata, blue_spipedata, red_goombadata, blue_goombadata, green_goombadata,
							  input blank, is_coin2_detect, is_coin1_detect, is_coin3_detect, is_goomba1_d1,
								input [5:0] logx,
								input [9:0] score,
							  
							  output logic [7:0]  Red, Green, Blue );
    
    logic ball_on, block_lpipe_on, smallpipe_on, coin1_on, coin2_on, coin3_on,
	 score_display_ones, score_display_tens, score_display_hundreds, goomba_on;
	 logic [7:0] font_data_score;
	 logic [10:0] font_address,ones_address, tens_address, hundreds_address;
	 
	 // assign font_address = 11'b0;
	 //assign font_data_score = 8'b0;
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.*/
	 	  
		  
    // int DistX, DistY, Size;
	 
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

	 /*assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size_X = Ball_size_X;
	 assign Size_Y = Ball_size_Y;
	 */

	 
    always_comb
    begin:Ball_on_proc
	 
		 font_address = 11'b0;
	 
		 if ((DrawX > BallX - Ball_size_X) &&
       (DrawX < BallX + Ball_size_X) &&
       (DrawY > BallY - Ball_size_Y) &&
       (DrawY < BallY + Ball_size_Y))
            ball_on = 1'b1;
       else 
            ball_on = 1'b0;
				
		 if( (DrawX + logx > 255 ) &&
       (DrawX + logx < 255 + 40) &&
       (DrawY > 325 ) &&
       (DrawY < 325 + 80 ))
				block_lpipe_on  = 1'b1;
		 else
				block_lpipe_on = 1'b0;
				
				
		 if( (DrawX + logx > 215) &&
       (DrawX + logx < 215 + 35) &&
       (DrawY > 353 ) &&
       (DrawY < 353 + 50 ))
				smallpipe_on  = 1'b1;
		 else
				smallpipe_on = 1'b0;
				
		if( (DrawX +logx > 400 ) && (DrawX +logx < 430 ) 
		&& (DrawY > 375 ) && (DrawY < 410) && (is_goomba1_d1 == 1'b0) )
			goomba_on = 1'b1;
		else
			goomba_on = 1'b0;
				
			
			
				
		if ((DrawX +logx > 230 ) && (DrawX +logx < 245 ) 
		&& (DrawY > 278) && (DrawY < 298) && (is_coin1_detect == 1'b0) )
			coin1_on = 1'b1;
		else
			coin1_on = 1'b0;
			
			
		if ((DrawX +logx > 260 ) && (DrawX +logx < 275 ) 
		&& (DrawY > 278) && (DrawY < 298) && (is_coin2_detect == 1'b0) )
			coin2_on = 1'b1;
		else
			coin2_on = 1'b0;
		
		if( (DrawX +logx > 140 ) && (DrawX +logx < 155 ) 
		&& (DrawY > 378 ) && (DrawY < 398) && (is_coin3_detect == 1'b0) )
			coin3_on = 1'b1;
		else
			coin3_on = 1'b0;
			
			
			
		if((DrawX  >= 48 ) && (DrawX  < 56 ) 
		&& (DrawY >= 32) && (DrawY < 48))
			begin
			score_display_ones = 1'b1;
			font_address = ((score%10) + 8'h2e)*16 + DrawY;
			end
			// sprite_addr calculation for ones digit
		else
			begin
			//ones_address = DrawY;
			score_display_ones = 1'b0;
			end
		
				
		if((DrawX  >= 40 ) && (DrawX  < 48 ) 
		&& (DrawY >= 32) && (DrawY < 48))
			begin
			score_display_tens = 1'b1;
			font_address = (((score/10)%10)+ 8'h2e)*16 + DrawY;
			//((score/10)%10)*16 + DrawY;
			end
			// sprite_addr calculation for ones digit
		else		
			begin
			//tens_address = DrawY;
			score_display_tens = 1'b0;
			end
			
		if((DrawX  >= 32 ) && (DrawX  < 40 ) 
		&& (DrawY >= 32) && (DrawY < 48))
			begin
			score_display_hundreds = 1'b1;
			font_address = (((score/10)/10)+ 8'h2e)*16 + DrawY;
			end
			// sprite_addr calculation for ones digit
		else
			begin
			//hundreds_address = DrawY;
			score_display_hundreds = 1'b0;
			end
 
     end
	  
	  font_rom font_data(.addr(font_address), .data(font_data_score)); 
	  
	  always_comb
	  begin:RGB_Display
	  
			Red = red_bgdata;
			Green = green_bgdata;
			Blue = blue_bgdata;
			
			if(~blank)
				begin
					Red = 8'b0;
					Green  = 8'b0;
					Blue = 8'b0;
				end
			else
				begin
				
					if(goomba_on )
					begin
				
						if (red_goombadata == 8'hFF && green_goombadata == 8'hFF && blue_goombadata == 8'hFF )
						begin
							Red = red_bgdata; 
							Green = green_bgdata;
							Blue = blue_bgdata;
						end
			  
						else
						begin
						
							Red = red_goombadata;
							Green = green_goombadata;
							Blue = blue_goombadata;
						end	
					
					end
				
					else if((ball_on == 1'b1))
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
					if (score_display_ones || score_display_tens || score_display_hundreds) 
						begin
						if(font_data_score[3'h7 - DrawX[2:0]] == 1'b1)
							begin
								Red = 8'hFF;
								Green = 8'h00;
								Blue = 8'h00;
							end
				
						end
					if(block_lpipe_on)
					begin
						if (red_lpipedata == 8'hFE && green_lpipedata == 8'h06 && blue_lpipedata == 8'hFF )
							begin
								Red = red_bgdata; 
								Green = green_bgdata;
								Blue = blue_bgdata;
							end
					  
						else
							begin
								Red = red_lpipedata;
								Green = green_lpipedata;
								Blue = blue_lpipedata;
							end
										
					end
					
					if(smallpipe_on)
					begin
						if (red_spipedata == 8'hFE && green_spipedata == 8'h06 && blue_spipedata == 8'hFF )
							begin
								Red = red_bgdata; 
								Green = green_bgdata;
								Blue = blue_bgdata;
							end
					  
						else
							begin
								Red = red_spipedata;
								Green = green_spipedata;
								Blue = blue_spipedata;
							end
					
					
					end
					if(coin1_on || coin2_on || coin3_on)
					begin
						if (red_coindata == 8'hFE && green_coindata == 8'h06 && blue_coindata == 8'hFF )
						begin
							Red = red_bgdata; 
							Green = green_bgdata;
							Blue = blue_bgdata;
						end
			  
						else
						begin
							Red = red_coindata;
							Green = green_coindata;
							Blue = blue_coindata;
						end
					end
					
					

	 end
     /*  
    always_comb
    begin:RGB_Display
	 
			if(~blank)
			begin
				Red = 8'b0;
				Green  = 8'b0;
				Blue = 8'b0;
			end
			
			else // if blank
			begin
			
			
				Red  = red_bgdata;
				Green = green_bgdata;
				Blue = blue_bgdata;
				
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
			
				
				//else // start of if not ball
				
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
		
				
				//begin
				if (score_display_ones || score_display_tens || score_display_hundreds) 
				begin
					if(font_data_score[3'h7 - DrawX[2:0]] == 1'b1)
					begin
						Red = 8'hFF;
						Green = 8'h00;
						Blue = 8'h00;
					end
				
				end
			
			
				if(coin1_on || coin2_on || coin3_on)
				begin
					if (red_coindata == 8'hFE && green_coindata == 8'h06 && blue_coindata == 8'hFF )
					begin
						Red = red_bgdata; 
						Green = green_bgdata;
						Blue = blue_bgdata;
					end
			  
					else
					begin
						Red = red_coindata;
						Green = green_coindata;
						Blue = blue_coindata;
					end
				end
			
					
			// end
			end // end of else blank
		end  // end of always_comb
		
		*/
end
    
endmodule
