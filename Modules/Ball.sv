module ball(
	output [9:0] ballx,
	output [9:0] bally,
	input clk
);


parameter [11:0] STARTX	= 12'd320;
parameter [11:0] STARTY	= 12'd240;

parameter [11:0] LEFTPADDLE =12'd200; //wrong rn but will be the x location where the left paddle is
parameter [11:0] RIGHTPADDLE =12'd200; //" 														  right paddle is

reg signed [11:0] ball_speed_x;
reg signed [11:0] ball_speed_y;
reg [32:0] ballspeed;
reg signed [3:0] ball_dir_x;
reg signed [3:0] ball_dir_y;

initial begin //at the start of the program make the ball in the center
 ballx = STARTX;
 bally = STARTY;
 ball_dir_x = 1;
 ball_dir_y = 1;
end
 
always_ff @(posedge clk) begin

	ballspeed = ballspeed +1;
		
	if(ballspeed >300000) begin
		ballspeed = 0;

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
		
	end
	
end
	
endmodule

