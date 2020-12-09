/*
 * breakout.c : Camillo J. Taylor - Oct. 28, 2020
 */

/* Note this code should be run in SINGLE BUFFER MODE so you would invoke PennSsim using
 * java -jar PennSim.jar
 */
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
#include "lc4libc.h"

// Number of rows and columns of blocks
#define BLOCK_ROWS 5
#define BLOCK_COLS 8

// Size of blocks in pixels note that within each block there is a 1 pixel border
// of free pixels
#define BLOCK_WIDTH  16
#define BLOCK_HEIGHT 10

#define PADDLE_ROW    120
#define PADDLE_WIDTH  11
#define PADDLE_HEIGHT 3

/*************** GAME STATE VARIABLES *******************/

#define X_SCALE 8

/* Current screen position of ball center in pixels */
int ball_x, ball_y, ball_x_scaled;
int ball_vel_x, ball_vel_y;

/* Note that we also keep a scaled version of the ball_x coordinate
 * which is scaled by the X_SCALE factor to model subpixel motions
 * ball_x is computed from (ball_x_scaled / X_SCALE). The x velocity
 * is also scaled to match this convention. This hack is used to 
 * get around the fact that LC4 doesn't have floating point values
 */

/* 
 * Paddle position and velocity. Note that the paddle only moves back and 
 * forth in the x direction.
 */
int paddle_x;
int paddle_vel_x;

/*
 * This array has one entry for each of the blocks in the array indicating
 * its color. The color BLACK indicates that the ball has been eliminated
 */

lc4uint block_colors[BLOCK_ROWS][BLOCK_COLS];

int lives_left;
int blocks_smashed;

/*************** CODE FOR DRAWING AND REDRAWING GAME ****************/

void clear_screen ()
{
  /* Clear the entire screen to black using lc4_draw_rect */
  lc4_draw_rect(0, 0, 128, 124, BLACK);
}

void draw_all_blocks ()
{
  /* Draw all of the blocks using lc4_draw_rect - remember that within each block there 
    is a 1 pixel border of black pixels */
  int i, j;
  for (i = 0; i < BLOCK_ROWS; i++) {
  	for (j = 0; j < BLOCK_COLS; j++) {
      lc4uint color;
      if (i == 0) {
        color = CYAN;
      } else if (i == 1) {
        color = RED;
      } else if (i == 2) {
        color = GREEN;
      } else if (i == 3) {
        color = BLUE;
      } else {
        color = ORANGE;
      }
  		lc4_draw_rect(BLOCK_WIDTH * j + 1, BLOCK_HEIGHT * i + 1, BLOCK_WIDTH - 2, BLOCK_HEIGHT - 2, color); // draw accounting for 1 px border
  	}
  }
}

void clear_block (int block_row, int block_col)
{
  /* Clear the specified block from the screen by drawing it as black and from the 
   * block_colors matrix */
   	lc4_draw_rect(BLOCK_WIDTH * block_col + 1, BLOCK_HEIGHT * block_row + 1, BLOCK_WIDTH - 2, BLOCK_HEIGHT - 2, BLACK);
    block_colors[block_row][block_col] = BLACK;
    blocks_smashed++;
}

void redraw_ball (int oldx, int oldy, int newx, int newy)
{
  /* The ball is a 3x3 white square which you should redraw first by overdrawing the old position
   * as black then redrawing in the new position as white. Note that the both the new and old coordinates
   * refer to the CENTER of the 3x3 ball - not the upper left corner.
   */
   lc4_draw_rect(oldx - 1, oldy - 1, 3, 3, BLACK);
   lc4_draw_rect(newx - 1, newy - 1, 3, 3, WHITE);
}

void redraw_paddle (int oldx, int newx)
{
  /* Redraw the paddle on PADDLE_ROW centered at the newx position. 
   * Use PADDLE_WIDTH and PADDLE_HEIGHT as the dimensions of the block.
   * once again you need to overdraw the old position in black before redrawing the
   * new position in white. */
   lc4_draw_rect(oldx - (PADDLE_WIDTH / 2), PADDLE_ROW - (PADDLE_HEIGHT / 2), PADDLE_WIDTH, PADDLE_HEIGHT, BLACK);
   lc4_draw_rect(newx - (PADDLE_WIDTH / 2), PADDLE_ROW - (PADDLE_HEIGHT / 2), PADDLE_WIDTH, PADDLE_HEIGHT, WHITE);
}

