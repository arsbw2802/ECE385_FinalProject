module smallpipe_color_palette (input [3:0] data_in, 

output [7:0] red_spipedata, green_spipedata, blue_spipedata);

logic [7:0] tempRed, tempGreen, tempBlue;
    assign red_spipedata = tempRed;
    assign green_spipedata = tempGreen;
    assign blue_spipedata = tempBlue;
    
/*
'0x00b00b', '0x00d911', '0x00c00d', '0x2f5a31', '0x007d00', '0x009107', '0x00c50e', '0x00a006', '0xfe06ff'
*/
    
always_comb
begin
    case(data_in)
    4'b0000: begin
                tempRed = 8'h00; 
                tempGreen = 8'hb0;
                tempBlue = 8'h0b;
            end
            4'b0001: begin
                tempRed = 8'h00;
                tempGreen = 8'hd9;
                tempBlue = 8'h11;
            end
            4'b0010: begin
                tempRed = 8'h00;
                tempGreen = 8'hc0;
                tempBlue = 8'h0d;
            end
            4'b0011: begin
                tempRed = 8'h2f;
                tempGreen = 8'h5a;
                tempBlue = 8'h31;
            end
            4'b0100: begin
                tempRed = 8'h00;
                tempGreen = 8'h7d;
                tempBlue = 8'h00;
            end
            4'b0101: begin
                tempRed = 8'h00;
                tempGreen = 8'h91;
                tempBlue = 8'h07;
            end
            4'b0110: begin
                tempRed = 8'h00;
                tempGreen = 8'hc5;
                tempBlue = 8'h0e;
            end
            4'b0111: begin
                tempRed = 8'h00;
                tempGreen = 8'ha0;
                tempBlue = 8'h06;
            end
            4'b1000: begin
                tempRed = 8'hfe;
                tempGreen = 8'h06;
                tempBlue = 8'hff;
            end
            default:
            begin
                tempRed = 8'hfe;
                tempGreen = 8'h06;
                tempBlue = 8'hff;
            end
            
        endcase
    end

endmodule 