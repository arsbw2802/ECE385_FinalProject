module goombaRAM (

                input [3:0] data_in,

                input [18:0] WRITE_ADDR, READ_ADDR,

                input WE, CLK,

               

                output logic [3:0] data_out);

               

               

logic [3:0] mem [1049:0]; // change the size according to the size of the sprite

// x -> 22

// y -> 30

 

initial
begin
		$readmemh("gommba_new_3.txt",mem); //filename for the character we want

 

end

 

always_ff @(posedge CLK) begin

                if(WE)

                                mem [WRITE_ADDR] <= data_in;

                                data_out <= mem[READ_ADDR];

                               

end

endmodule

