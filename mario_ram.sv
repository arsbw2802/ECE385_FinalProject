module marioRAM (
	input [3:0] data_in, 
	input [18:0] WRITE_ADDR, READ_ADDR, 
	input WE, CLK,
	
	output logic [3:0] data_out);
	
	
logic [3:0] mem [2399:0]; // change the size according to the size of the sprite
// x -> 20
// y -> 40

initial
begin
		$readmemh("mario-jump_pink.txt",mem, 0, 799); //filename for the character we want
		$readmemh("mario-jump2_pink.txt",mem, 800, 1599);
		$readmemh("mario-jump3_pink.txt",mem, 1600, 2399);
end

always_ff @(posedge CLK) begin
	if(WE)
		mem [WRITE_ADDR] <= data_in;
		data_out <= mem[READ_ADDR];
		
end
endmodule
