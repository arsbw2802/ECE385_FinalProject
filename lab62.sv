//-------------------------------------------------------------------------
//                                                                       --
//                                                                       --
//      For use with ECE 385 Lab 62                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab62 (

      ///////// Clocks /////////
      input     MAX10_CLK1_50, 

      ///////// KEY /////////
      input    [ 1: 0]   KEY,

      ///////// SW /////////
      input    [ 9: 0]   SW,

      ///////// LEDR /////////
      output   [ 9: 0]   LEDR,

      ///////// HEX /////////
      output   [ 7: 0]   HEX0,
      output   [ 7: 0]   HEX1,
      output   [ 7: 0]   HEX2,
      output   [ 7: 0]   HEX3,
      output   [ 7: 0]   HEX4,
      output   [ 7: 0]   HEX5,

      ///////// SDRAM /////////
      output             DRAM_CLK,
      output             DRAM_CKE,
      output   [12: 0]   DRAM_ADDR,
      output   [ 1: 0]   DRAM_BA,
      inout    [15: 0]   DRAM_DQ,
      output             DRAM_LDQM,
      output             DRAM_UDQM,
      output             DRAM_CS_N,
      output             DRAM_WE_N,
      output             DRAM_CAS_N,
      output             DRAM_RAS_N,

      ///////// VGA /////////
      output             VGA_HS,
      output             VGA_VS,
      output   [ 3: 0]   VGA_R,
      output   [ 3: 0]   VGA_G,
      output   [ 3: 0]   VGA_B,


      ///////// ARDUINO /////////
      inout    [15: 0]   ARDUINO_IO,
      inout              ARDUINO_RESET_N 

);




logic Reset_h, vssig, blank, sync, VGA_Clk;


//=======================================================
//  REG/WIRE declarations
//=======================================================
	logic SPI0_CS_N, SPI0_SCLK, SPI0_MISO, SPI0_MOSI, USB_GPX, USB_IRQ, USB_RST;
	logic [3:0] hex_num_4, hex_num_3, hex_num_1, hex_num_0; //4 bit input hex digits
	logic [1:0] signs;
	logic [1:0] hundreds;
	logic [9:0] drawxsig, drawysig, ballxsig, ballysig, ballsizesigx, ballsizesigy;
	logic [7:0] Red, Blue, Green;
	logic [7:0] keycode, keycode1;

