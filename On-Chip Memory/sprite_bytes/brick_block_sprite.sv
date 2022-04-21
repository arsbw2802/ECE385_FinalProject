module brickRAM (
	input [3:0] data_in, 
	input [18:0] WRITE_ADDR, READ_ADDR, 
	input WE, CLK,
	
	output logic [3:0] data_out);
	
	
logic [3:0] mem [1799:0]; // change the size according to the size of the sprite
// x -> 20
// y -> 40

initial
begin
		$readmemh("brick_blocks_pink.txt",mem); //filename for the character we want

end

always_ff @(posedge CLK) begin
	if(WE)
		mem [WRITE_ADDR] <= data_in;
		data_out <= mem[READ_ADDR];
		
end
endmodule