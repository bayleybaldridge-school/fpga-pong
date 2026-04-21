module ball(
	//output ballx,
	//output bally
	input pixel_clk
	 
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
parameter [11:0] LEFT 	= 12'd90; //I am sure this is the best way to implement this and this will cause no problems in the future
parameter [11:0] RIGHT	= 12'd270;
parameter [11:0] UP		= 12'd0;
parameter [11:0] DOWN		= 12'd180;
parameter [11:0] LEFTPADDLE =12'd200; //wrong rn but will be the x location where the left paddle is
parameter [11:0] RIGHTPADDLE =12'd200; //" 														  right paddle is



reg [11:0] ballx;
reg [11:0] bally;
reg [11:0] balldir;
reg [11:0] ballspeed;

initial begin //at the start of the program make the ball in the center
 ballx = STARTX;
 bally = STARTY;
 balldir = LEFT;
end
 
always_ff @(posedge pixel_clk) begin

ballspeed = ballspeed +1;
		
	if(ballspeed >1000) begin //after 1000 cycles of the pixel clock actually move the ball	
		ballspeed = 0;
		bally= floor(cos(balldir)) + bally; //ball's movement in the y direction
		ballx = floor(sin(balldir)) + ballx; //in the x direction
	end
	if(ballx == LEFTPADDLE) begin //on a per paddle basis is way easier than doing both at the same time 
	
		//does bally = paddle y
		//where on the paddle does it hit?
		//change direction by how far it is on the paddle 
			//eg dead center = balldir +180 ? you might need to do something fancy with multiplication?
	end
	
	if((ballx == 640) || (ballx == 0)) begin //what do we do if we touch a wall?
		//freak the fuck out
		if(balldir>=180) //if ball is going down
			balldir = balldir-180;
		if(balldir<180) //if ball is going up make it go down
			balldir = balldir+180;
		
	end
	
end
	
endmodule

