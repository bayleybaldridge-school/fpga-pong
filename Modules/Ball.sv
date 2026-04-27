module ball(
	output [9:0] ballx,
	output [9:0] bally,
	input [9:0] l_paddle_y,
	input [9:0] r_paddle_y,
	input [11:0] paddle_height,
	input [9:0] ball_height,
	input reset_sw,
	input clk
);


parameter [11:0] STARTX	= 12'd320;
parameter [11:0] STARTY	= 12'd240;

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
end
 
always_ff @(posedge clk) begin

	if(reset_sw == 0) begin
		ballx = STARTX;
		bally = STARTY;
		ball_dir_x = -1;
		ball_dir_y = 1;
	end

	ballspeed = ballspeed +1;
		
	if(ballspeed >300000) begin
		ballspeed = 0;
		
		// Ball collision checks and changing direction
		
		if(ballx > 610) begin
			// Top half of right paddle collision
			if ( ( r_paddle_y <= (bally + (ball_height / 2)) ) && ( (bally + (ball_height / 2)) <= (r_paddle_y + (paddle_height / 2)) ) ) begin
				ball_dir_x = -1;
				ball_dir_y = -1;
			end
			// Bottom half of right paddle collision
			else if ( ( (r_paddle_y + (paddle_height / 2)) <= (bally + (ball_height / 2)) ) && ( (bally + (ball_height / 2)) <= (r_paddle_y + paddle_height) ) ) begin
				ball_dir_x = -1;
				ball_dir_y = 1;
			end
			else begin
				ballx = STARTX;
				bally = STARTY;
				ball_dir_x = -1;
				ball_dir_y = 1;
			end
		end
		else if(ballx < 20) begin
			// Top half of left paddle collision
			if ( ( l_paddle_y <= (bally + (ball_height / 2)) ) && ( (bally + (ball_height / 2)) <= (l_paddle_y + (paddle_height / 2)) ) ) begin
				ball_dir_x = 1;
				ball_dir_y = -1;
			end
			// Bottom half of left paddle collision
			else if ( ( (l_paddle_y + (paddle_height / 2)) <= (bally + (ball_height / 2)) ) && ( (bally + (ball_height / 2))<= (l_paddle_y + paddle_height) ) ) begin
				ball_dir_x = 1;
				ball_dir_y = 1;
			end
			else begin
				ballx = STARTX;
				bally = STARTY;
				ball_dir_x = -1;
				ball_dir_y = 1;
			end
		end
		
		// Check for collision with top or bottom of screen
		if(bally > 465) begin
			ball_dir_y = -1;
		end
		else if(bally < 5) begin
			ball_dir_y = 1;
		end
		
		
		// Ball movement
		
		if(ball_dir_x==1) begin
			ballx = (ballx+1);
		end
		else if (ball_dir_x==-1) begin
			ballx = (ballx-1);
		end
		
		if(ball_dir_y==1) begin
			bally = (bally+1);
		end
		else if (ball_dir_y==-1) begin
			bally = (bally-1);
		end
		
		//ballx = ballx + ball_dir_x;
		//bally = bally + ball_dir_y;
		
		/*
		if(ball_dir_x==1) begin
			ballx = (ballx+1);
			
			if(ballx > 610) begin
				ball_dir_x = -1;
			end
		end
		
		if(ball_dir_x==-1) begin
			ballx = (ballx-1);
			
			if(ballx < 20) begin
				ball_dir_x = 1;
			end
		end
		
		if(ball_dir_y==1) begin
			bally = (bally+1);
			
			if(bally > 465) begin
				ball_dir_y = -1;
			end
		end
		
		if(ball_dir_y==-1) begin
			bally = (bally-1);
			
			if(bally < 5) begin
				ball_dir_y = 1;
			end
		end
		*/
		
	end
	
end
	
endmodule

