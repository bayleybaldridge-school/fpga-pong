module paddle(
	input [1:0] u_input,
	input [9:0] init_x,
	output [9:0] paddle_x,
	output [9:0] paddle_y,
	input clk
);

parameter [11:0] SPEED	= 12'd5;
parameter [9:0] START_Y = 10'd220;
parameter [9:0] PADDLE_TOP_BOUND	= 12'd5;
parameter [9:0] PADDLE_BOTTOM_BOUND	= 12'd415;
reg [32:0] paddlespeed;

initial begin //at the start of the program make the ball in the center
 paddle_y = START_Y;
end
 
always_ff @(posedge clk) begin

	paddlespeed = paddlespeed +1;

	// Anchor paddle to correct X coordinate
	paddle_x = init_x;
		
	if(paddlespeed >800000) begin //after 1000 cycles of the pixel clock actually move the ball	
		paddlespeed = 0;
		
		// Moving the paddle by 5 pixels in the direction of movement
		
		if( (u_input[0:0] == 1) && (paddle_y < PADDLE_BOTTOM_BOUND) ) begin
			paddle_y = paddle_y + SPEED;
		end
		
		if( (u_input[1:1] == 1) && (paddle_y > PADDLE_TOP_BOUND) ) begin
			paddle_y = paddle_y - SPEED;
		end

		end
end
	
endmodule

