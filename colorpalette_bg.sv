module background_color_palette (input [3:0] data_in, 

output [7:0] red_bgdata, green_bgdata, blue_bgdata);

logic [7:0] tempRed, tempGreen, tempBlue;
	assign red_bgdata = tempRed;
	assign green_bgdata = tempGreen;
	assign blue_bgdata = tempBlue;
	
/*
'0x57b8fa', '0x01030a', '0xffffff', '0x002fa2', '0xcc8a5e', '0x518425', 
'0x426823', '0x5b9c20', '0xcc8a5e', '0x9e5636', '0x91563b', '0x6c3b37', 
'0xe1dfdc', '0x94ce51'
*/
	
always_comb
begin
	case(data_in)
	4'b0000: begin
				tempRed = 8'h57; 
				tempGreen = 8'hB8;
				tempBlue = 8'hFA;
			end
			4'b0001: begin
				tempRed = 8'h01;
				tempGreen = 8'h03;
				tempBlue = 8'h08;
			end
			4'b0010: begin
				tempRed = 8'hFF;
				tempGreen = 8'hFF;
				tempBlue = 8'hFF;
			end
			4'b0011: begin
				tempRed = 8'h00;
				tempGreen = 8'h2F;
				tempBlue = 8'hA2;
			end
			4'b0100: begin
				tempRed = 8'hCC;
				tempGreen = 8'h8A;
				tempBlue = 8'h5E;
			end
			4'b0101: begin
				tempRed = 8'h51;
				tempGreen = 8'h84;
				tempBlue = 8'h25;
			end
			4'b0110: begin
				tempRed = 8'h42;
				tempGreen = 8'h68;
				tempBlue = 8'h23;
			end
			4'b0111: begin
				tempRed = 8'h5B;
				tempGreen = 8'h9C;
				tempBlue = 8'h20;
			end
			4'b1000: begin
				tempRed = 8'hCC;
				tempGreen = 8'h8A;
				tempBlue = 8'h5E;
			end
			4'b1001: begin
				tempRed = 8'h9E;
				tempGreen = 8'h56;
				tempBlue = 8'h36;
			end
			4'b1010: begin
				tempRed = 8'h91;
				tempGreen = 8'h56;
				tempBlue = 8'h3B;
			end
			4'b1011: begin
				tempRed = 8'h6C;
				tempGreen = 8'h3B;
				tempBlue = 8'h37;
			end
			4'b1100: begin
				tempRed = 8'hE1;
				tempGreen = 8'hDF;
				tempBlue = 8'hDC;
			end	
			4'b1101: begin
				tempRed = 8'h94;
				tempGreen = 8'hCE;
				tempBlue = 8'h51;
			end
			default:
			begin
				tempRed = 8'hFF;
				tempGreen = 8'hFF;
				tempBlue = 8'hFF;
			end
			
		endcase
	end

endmodule 