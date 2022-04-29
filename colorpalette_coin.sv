module color_palette_coin (input [3:0] data_in,

output [7:0] red_coindata, green_coindata, blue_coindata);

logic [7:0] tempRed, tempGreen, tempBlue;

assign red_coindata = tempRed;

assign green_coindata = tempGreen;

assign blue_coindata = tempBlue;

//'0xfe06ff', '0xfefefe', '0xfbfbfb', '0x7f7f7f', '0x2a2a2a', '0x0b0b0b',

//'0xc8c8c8', '0xfff100', '0xfbd705', '0xfddd03', '0xfbe87f', '0x141414'

always_comb begin

case(data_in)

4'b0000: begin

tempRed = 8'hFE;

tempGreen = 8'h06;

tempBlue = 8'hFF;

end

4'b0001: begin

tempRed = 8'hFE;

tempGreen = 8'hFE;

tempBlue = 8'hFE;

end

4'b0010: begin

tempRed = 8'hFB;

tempGreen = 8'hFB;

tempBlue = 8'hFB;

end

4'b0011: begin

tempRed = 8'h7F;

tempGreen = 8'h7F;

tempBlue = 8'h7F;

end

4'b0100: begin

tempRed = 8'h2A;

tempGreen = 8'h2A;

tempBlue = 8'h2A;

end

4'b0101: begin

tempRed = 8'h0B;

tempGreen = 8'h0B;

tempBlue = 8'h0B;

end

4'b0110: begin

tempRed = 8'hC8;

tempGreen = 8'hC8;

tempBlue = 8'hC8;

end

4'b0111: begin

tempRed = 8'hFF;

tempGreen = 8'hF1;

tempBlue = 8'h00;

end

4'b1000: begin

tempRed = 8'hFB;

tempGreen = 8'hD7;

tempBlue = 8'h05;

end

4'b1001: begin

tempRed = 8'hFD;

tempGreen = 8'hDD;

tempBlue = 8'h03;

end

4'b1010: begin

tempRed = 8'hFB;

tempGreen = 8'hE8;

tempBlue = 8'h7F;

end

4'b1011: begin

tempRed = 8'h14;

tempGreen = 8'h14;

tempBlue = 8'h14;

end

default: begin

tempRed = 8'hFE;

tempGreen = 8'h06;

tempBlue = 8'hFF;

end

endcase

end

endmodule

 