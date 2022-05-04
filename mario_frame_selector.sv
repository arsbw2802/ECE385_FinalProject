module frame_address_select (input [9:0] drawxsig, drawysig, ballxsig, ballysig,
										input [1:0] frame_number,
										output [18:0] read_address_mario);
										
always_comb
begin

	case(frame_number)
	
	
		2'b00: begin
				read_address_mario = (drawxsig-(ballxsig-10))+ (drawysig-(ballysig-20))*20;
				end
		2'b01: begin
				 read_address_mario = (drawxsig-(ballxsig-10))+ (drawysig-(ballysig-20))*20 + 800;
				 end
		2'b10: begin
					 read_address_mario = (drawxsig-(ballxsig-10))+ (drawysig - (ballysig-20))*20 + 1600;
				 end
		2'b11: begin
				 read_address_mario = (drawxsig-(ballxsig-10))+ (drawysig-(ballysig-20))*20 + 800;
				 end
		default: begin
					read_address_mario = (drawxsig-(ballxsig-10))+ (drawysig-(ballysig-20))*20;
					end
		
	endcase
end


endmodule
