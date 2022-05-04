module collision_detect (input  frame_clk, reset,score_addedc1, score_addedc2, score_addedc3, score_addedg1,
			input logic [9:0] currentxpos, currentypos,
			input logic [5:0] logx,
			
			output logic coin1_d, coin2_d, coin3_d, goomba1_d1, goomba1_d2,
			output logic [9:0] increment);


always_ff@ (posedge frame_clk or posedge reset)
begin
	if (reset)
	begin
		coin1_d <= 1'b0;
		coin2_d <= 1'b0;
		coin3_d <= 1'b0;
		goomba1_d1 <= 1'b0;
		goomba1_d2 <= 1'b0;
		//increment <= 10'b0;
	end
	else if((currentxpos + logx > 227 ) && (currentxpos + logx < 248 ) 
		&& (currentypos > 278) && (currentypos < 300))
		begin
		coin1_d <= 1;
		
		end
	else if ((currentxpos + logx > 258 ) && (currentxpos + logx < 278 ) 
		&& (currentypos > 278) && (currentypos < 300))
		begin
		coin2_d <= 1;
		
		end
	else if ((currentxpos + logx > 138 ) && (currentxpos + logx < 158 ) 
		&& (currentypos > 378) && (currentypos < 400))
		begin
		coin3_d <= 1;
		
		end
	else if ((currentxpos + logx > 400 ) && (currentxpos + logx < 430 ) 
		&& (currentypos <= 355) && (currentypos > 350))
		begin
		goomba1_d1 <= 1;
		
		end
	else if ((currentxpos + logx > 397 ) && (currentxpos + logx < 433 ) 
		&& (currentypos > 356 ))
		begin
		goomba1_d2 <= 1;
		
		end
		
	// goomba
	
end


always_comb
begin
	
	if(coin1_d && ~score_addedc1)
		begin
		increment = 5;
		end
		
	else if (coin2_d && ~score_addedc2)
		begin
		increment = 5;
		end
		
	else if (coin3_d && ~score_addedc3)
		begin
		increment = 5;
		end
	else if(goomba1_d1 && ~score_addedg1)
		begin
		increment = 10;
		end
	else if(goomba1_d2 && ~score_addedg1)
		begin
		increment = -2;
		end
		
	else
		increment = 0;
end

endmodule
