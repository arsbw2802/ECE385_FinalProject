module yoshi_color_palette (input [3:0] data_in, 

output [7:0] red_yoshidata, green_yoshidata, blue_yoshidata);

logic [7:0] tempRed, tempGreen, tempBlue;
	assign red_yoshidata = tempRed;
	assign green_yoshidata = tempGreen;
	assign blue_yoshidata = tempBlue;
	
	//0x00a500', '0x007a00', '0x005100', '0x000000', '0xffffff', '0x005800', 
    //'0xb2b0b3', '0xff2a2d', '0xb20000', '0x880000' , '0xfc7e00', '0xff7318', 
    //'0xdc5000', '0xccb900', '0xa1a43f', '0x7d7e7d', '0xfe06ff'
	always_comb begin
		case(data_in)
			4'b0000: begin
				tempRed = 8'h00; 
				tempGreen = 8'ha5;
				tempBlue = 8'h00;
			end
			4'b0001: begin
				tempRed = 8'h00;
				tempGreen = 8'h7a;
				tempBlue = 8'h00;
			end
			4'b0010: begin
				tempRed = 8'h00;
				tempGreen = 8'h51;
				tempBlue = 8'h00;
			end
			4'b0011: begin
				tempRed = 8'h00;
				tempGreen = 8'h00;
				tempBlue = 8'h00;
			end
			4'b0100: begin
				tempRed = 8'hff;
				tempGreen = 8'hff;
				tempBlue = 8'hff;
			end
			4'b0101: begin
				tempRed = 8'hb2;
				tempGreen = 8'hb0;
				tempBlue = 8'hb3;
			end
			4'b0110: begin
				tempRed = 8'hff;
				tempGreen = 8'h2a;
				tempBlue = 8'h2d;
			end
			4'b0111: begin
				tempRed = 8'hb2;
				tempGreen = 8'h00;
				tempBlue = 8'h00;
			end
			4'b1000: begin
				tempRed = 8'h88;
				tempGreen = 8'h00;
				tempBlue = 8'h00;
			end
			4'b1001: begin
				tempRed = 8'hfc;
				tempGreen = 8'h7e;
				tempBlue = 8'h00;
			end
			4'b1010: begin
				tempRed = 8'hff;
				tempGreen = 8'h73;
				tempBlue = 8'h18;
			end
			4'b1011: begin
				tempRed = 8'hdc;
				tempGreen = 8'h50;
				tempBlue = 8'h00;
			end
			4'b1100: begin
				tempRed = 8'hcc;
				tempGreen = 8'hb9;
				tempBlue = 8'h00;
			end	
			4'b1101: begin
				tempRed = 8'ha1;
				tempGreen = 8'ha4;
				tempBlue = 8'h3f;
			end
			4'b1110: begin
				tempRed = 8'ha1;
				tempGreen = 8'ha4;
				tempBlue = 8'h3f;
			end
            4'b1110: begin
				tempRed = 8'h7d;
				tempGreen = 8'h7e;
				tempBlue = 8'h7d;
			end
            4'b1111: begin
				tempRed = 8'hfe;
				tempGreen = 8'h06;
				tempBlue = 8'hff;
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