/*********** CODE FOR UPDATING GAME STATE *****************/

void reset_ball () {
  ball_x = 64;
  ball_y = 60;
  ball_vel_x  = 0;
  ball_vel_y  = 0;
  ball_x_scaled = ball_x * X_SCALE;
}

void reset_game ()
{
  int i;
  
  lives_left = 3;
  blocks_smashed = 0;

  /* Reset paddle */
  paddle_x = 64;
  paddle_vel_x = 0;

  reset_ball ();
  
  /* Reset the blocks */
  for (i=0; i < BLOCK_COLS; ++i) block_colors[0][i] = CYAN;
  for (i=0; i < BLOCK_COLS; ++i) block_colors[1][i] = RED;
  for (i=0; i < BLOCK_COLS; ++i) block_colors[2][i] = GREEN;
  for (i=0; i < BLOCK_COLS; ++i) block_colors[3][i] = BLUE;
  for (i=0; i < BLOCK_COLS; ++i) block_colors[4][i] = ORANGE;

  /* Redraw game */
  clear_screen ();
  draw_all_blocks ();
  redraw_ball (ball_x, ball_y, ball_x, ball_y);
  redraw_paddle (paddle_x, paddle_x);
}

/* Serve ball by reseting position and velocity */
void serve_ball() {
  /* If the ball isn't moving start it off */
  if (ball_vel_y == 0) {
    ball_x = 64;
    ball_y = 60;
    ball_vel_y = 1;
    ball_vel_x = X_SCALE;
    ball_x_scaled = ball_x * X_SCALE;
  }
}

void update_paddle_state (lc4int c)
{
  int old_x = paddle_x;

  /* Move to the left */
  if (c == 'j') {
    --paddle_vel_x;
    if (paddle_vel_x >= 0) paddle_vel_x = -1;
    if (paddle_vel_x < -4) paddle_vel_x = -4;
  }

  /* Stop the paddle motion */
  if (c == 'k') paddle_vel_x = 0;

  /* Move to the right */
  if (c == 'l') {
    ++paddle_vel_x;
    if (paddle_vel_x <= 0) paddle_vel_x = 1;
    if (paddle_vel_x >  4) paddle_vel_x = 4;
  }

  paddle_x += paddle_vel_x;

  if (paddle_x < 0) paddle_x = 0;
  if (paddle_x > 127) paddle_x = 127;
  
  
  if ((old_x != paddle_x) || (ball_y >= PADDLE_ROW-1))
    redraw_paddle(old_x, paddle_x);
}

void update_ball_position ()
{
  int old_x = ball_x;
  int old_y = ball_y;
    
  /* Compute new ball position */
  ball_y += ball_vel_y;
  ball_x_scaled += ball_vel_x;
  ball_x = ball_x_scaled / X_SCALE;

  redraw_ball (old_x, old_y, ball_x, ball_y);
}

void print_score (int x) 
{
  /*EXTRA CREDIT: helper function to print score*/
  char string[5], *ptr; // range 0-1000 -> 4 char + 1 null char
  if (x == 0) { // 0 is weird lol
    lc4_puts ((lc4uint*)"0"); 
  } else {
    ptr = string + 4;  // start pointer at end of array (put it in reverse terryyy)
    *ptr = 0; // null termination
    while (x > 0) {
      ptr--; // bacc dat pointer uppp
      *ptr = (x % 10) + 48; // ascii converter
      x /= 10; // look at next digit
    }
    lc4_puts((lc4uint*)ptr); // print dat bad boii
  } 
}