//=======================================================
//  Structural coding
//=======================================================
	assign ARDUINO_IO[10] = SPI0_CS_N;
	assign ARDUINO_IO[13] = SPI0_SCLK;
	assign ARDUINO_IO[11] = SPI0_MOSI;
	assign ARDUINO_IO[12] = 1'bZ;
	assign SPI0_MISO = ARDUINO_IO[12];
	
	assign ARDUINO_IO[9] = 1'bZ; 
	assign USB_IRQ = ARDUINO_IO[9];
		
	//Assignments specific to Circuits At Home UHS_20
	assign ARDUINO_RESET_N = USB_RST;
	assign ARDUINO_IO[7] = USB_RST;//USB reset 
	assign ARDUINO_IO[8] = 1'bZ; //this is GPX (set to input)
	assign USB_GPX = 1'b0;//GPX is not needed for standard USB host - set to 0 to prevent interrupt
	
	//Assign uSD CS to '1' to prevent uSD card from interfering with USB Host (if uSD card is plugged in)
	assign ARDUINO_IO[6] = 1'b1;
	
	//HEX drivers to convert numbers to HEX output
	HexDriver hex_driver4 (hex_num_4, HEX4[6:0]);
	assign HEX4[7] = 1'b1;
	
	HexDriver hex_driver3 (hex_num_3, HEX3[6:0]);
	assign HEX3[7] = 1'b1;
	
	HexDriver hex_driver1 (hex_num_1, HEX1[6:0]);
	assign HEX1[7] = 1'b1;
	
	HexDriver hex_driver0 (hex_num_0, HEX0[6:0]);
	assign HEX0[7] = 1'b1;
	
	//fill in the hundreds digit as well as the negative sign
	assign HEX5 = {1'b1, ~signs[1], 3'b111, ~hundreds[1], ~hundreds[1], 1'b1};
	assign HEX2 = {1'b1, ~signs[0], 3'b111, ~hundreds[0], ~hundreds[0], 1'b1};
	
	
	//Assign one button to reset
	assign {Reset_h}=~ (KEY[0]);

	//Our A/D converter is only 12 bit
	assign VGA_R = Red[7:4];
	assign VGA_B = Blue[7:4];
	assign VGA_G = Green[7:4];
	
	logic dummy_reset; 
	assign dummy_reset = 1'b1; 
	lab62_soc u0 (
		.clk_clk                           (MAX10_CLK1_50),  //clk.clk
		.reset_reset_n                     (dummy_reset),           //reset.reset_n
		.altpll_0_locked_conduit_export    (),               //altpll_0_locked_conduit.export
		.altpll_0_phasedone_conduit_export (),               //altpll_0_phasedone_conduit.export
		.altpll_0_areset_conduit_export    (),               //altpll_0_areset_conduit.export
		.key_external_connection_export    (KEY),            //key_external_connection.export

		//SDRAM
		.sdram_clk_clk(DRAM_CLK),                            //clk_sdram.clk
		.sdram_wire_addr(DRAM_ADDR),                         //sdram_wire.addr
		.sdram_wire_ba(DRAM_BA),                             //.ba
		.sdram_wire_cas_n(DRAM_CAS_N),                       //.cas_n
		.sdram_wire_cke(DRAM_CKE),                           //.cke
		.sdram_wire_cs_n(DRAM_CS_N),                         //.cs_n
		.sdram_wire_dq(DRAM_DQ),                             //.dq
		.sdram_wire_dqm({DRAM_UDQM,DRAM_LDQM}),              //.dqm
		.sdram_wire_ras_n(DRAM_RAS_N),                       //.ras_n
		.sdram_wire_we_n(DRAM_WE_N),                         //.we_n

		//USB SPI	
		.spi0_SS_n(SPI0_CS_N),
		.spi0_MOSI(SPI0_MOSI),
		.spi0_MISO(SPI0_MISO),
		.spi0_SCLK(SPI0_SCLK),
		
		//USB GPIO
		.usb_rst_export(USB_RST),
		.usb_irq_export(USB_IRQ),
		.usb_gpx_export(USB_GPX),
		
		//LEDs and HEX
		.hex_digits_export({hex_num_4, hex_num_3, hex_num_1, hex_num_0}),
		.leds_export({hundreds, signs, LEDR}),
		.keycode_export(keycode),
		.keycode1_export(keycode1)
		
	 );
	 
	 
logic [3:0] data_in, ram_data_mario, ram_data_bg, data_in_bg, data_in_brick, ram_data_brick;
logic [18:0] WRITE_ADDR;
logic [18:0] WRITE_ADDR_BG, WRITE_ADDR_BRICK;
logic WE;
logic [7:0] red_mariodata, green_mariodata, blue_mariodata, blue_bg, red_bg, green_bg, blue_brick, green_brick, red_brick;
logic [5:0] logx;


//instantiate a vga_controller, ball, and color_mapper here with the ports.
ball Ball0 (.Reset (Reset_h), .frame_clk(VGA_VS), .keycode(keycode), .keycode1(keycode1),
 .BallX(ballxsig), .BallY (ballysig), .BallSX(ballsizesigx), .BallSY(ballsizesigy), .logx(logx));
					
color_mapper color (.BallX (ballxsig), .BallY (ballysig), .DrawX (drawxsig), .DrawY (drawysig), .Ball_size_X (ballsizesigx), .Ball_size_Y(ballsizesigy),
 .green_mariodata(green_mariodata), .blue_mariodata(blue_mariodata), .red_mariodata(red_mariodata), .red_bgdata(red_bg), .blue_bgdata(blue_bg), .green_bgdata(green_bg), 
 .red_brickdata(red_brick), .green_brickdata(green_brick), .blue_brickdata(blue_brick), .*);

							  
vga_controller vga(.Clk (MAX10_CLK1_50), .Reset(Reset_h), .hs(VGA_HS), .vs (VGA_VS), .pixel_clk(VGA_Clk), .blank (blank), .sync(sync), 
.DrawX(drawxsig), .DrawY(drawysig) ); 

// check the width and height of the read_addr
marioRAM mario_sprite(.data_in(data_in), .WRITE_ADDR(WRITE_ADDR), 
							.READ_ADDR((drawxsig-ballxsig-15)+ (drawysig-ballysig-30)*20), 
							.WE(WE), .CLK(VGA_Clk), .data_out(ram_data_mario));
							
color_palette_mario mario_colored (.data_in(ram_data_mario), .red_mariodata(red_mariodata), .green_mariodata(green_mariodata), .blue_mariodata(blue_mariodata));

backgroundRAM bg(.data_in(data_in_bg), .WRITE_ADDR(WRITE_ADDR_BG), 
						.READ_ADDR(logx + drawxsig+(drawysig)*700) , .WE(WE), 
						.CLK(VGA_Clk), .data_out(ram_data_bg));
						
background_color_palette  bg_colored (.data_in(ram_data_bg), .red_bgdata(red_bg), .green_bgdata(green_bg), .blue_bgdata(blue_bg));

brickRAM brick(.data_in(data_in_brick), .WRITE_ADDR(WRITE_ADDR_BRICK),
					.READ_ADDR((logx + drawxsig - 230) +(drawysig - 250)*90) , .WE(WE), 
					.CLK(VGA_Clk), .data_out(ram_data_brick));
					
color_palette_brick  brick_colored (.data_in(ram_data_brick), .red_brickdata(red_brick), .green_brickdata(green_brick), .blue_brickdata(blue_brick));

endmodule
