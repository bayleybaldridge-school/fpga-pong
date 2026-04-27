module paddle(
	input [1:0] u_input,
	input [9:0] init_x,
	output [9:0] paddle_x,
	output [9:0] paddle_y,
	input clk
);

parameter [11:0] ONEPIXEL	= 12'd1;
parameter [9:0] START_Y = 10'd220;
parameter [9:0] PADDLE_TOP_BOUND	= 12'd5;
parameter [9:0] PADDLE_BOTTOM_BOUND	= 12'd415;
parameter [12:0] PADDLE_PHYSICS_RATE = 12'd160000;
reg [32:0] paddlespeed;

initial begin //at the start of the program make the ball in the center
 paddle_y = START_Y;
end
 
always_ff @(posedge clk) begin

	paddlespeed = paddlespeed +1;

	// Anchor paddle to correct X coordinate
	paddle_x = init_x;
		
	if(paddlespeed > PADDLE_PHYSICS_RATE) begin
	
		paddlespeed = 0;
		
		// Moving the paddle by 1 pixel in the direction of movement
		
		if( (u_input[0:0] == 1) && (paddle_y < PADDLE_BOTTOM_BOUND) ) begin
			paddle_y = paddle_y + ONEPIXEL;
		end
		
		if( (u_input[1:1] == 1) && (paddle_y > PADDLE_TOP_BOUND) ) begin
			paddle_y = paddle_y - ONEPIXEL;
		end

		end
end
	
endmodule

