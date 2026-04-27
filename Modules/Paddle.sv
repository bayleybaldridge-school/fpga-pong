module paddle(
	input [1:0] u_input,
	input [9:0] init_x,
	output [9:0] paddle_x,
	output [9:0] paddle_y,
	input clk
);

//to do write sick code that does the math to move a ball from one side of the 


// create small rectangle
// have it move on the clock at a reasonable speed
// check if it is on the same x level as the paddle
// output its y level if its on the x level as any paddle so it knows to bounce off
		//maybe put output here and move to a new module for collision stuff
//be able to take in that its collidied and assign it new angle



//state machine concept

// exist
// move to left or right
// go back to moving
// check if collided
// change direction
// return to move left or right


//what is a box?
/*
	input [9:0] X_pix,
	input [9:0] Y_pix,
	input [9:0] box_width,
	input [9:0] box_height,
	input [9:0] box_x_location,
	input [9:0] box_y_location,
	input pixel_clk,
	output box
*/

//reg [11:0] ballx;
//reg [11:0] bally;
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
		
				
		/*
		//ballx = 5*(ball_dir_x) + ballx;
		if(ball_dir_x==1) begin
			ballx = (ballx+5);
			
			if(ballx > 600) begin
				ball_dir_x = -1;
			end
		end
		
		if(ball_dir_x==-1) begin
			ballx = (ballx-5);
			
			if(ballx < 50) begin
				ball_dir_x = 1;
			end
		end
		
		
				if(ball_dir_y==1) begin
			bally = (bally+5);
			
			if(bally > 450) begin
				ball_dir_y = -1;
			end
		end
		
		if(ball_dir_y==-1) begin
			bally = (bally-5);
			
			if(bally < 50) begin
				ball_dir_y = 1;
			end
		end
		*/
		end
end
	
endmodule

