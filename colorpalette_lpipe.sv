module color_palette_longpipe (input [3:0] data_in, 

output [7:0] red_lpipedata, green_lpipedata, blue_lpipedata);

logic [7:0] tempRed, tempGreen, tempBlue;
	assign red_lpipedata = tempRed;
	assign green_lpipedata = tempGreen;
	assign blue_lpipedata = tempBlue;
	
	//'0x0D1000', '0x252108', '0x2F2013', '0x3D210E', '0x5B301B', '0x6E381C', '0x8F4D2A', '0x8A4D21', 
	//'0xCB6C3D', '0xB46E27', '0xD88E46', '0xFE06FF', '0xB27721'
	
	
	//'0x023701', '0x075004', '0x116910', '0x208a1b', '0x41c23a', 
	//'0x66ee6a', '0x4bd844', '0x6cee71', '0x0e620d', '0x4dda49', '0xfe06ff'
	always_comb begin
		case(data_in)
			4'b0000: begin
				tempRed = 8'h02; 
				tempGreen = 8'h37;
				tempBlue = 8'h01;
			end
			4'b0001: begin
				tempRed = 8'h07;
				tempGreen = 8'h50;
				tempBlue = 8'h04;
			end
			4'b0010: begin
				tempRed = 8'h11;
				tempGreen = 8'h69;
				tempBlue = 8'h10;
			end
			4'b0011: begin
				tempRed = 8'h20;
				tempGreen = 8'h8a;
				tempBlue = 8'h1b;
			end
			4'b0100: begin
				tempRed = 8'h41;
				tempGreen = 8'hc2;
				tempBlue = 8'h3a;
			end
			4'b0101: begin
				tempRed = 8'h66;
				tempGreen = 8'hee;
				tempBlue = 8'h6a;
			end
			4'b0110: begin
				tempRed = 8'h4b;
				tempGreen = 8'hd8;
				tempBlue = 8'h44;
			end
			4'b0111: begin
				tempRed = 8'h6c;
				tempGreen = 8'hee;
				tempBlue = 8'h71;
			end
			4'b1000: begin
				tempRed = 8'h0e;
				tempGreen = 8'h62;
				tempBlue = 8'h0D;
			end
			4'b1001: begin
				tempRed = 8'h4d;
				tempGreen = 8'hda;
				tempBlue = 8'h49;
			end
			4'b1010: begin
				tempRed = 8'hFE;
				tempGreen = 8'h06;
				tempBlue = 8'hFF;
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