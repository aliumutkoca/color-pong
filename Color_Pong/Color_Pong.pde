/*
Project:   Color Pong
Author:    Ali Umut Koca
Date:      April 27, 2017
Ver:       alpha_v1
Thanks to: Chrisir
*/

float ballX = 0;
float ballY = 0;
float speedX = random(7, 12);
float speedY = random(2, 13);
color cWon = #C70039;
color cLost = #FF5733;
int score = 0;
int startTime;
color changedColorBall = color (255,255,255);

void setup() {
  size(600, 400);
  background(#C70039);
  smooth();
  noCursor();
}


void draw() {
  IntList timeInventory;
  float boardLimit ;
  timeInventory = new IntList();
  timeInventory.append((millis()-startTime)/1000);    
  background(cWon);
  println (timeInventory);
  println (ballY);

  if (ballX < 0 || ballX > width) 
    speedX = -speedX;
  if (ballY < height/30)
    speedY = abs(speedY);
  { //draw ball
    ballX += speedX;
    ballY += speedY;
    fill (changedColorBall);
     strokeWeight(3);
     stroke(255);
    ellipse(ballX, ballY, height/15, height/15);

    boardLimit = constrain(mouseX, width/6, width/1.2);
    rectMode (CENTER);
    fill (255);
    noStroke();
    rect (boardLimit, height/1.05, width/3, height/20, height/3);

    textSize(height/25);
    textAlign(TOP);
    text("Time:" + timeInventory.get(0) +"s", height/40, height/20);

    float paddle = 1000/(score+10);
    float distance = abs (mouseX-ballX);
    if (distance < paddle) score += 1;
    textSize(height/28);
    text("Score:" + score, height/40, height/10);
  }
  if (ballY > height/1.05- height/20) {
    //reflect on paddle
    if (ballX>boardLimit-width/6 && ballX<boardLimit+width/6) {
      speedY=-abs(speedY);
      changedColorBall = color (random(0,255),random(0,255),random(0,255));
      
    } else {
      background(cLost);
      textSize(height/10);
      textAlign(CENTER);
      text("TRY AGAIN", width/2, height/2);
      timeInventory.clear();
    }
  }
}
void mouseClicked() {
  if (ballY > height) {
    ballX=random(0, width);
    ballY=0;
  }
}