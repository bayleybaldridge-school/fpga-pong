// either this 
`include "./Modules/DE10_VGA.sv"
`include "./Modules/Ball.sv"
// XOR "Project Navigator" > "File" > Add files > DE10_VGA.v
// not both

module pong(
    //////////// CLOCK //////////
    input                       ADC_CLK_10,
    input                       MAX10_CLK1_50,
    input                       MAX10_CLK2_50,

    //////////// SDRAM //////////
    output          [12:0]      DRAM_ADDR,
    output           [1:0]      DRAM_BA,
    output                      DRAM_CAS_N,
    output                      DRAM_CKE,
    output                      DRAM_CLK,
    output                      DRAM_CS_N,
    inout           [15:0]      DRAM_DQ,
    output                      DRAM_LDQM,
    output                      DRAM_RAS_N,
    output                      DRAM_UDQM,
    output                      DRAM_WE_N,

    //////////// SEG7 //////////
    output           [7:0]      HEX0,
    output           [7:0]      HEX1,
    output           [7:0]      HEX2,
    output           [7:0]      HEX3,
    output           [7:0]      HEX4,
    output           [7:0]      HEX5,

    //////////// KEY //////////
    input            [1:0]      KEY,

    //////////// LED //////////
    output           [9:0]      LEDR,

    //////////// SW //////////
    input            [9:0]      SW,

    //////////// VGA //////////
    output           [3:0]      VGA_B, //Output Blue
    output           [3:0]      VGA_G, //Output Green
    output           [3:0]      VGA_R, //Output Red
    output                      VGA_HS,//Horizontal Sync
    output                      VGA_VS,//Vertical Sync

    //////////// Accelerometer //////////
    output                      GSENSOR_CS_N,
    input            [2:1]      GSENSOR_INT,
    output                      GSENSOR_SCLK,
    inout                       GSENSOR_SDI,
    inout                       GSENSOR_SDO,

    ///////// GPIO /////////
    inout           [35: 0]   GPIO,

    //////////// Arduino //////////
    inout           [15:0]      ARDUINO_IO,
    inout                       ARDUINO_RESET_N
 );

wire			[9:0]		X_pix;			// Location in X of the driver
wire			[9:0]		Y_pix;			// Location in Y of the driver

wire			[0:0]		H_visible;		//H_blank?
wire			[0:0]		V_visible;		//V_blank?

wire		   [0:0]		pixel_clk;		//Pixel clock. Every clock a pixel is being drawn. 
wire			[9:0]		pixel_cnt;		//How many pixels have been output.

reg			[11:0]		pixel_color;	//12 Bits representing color of pixel, 4 bits for R, G, and B
										//4 bits for Red are in most significant position, Blue in least

parameter [11:0] WIDTH    = 12'd640;
parameter [11:0] HEIGHT   = 12'd480;
parameter [11:0] TWO      = 12'd2;
parameter [11:0] FIVE     = 12'd5;
parameter [11:0] SEVEN    = 12'd7;
parameter [11:0] THIRTEEN = 12'd13;





// Drawing happens here, one pixel at a time
always_ff @(posedge pixel_clk) begin
		// 
		// I ALSO WROTE THIS LITTLE SECTION HERE
		//
		if (box) begin
			pixel_color <= 12'b1111_0000_1111; // magenta
		end else if (box2) begin
			pixel_color <= 12'b0000_1111_1111; // teal
		end else if (box3) begin
			pixel_color <= 12'b1111_1111_0000; // brown?
		end
		
		if(ball) begin
			pixel_color <=12'b1111_0000_1111;
		end
		else begin
			pixel_color <=12'b0000_0000_0000;
		
		end
		//
		//
		/*// you can use X_pix and Y_pix location to draw a pixel color
		 end else if (X_pix < (WIDTH*TWO)/FIVE && Y_pix < (HEIGHT*SEVEN)/THIRTEEN) begin
			// Red[3:0]_Green[3:0]_Blue[3:0]
			pixel_color <= 12'b1111_0000_0000; // red
		end else if ( // What does this condition say?
			(Y_pix % ((HEIGHT*TWO)/THIRTEEN) > HEIGHT/THIRTEEN)
		) begin
			pixel_color <= 12'b1111_1111_1111; // white
		end else begin
			pixel_color <= 12'b0000_0000_1111; // blue
		end
		*/
		
end
	
//Pass pins and current pixel values to display driver
DE10_VGA VGA_Driver
(
	.clk_50(MAX10_CLK1_50),   // input to the driver
	.pixel_color(pixel_color), // input to the driver
	.VGA_BUS_R(VGA_R),         // output
	.VGA_BUS_G(VGA_G),         // output
	.VGA_BUS_B(VGA_B),         // output
	.VGA_HS(VGA_HS),           // output
	.VGA_VS(VGA_VS),           // output
	.X_pix(X_pix),             // output what pixel we are drawing right now
	.Y_pix(Y_pix),             // output what pixel we are drawing right now
	.H_visible(H_visible),     // H_blank?
	.V_visible(V_visible),
	.pixel_clk(pixel_clk),     // Pixel clock. Every clock a pixel is being drawn.
	.pixel_cnt(pixel_cnt)
);

// I WROTE ALL OF THIS BELOW HERE
	
	reg box;
	reg box2;
	reg box3;
	reg ball;
	
		
	reg [9:0] ballx;
	reg [9:0] bally;



	//make_box customA (.X_pix(X_pix), .Y_pix(Y_pix), .box_width(10'b100000000), .box_height(10'b10000000),
	//.box_x_location(10'b1000000), .box_y_location(10'b10000000), .pixel_clk(pixel_clk), .box(box));
	
	//make_box customB (.X_pix(X_pix), .Y_pix(Y_pix), .box_width(10'b100000), .box_height(10'b10000000),
	//.box_x_location(10'b100000000), .box_y_location(10'b10000), .pixel_clk(pixel_clk), .box(box2));
	
	//make_box customC (.X_pix(X_pix), .Y_pix(Y_pix), .box_width(10'b10000000), .box_height(10'b1000000),
	//.box_x_location(10'b1000000000), .box_y_location(10'b10000000), .pixel_clk(pixel_clk), .box(box3)); //these look bad
	
	
		ball betternamesoon (
		.clk(MAX10_CLK2_50),
		.ballx(ballx),
		.bally(bally)
	);
	
	make_box balllocation (
		.X_pix(X_pix),
		.Y_pix(Y_pix),
		.box_width(12'd10),
		.box_height(12'd10),
		.box_x_location(ballx),
		.box_y_location(bally),
		.pixel_clk(pixel_clk),
		.box(ball)
	);

endmodule

module make_box (
	input [9:0] X_pix,
	input [9:0] Y_pix,
	input [9:0] box_width,
	input [9:0] box_height,
	input [9:0] box_x_location,
	input [9:0] box_y_location,
	input pixel_clk,
	output box
);

always @(posedge pixel_clk) begin

	if((X_pix > box_x_location)&&(X_pix<(box_x_location+box_width))&&(Y_pix>box_y_location)&&(Y_pix<(box_y_location+box_height))) begin
		box=1;
	end else begin
		box=0;
	end
end

endmodule