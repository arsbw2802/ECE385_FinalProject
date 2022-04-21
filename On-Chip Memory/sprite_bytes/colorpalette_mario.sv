module color_palette_mario (input [3:0] data_in, 

output [7:0] red_mariodata, green_mariodata, blue_mariodata);

logic [7:0] tempRed, tempGreen, tempBlue;
	assign red_mariodata = tempRed;
	assign green_mariodata = tempGreen;
	assign blue_mariodata = tempBlue;
	
	//0xFFD5CF', '0x2d1e10', '0x420000', '0x570000',
	//'0xE4312F', '0xFF7B68', '0xa96f3f', '0xD9D36F', '0xCFB4B5', 
	//'0xA11F28', '0xFE06FF', '0x734b2a', '0x1c4d6c', '0x2871a2', '0x000057'
	// change the colors
	always_comb begin
		case(data_in)
			4'b0000: begin
				tempRed = 8'hFF; 
				tempGreen = 8'hDF;
				tempBlue = 8'hCF;
			end
			4'b0001: begin
				tempRed = 8'h2D;
				tempGreen = 8'h1E;
				tempBlue = 8'h10;
			end
			4'b0010: begin
				tempRed = 8'h42;
				tempGreen = 8'h00;
				tempBlue = 8'h00;
			end
			4'b0011: begin
				tempRed = 8'h57;
				tempGreen = 8'h00;
				tempBlue = 8'h00;
			end
			4'b0100: begin
				tempRed = 8'hE4;
				tempGreen = 8'h31;
				tempBlue = 8'h2F;
			end
			4'b0101: begin
				tempRed = 8'hFF;
				tempGreen = 8'h7B;
				tempBlue = 8'h68;
			end
			4'b0110: begin
				tempRed = 8'hA9;
				tempGreen = 8'h6F;
				tempBlue = 8'h3F;
			end
			4'b0111: begin
				tempRed = 8'hD9;
				tempGreen = 8'hD3;
				tempBlue = 8'h6F;
			end
			4'b1000: begin
				tempRed = 8'hCF;
				tempGreen = 8'hB4;
				tempBlue = 8'hB5;
			end
			4'b1001: begin
				tempRed = 8'hA1;
				tempGreen = 8'h1F;
				tempBlue = 8'h28;
			end
			4'b1010: begin
				tempRed = 8'hFE;
				tempGreen = 8'h06;
				tempBlue = 8'hFF;
			end
			4'b1011: begin
				tempRed = 8'h73;
				tempGreen = 8'h4B;
				tempBlue = 8'h2A;
			end
			4'b1100: begin
				tempRed = 8'h1C;
				tempGreen = 8'h4D;
				tempBlue = 8'h6C;
			end	
			4'b1101: begin
				tempRed = 8'h28;
				tempGreen = 8'h71;
				tempBlue = 8'hA2;
			end
			4'b1110: begin
				tempRed = 8'h00;
				tempGreen = 8'h00;
				tempBlue = 8'h57;
			end
			default:
			begin
				tempRed = 8'hFE;
				tempGreen = 8'h06;
				tempBlue = 8'hFF;
			end
			
		endcase
	end
	
endmodule 