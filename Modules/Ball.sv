module ball(
	output [9:0] ballx,
	output [9:0] bally,
	input [9:0] l_paddle_y,
	input [9:0] r_paddle_y,
	input [11:0] paddle_height,
	input [9:0] ball_height,
	output [7:0] l_score,
	output [7:0] r_score,
	output sound_pin,
	input reset_sw,
	input clk
);


parameter [11:0] STARTX	= 12'd320;
parameter [11:0] STARTY	= 12'd240;

parameter [3:0] ONEPIXEL = 4'd1;
parameter [31:0] BALL_PHYSICS_RATE = 32'd200000;

reg signed [11:0] ball_speed_x;
reg signed [11:0] ball_speed_y;
reg [32:0] ballspeed;
reg signed [3:0] ball_dir_x;
reg signed [3:0] ball_dir_y;

initial begin //at the start of the program make the ball in the center
 ballx = STARTX;
 bally = STARTY;
 ball_dir_x = -1;
 ball_dir_y = 1;
 l_score = 0;
 r_score = 0;
end
 
always_ff @(posedge clk) begin

	if(reset_sw == 0) begin
		ballx = STARTX;
		bally = STARTY;
		l_score = 0;
		r_score = 0;
	end
	
	if( (l_score > 6) || (r_score > 6) ) begin
		ballx = STARTX;
		bally = STARTY;
	end

	ballspeed = ballspeed +1;
		
	if(ballspeed > BALL_PHYSICS_RATE) begin
		ballspeed = 0;
		
		// Turn off sound
		sound_pin = 0;
		
		// Ball collision checks and changing direction
		if(ballx > 610) begin
			// Top half of right paddle collision
			if ( ( r_paddle_y <= (bally + (ball_height / 2)) ) && ( (bally + (ball_height / 2)) <= (r_paddle_y + (paddle_height / 2)) ) ) begin
				ball_dir_x = -1;
				ball_dir_y = -1;
				
				// Turn on sound
				sound_pin = 1;
				
			end
			// Bottom half of right paddle collision
			else if ( ( (r_paddle_y + (paddle_height / 2)) <= (bally + (ball_height / 2)) ) && ( (bally + (ball_height / 2)) <= (r_paddle_y + paddle_height) ) ) begin
				ball_dir_x = -1;
				ball_dir_y = 1;
				
				// Turn on sound
				sound_pin = 1;
				
			end
			else begin
				ballx = STARTX;
				bally = STARTY;
				ball_dir_x = -1;
				ball_dir_y = 0;
				
				// Give point to left player
				l_score = l_score + 1;
				
			end
		end
		else if(ballx < 20) begin
			// Top half of left paddle collision
			if ( ( l_paddle_y <= (bally + (ball_height / 2)) ) && ( (bally + (ball_height / 2)) <= (l_paddle_y + (paddle_height / 2)) ) ) begin
				ball_dir_x = 1;
				ball_dir_y = -1;
				
				// Turn on sound
				sound_pin = 1;
				
			end
			// Bottom half of left paddle collision
			else if ( ( (l_paddle_y + (paddle_height / 2)) <= (bally + (ball_height / 2)) ) && ( (bally + (ball_height / 2))<= (l_paddle_y + paddle_height) ) ) begin
				ball_dir_x = 1;
				ball_dir_y = 1;
				
				// Turn on sound
				sound_pin = 1;
						
			end
			else begin
				ballx = STARTX;
				bally = STARTY;
				ball_dir_x = 1;
				ball_dir_y = 0;
				
				// Give point to right player
				r_score = r_score + 1;
				
			end
		end
		
		// Check for collision with top or bottom of screen
		if(bally > 465) begin
			ball_dir_y = -1;
			
			// Turn on sound
			sound_pin = 1;
				
		end
		else if(bally < 5) begin
			ball_dir_y = 1;
			
			// Turn on sound
			sound_pin = 1;
			
		end
		
		// Ball movement
		
		if(ball_dir_x==1) begin
			ballx = (ballx + ONEPIXEL);
		end
		else if (ball_dir_x==-1) begin
			ballx = (ballx - ONEPIXEL);
		end
		
		if(ball_dir_y==1) begin
			bally = (bally + ONEPIXEL);
		end
		else if (ball_dir_y==-1) begin
			bally = (bally - ONEPIXEL);
		end
	end
	
end
	
endmodule

