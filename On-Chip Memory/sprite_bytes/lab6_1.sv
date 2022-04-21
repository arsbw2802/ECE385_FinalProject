/*---------------------------------------------------------------------------
  --      lab61.sv                                                          --
  --      Christine Chen                                                   --
  --      10/23/2013                                                       --
  --      modified by Zuofu Cheng                                          --
  --      For use with ECE 385                                             --
  --      UIUC ECE Department                                              --
  ---------------------------------------------------------------------------*/
// Top-level module that integrates the Nios II system with the rest of the hardware

module lab6_1(  	 	  //input	        MAX10_CLK1_50,
						input CLOCK_50, 

					  input  [1:0]  KEY,
					  input [7:0] SW,
					  output [7:0]  LEDR,
					  output [12:0] DRAM_ADDR,
					  output [1:0]  DRAM_BA,
					  output        DRAM_CAS_N,
					  output	    DRAM_CKE,
					  output	    DRAM_CS_N,
					  inout  [15:0] DRAM_DQ,
					  output[1:0]	DRAM_DQM,
					  //output 		DRAM_UDQM,
					  output	    DRAM_RAS_N,
					  output	    DRAM_WE_N,
					  output	    DRAM_CLK
				  
				  );
				  
				  // You need to make sure that the port names here are identical to the port names at 
				  // the interface in lab61_soc.v
				  lab6_1_soc m_lab6_1_soc (.clk_clk(CLOCK_50),
											 .reset_reset_n(KEY[0]), 
											 .led_wire_export(LEDR),
											//SDRAM
											.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
											.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
											.sdram_wire_ba(DRAM_BA),                             //.ba
											.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
											.sdram_wire_cke(DRAM_CKE),                           //.cke
											.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
											.sdram_wire_dq(DRAM_DQ),                             //.dq
											.sdram_wire_dqm({DRAM_DQM[1],DRAM_DQM[0]}),              //.dqm
											.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
											.sdram_wire_we_n(DRAM_WE_N),                          //.we_n
											.switch_wire_export(SW),
											.key_wire_export(KEY)
											);
											 
				//Instantiate additional FPGA fabric modules as needed		  
endmodule