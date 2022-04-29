module color_palette_goomba (input [3:0] data_in,

output [7:0] red_goombadata, green_goombadata, blue_goombadata);

logic [7:0] tempRed, tempGreen, tempBlue;

assign red_goombadata = tempRed;

assign green_goombadata = tempGreen;

assign blue_goombadata = tempBlue;



// '0xad6541', '0x0f061d', '0xf4f7f9', '0xccd1d5', '0x33251d', 
// '0x4d480a', '0x745e3a', '0x2d2223', '0x91835a', '0x352824', '0xfe06ff'


/*goomba_new2
'0x371b30' , '0xfe06ff' // (OR FE06FF), '0x714e32', '0x4e392c', '0x6b5336', '0x372923', '0x756149', '0xd3d7da', 
               '0xad683f', '0xf2f3f3', '0x7b492e', '0x35383b', '0x6b402a'
*/ 


always_comb begin

case(data_in)

4'b0000: begin

tempRed = 8'h37;

tempGreen = 8'h1b;

tempBlue = 8'h30;

end

4'b0001: begin

tempRed = 8'hFF;

tempGreen = 8'hff;

tempBlue = 8'hff;

end

4'b0010: begin

tempRed = 8'h71;

tempGreen = 8'h4e;

tempBlue = 8'h32;

end

4'b0011: begin

tempRed = 8'h4e;

tempGreen = 8'h39;

tempBlue = 8'h2c;

end

4'b0100: begin

tempRed = 8'h6b;

tempGreen = 8'h53;

tempBlue = 8'h36;

end

4'b0101: begin

tempRed = 8'h37;

tempGreen = 8'h29;

tempBlue = 8'h23;

end

4'b0110: begin

tempRed = 8'h75;

tempGreen = 8'h61;

tempBlue = 8'h49;

end

4'b0111: begin

tempRed = 8'hd3;

tempGreen = 8'hd7;

tempBlue = 8'hda;

end

4'b1000: begin

tempRed = 8'had;

tempGreen = 8'h68;

tempBlue = 8'h3f;

end

4'b1001: begin

tempRed = 8'hf2;

tempGreen = 8'hf3;

tempBlue = 8'hf3;

end

4'b1010: begin

tempRed = 8'h7b;

tempGreen = 8'h49;

tempBlue = 8'h2e;

end

4'b1011: begin

tempRed = 8'h35;

tempGreen = 8'h38;

tempBlue = 8'h3b;

end

4'b1100: begin

tempRed = 8'h6b;
tempGreen = 8'h40;
tempBlue = 8'h2a;

end


default: begin

tempRed = 8'hff;

tempGreen = 8'hff;

tempBlue = 8'hff;

end

endcase

end

endmodule

 