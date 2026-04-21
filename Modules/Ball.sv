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
reg signed [2:0] ball_dir_x;
reg signed [2:0] ball_dir_y;

initial begin //at the start of the program make the ball in the center
 ballx = STARTX;
 bally = STARTY;
 ball_dir_x = -1;
 ball_speed_x =10;
 ball_speed_y =10;
end
 
always_ff @(posedge clk) begin

ballspeed = ballspeed +1;
		
	if(ballspeed >500000) begin //after 1000 cycles of the pixel clock actually move the ball	
		ballspeed = 0;
		//balldir = 0;
		bally = ((ball_speed_y*ball_dir_y) + bally); //ball's movement in the y direction
		ballx = ((ball_speed_x*ball_dir_x) + ballx); //in the x direction
	end
	if(ballx == LEFTPADDLE) begin //on a per paddle basis is way easier than doing both at the same time 
	
		//does bally = paddle y
		//where on the paddle does it hit?
		//change direction by how far it is on the paddle 
			//eg dead center = balldir +180 ? you might need to do something fancy with multiplication?
	end
	
	if(((ballx+10) >= 600)) begin //what do we do if we touch a wall?
		//freak the fuck out //if ball is going right make it go left
			ball_dir_x = -1;
			ballx = 550;

	end
	
	if((ballx =0)) begin //if ball is going left make it go right
			ball_dir_x = 1; 
			ballx = 10;
	end
	
	if(((bally+10) >= 270) || (bally = 0)) begin
			if(ball_dir_y>=0) //if ball is going up
			ball_dir_y = -ball_dir_y;
		if(ball_dir_y<0) //if ball is going up make it go down
			ball_dir_y = -ball_dir_y;
	end
end
	
endmodule