void handle_collision_with_walls ()
{
  /* Handle collisions with the outer walls of the arena. These involve reflecting
   * the ball velocity in the x and y directions appropriately. Notice that if you detect
   * a collision with the bottom wall that means that the ball got past the paddle and a life
   * has been lost. In this case  you should update the lives_lost variable and reset the ball.
   * IF there are no lives left you should print out GAME OVER.
   * Note that you only need to consider the center pixel of the ball - don't worry about the other 
   * pixels that make up the 3x3 patch
  */	
	if (ball_x <= 0 || ball_x >= 127) { // sides
		ball_vel_x = -ball_vel_x;
	}	
	if (ball_y <= 0) { // top
		ball_vel_y = -ball_vel_y;
	}
	if (ball_y >= 123) { // bottom
    lives_left--; 
		if (lives_left == 0) {
      lc4_puts ((lc4uint*)"GAME OVER\n");
      lc4_puts ((lc4uint*)"FINAL SCORE: ");
      print_score(blocks_smashed);
      lc4_puts ((lc4uint*)"\n");
		} else if (lives_left >= 0) {
      lc4_puts ((lc4uint*)"SCORE: ");
      print_score(blocks_smashed);
      lc4_puts ((lc4uint*)"\n");
      lc4_draw_rect(ball_x - 1, ball_y - 1, 3, 3, BLACK);
			reset_ball();
		}
	}
}

void handle_collision_with_paddle ()
{
  int delta;
  if (ball_y == PADDLE_ROW) {
    delta = ball_x - paddle_x;
    if (delta < 0) delta = -delta;
    if (delta*2 < PADDLE_WIDTH) {
      ball_vel_y = -1;
      ball_vel_x += paddle_vel_x;
      /* Clip ball_vel_x */
      if (ball_vel_x > X_SCALE) ball_vel_x = X_SCALE;
      if (ball_vel_x < -X_SCALE) ball_vel_x = -X_SCALE;
    }
  }
}

void handle_collision_with_blocks ()
{
  /* Handle collisions with the blocks. You need to figure out if the ball has collided with one of
   * the blocks. If so you need to remove the block using the clear_block function. You also need to figure out whether you hit
   * the top bottom or side of a block so you can update the balls velocity appropriately. 
   * Note that you only need to consider the center pixel of the ball - don't worry about the other 
   * pixels that make up the 3x3 patch
   */
  int i, j;
  for (i = 0; i < BLOCK_ROWS; i++) {
    for (j = 0; j < BLOCK_COLS; j++) {
      if (block_colors[i][j] != BLACK) {
        int left = BLOCK_WIDTH * j + 1;
        int right = BLOCK_WIDTH * (j + 1) - 1;
        int top = BLOCK_HEIGHT * i + 1;
        int bottom = BLOCK_HEIGHT * (i + 1) - 1;
        if ((ball_x == left || ball_x == right) && (ball_y > top && ball_y < bottom)) { // hit sides
          clear_block(i, j);
          ball_vel_x = -ball_vel_x;
        } else if ((ball_x > left && ball_x < right) && (ball_y == top || ball_y == bottom)) { // hit top/bottom
          clear_block(i, j);
          ball_vel_y = -ball_vel_y;
        } else if ((ball_x == left && ball_y == top) || (ball_x == left && ball_y == bottom) 
            || (ball_x == right && ball_y == top) || (ball_x == right && ball_y == bottom)) { // hit corners
          clear_block(i, j);
          ball_vel_x = -ball_vel_x;
          ball_vel_y = -ball_vel_y;
        }
      }
    }
  }
}


/*
 * #############  MAIN PROGRAM ######################
 */

int main ()
{
  lc4int c;
  
  lc4_puts ((lc4uint*)"!!! Welcome to Breakout !!!\n");
  lc4_puts ((lc4uint*)"Press j to move paddle left\n");
  lc4_puts ((lc4uint*)"Press k to stop the paddle\n");
  lc4_puts ((lc4uint*)"Press l to move paddle right\n");
  lc4_puts ((lc4uint*)"Press q to reset/serve ball\n");
  lc4_puts ((lc4uint*)"Press z to reset game\n");
  
  lc4_set_timer ((lc4uint) 50);

  reset_game ();

  while (1) {
    if (lc4_check_timer() < 0) {

      c = lc4_getc();

      /* Handle a game reset */
      if (c == 'z') reset_game();

      /* Handle a serve  */
      if ((c == 'q') && (lives_left > 0)) serve_ball ();
     
      update_ball_position();
      
      handle_collision_with_walls();
      handle_collision_with_paddle();
      handle_collision_with_blocks();

      update_paddle_state(c);
    }
  }
  
  return 0;
}
