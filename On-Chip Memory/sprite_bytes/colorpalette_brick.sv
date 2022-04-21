module color_palette_brick (input [3:0] data_in, 

output [7:0] red_brickdata, green_brickdata, blue_brickdata);

logic [7:0] tempRed, tempGreen, tempBlue;
	assign red_brickdata = tempRed;
	assign green_brickdata = tempGreen;
	assign blue_brickdata = tempBlue;
	
	//'0x0D1000', '0x252108', '0x2F2013', '0x3D210E', '0x5B301B', '0x6E381C', '0x8F4D2A', '0x8A4D21', 
	//'0xCB6C3D', '0xB46E27', '0xD88E46', '0xFE06FF', '0xB27721'
	always_comb begin
		case(data_in)
			4'b0000: begin
				tempRed = 8'h0D; 
				tempGreen = 8'h10;
				tempBlue = 8'h00;
			end
			4'b0001: begin
				tempRed = 8'h25;
				tempGreen = 8'h21;
				tempBlue = 8'h08;
			end
			4'b0010: begin
				tempRed = 8'h2F;
				tempGreen = 8'h20;
				tempBlue = 8'h13;
			end
			4'b0011: begin
				tempRed = 8'h3D;
				tempGreen = 8'h21;
				tempBlue = 8'h0E;
			end
			4'b0100: begin
				tempRed = 8'h5B;
				tempGreen = 8'h30;
				tempBlue = 8'h1B;
			end
			4'b0101: begin
				tempRed = 8'h6E;
				tempGreen = 8'h38;
				tempBlue = 8'h1C;
			end
			4'b0110: begin
				tempRed = 8'h8F;
				tempGreen = 8'h4D;
				tempBlue = 8'h2A;
			end
			4'b0111: begin
				tempRed = 8'h8A;
				tempGreen = 8'h4D;
				tempBlue = 8'h21;
			end
			4'b1000: begin
				tempRed = 8'hCB;
				tempGreen = 8'h6C;
				tempBlue = 8'h3D;
			end
			4'b1001: begin
				tempRed = 8'hB4;
				tempGreen = 8'h6E;
				tempBlue = 8'h27;
			end
			4'b1010: begin
				tempRed = 8'hD8;
				tempGreen = 8'h8E;
				tempBlue = 8'h46;
			end
			4'b1011: begin
				tempRed = 8'hFE;
				tempGreen = 8'h06;
				tempBlue = 8'hFF;
			end
			4'b1100: begin
				tempRed = 8'hB2;
				tempGreen = 8'h77;
				tempBlue = 8'h21;
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