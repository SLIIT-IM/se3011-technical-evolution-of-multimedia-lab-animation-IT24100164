//"Catch the Ball"

// Player
float px = 350;
float py = 175;
float step = 5;
float pr = 20;

// Ball
float bx = 100;
float by = 100;
float xs = 3;
float ys = 2;
float br = 15;

// Game
int score = 0;
int state = 0; // 0=start, 1=play, 2=end
int startTime;
int duration = 30; //seconds

// Helper (basic follow)
float hx = 350;
float hy = 175;

void setup() {
  size(700, 350);
}

void draw() {
  background(#FFF1CB); // light Orange

  // START SCREEN
  if (state == 0) {
    
    textSize(35);
    fill(50, 50, 50);
    textAlign(CENTER, CENTER);
    text("Catch the Ball :)", width/2, 100);
    
    textSize(20);
    fill(50, 50, 50);
    textAlign(CENTER, CENTER);
    text("Press ENTER to Start", width/2, 180);
  }

  // PLAY STATE
  if (state == 1) {

    // TIMER
    int timePassed = (millis() - startTime) / 1000;
    int timeLeft = duration - timePassed;

    if (timeLeft <= 0) {
      state = 2;
    }

    // PLAYER MOVEMENT
    if (keyPressed) {
      if (keyCode == RIGHT) px += step;
      if (keyCode == LEFT) px -= step;
      if (keyCode == UP) py -= step;
      if (keyCode == DOWN) py += step;
    }

    // LIMIT PLAYER
    px = constrain(px, pr, width - pr);
    py = constrain(py, pr, height - pr);

    // BALL MOVEMENT
    bx += xs;
    by += ys;

    // BOUNCE
    if (bx > width - br || bx < br) xs *= -1;
    if (by > height - br || by < br) ys *= -1;

    // COLLISION
    float d = dist(px, py, bx, by);
    if (d < pr + br) {
      score++;
  
      // reset orb to random position
      bx = random(width);
      by = random(height);
  
      // increase orb speed slightly
      xs *= 1.1;
      ys *= 1.1;
    }

    // HELPER (basic easing)
    hx += (px - hx) * 0.1;
    hy += (py - hy) * 0.1;

    // DRAW BALL 
    fill(#F03413); // red
    ellipse(bx, by, br*2, br*2);

    // DRAW PLAYER 
    fill(#12A4C6); //Blue
    ellipse(px, py, pr*2, pr*2);

    // DRAW HELPER 
    fill(#166C2D); //Green
    ellipse(hx, hy, 12, 12);

    // UI
    fill(0);
    textSize(14);
    textAlign(LEFT);
    text("Score: " + score, 10, 20);
    text("Time: " + timeLeft, 10, 40);
  }

  // END SCREEN
  if (state == 2) {
    textAlign(CENTER, CENTER);
    textSize(22);
    fill(50, 50, 50);
    text("Game Over", width/2, height/2 - 20);
    text("Score: " + score, width/2, height/2 + 10);
    text("Press R to Restart", width/2, height/2 + 40);
  }
}

void keyPressed() {
  // START GAME
  if (state == 0 && keyCode == ENTER) {
    state = 1;
    startTime = millis();
    score = 0;
  }

  // RESET GAME
  if (state == 2 && (key == 'r' || key == 'R')) {
    state = 0;
  }
}
