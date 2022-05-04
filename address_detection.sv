module detect_address_coin ( input logic [9:0] currentxpos, currentypos,
			input logic [5:0] logx,
			output logic [18:0] read_addr);
			
always_comb
begin

	if( (currentxpos + logx > 140 ) && (currentxpos + logx < 155 ) 
		&& (currentypos > 378 ) && (currentypos < 398) )
		
		read_addr = (logx + currentxpos - 140) +(currentypos - 378)*15;
		
	else if((currentxpos + logx > 230 ) && (currentxpos + logx < 245 ) 
		&& (currentypos >  278) && (currentypos < 298))
		
		read_addr = (logx + currentxpos - 230) +(currentypos - 278)*15;
		
	else if ((currentxpos + logx > 260 ) && (currentxpos +logx < 275 ) 
		&& (currentypos > 278) && (currentypos < 298))
		
		read_addr = (logx + currentxpos - 260) +(currentypos - 278)*15;
		
	else 
		read_addr = (logx + currentxpos - 140) +(currentypos - 378)*15;
end
endmodule
			