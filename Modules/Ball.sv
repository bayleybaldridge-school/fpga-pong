module ball(
	output [9:0] ballx,
	output [9:0] bally,
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


parameter [11:0] STARTX	= 12'd320;
parameter [11:0] STARTY	= 12'd240;
//parameter [11:0] LEFT 	= 12'd90; //I am sure this is the best way to implement this and this will cause no problems in the future
//parameter [11:0] RIGHT	= 12'd-90;
//parameter [11:0] UP		= 12'd90;
//parameter [11:0] DOWN		= (12'd90)*-1;
parameter [11:0] LEFTPADDLE =12'd200; //wrong rn but will be the x location where the left paddle is
parameter [11:0] RIGHTPADDLE =12'd200; //" 														  right paddle is



//reg [11:0] ballx;
//reg [11:0] bally;
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
		
	if(ballspeed >500000) begin //after 1000 cycles of the pixel clock actually move the ball	
		ballspeed = 0;
		
		
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
		
		
		end
		
	

end
	
endmodule

