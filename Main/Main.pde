int n = 10; // Størrelsen af grafen, n = antallet af byer
 
PVector[] knuder = new PVector[n]; // Init - for vektorvariabel som array af n's størrelse.
PVector[] knuderbest = new PVector[n];
double a = 0;
double bestEver = 10000000000000000000000000000000000000.1;
boolean b = true;
int displayBest = 0;
int frame = 240;
float fact = 1;
float t = 0;
boolean p = true;
boolean o = true;
boolean reset = true;
double startdistance = 0;
 
void setup() {
  size(1000, 600);
  fact = n*n*(n/2);
  // --##Generate a random structure of vertice's of n'th size.##--
  for (int i = 0; i<n; i++) {
    knuder[i] = new PVector(random(width-200)+150, random(height-200)+150);
  }
  arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
  println("n =", n);
  println("suppression value of n = ", fact);
}
// ----####----####----####----
 
void draw() {
  frameRate(frame);
  if (p == true) {
    //Tegner cirkler ved hvert af punkterne
    background(30);
 
    // Tegner linjer imellem punkterne
    for (int i = 0; i<(knuderbest.length); i++) {
      if (o == true) {
        if (i == (knuderbest.length)-1) {
          stroke(200);
          strokeWeight(5);
          fill(100, 100, 100, 10);
          line(knuderbest[i].x, knuderbest[i].y, knuderbest[0].x, knuderbest[0].y);
        } else {
          stroke(200);
          strokeWeight(5);
          fill(100, 100, 100, 10);
          line(knuderbest[i].x, knuderbest[i].y, knuderbest[i+1].x, knuderbest[i+1].y);
        }
      }
      if (i == (knuder.length)-1) {
        stroke(100);
        strokeWeight(1);
        fill(100, 100, 100, 10);
        line(knuder[i].x, knuder[i].y, knuder[0].x, knuder[0].y);
      } else {
        stroke(100);
        strokeWeight(1);
        fill(100, 100, 100, 10);
        line(knuder[i].x, knuder[i].y, knuder[i+1].x, knuder[i+1].y);
      }
 
      // Udregner distancen mellem punkterne
    }
    for (int i = 0; i<n; i++) {
 
      if (i == 0) {
        fill(0, 255, 0);
        stroke(0, 215, 0);
        strokeWeight(3);
        ellipse(knuderbest[0].x, knuderbest[0].y, 20, 20);
      } else {
        fill(255, 155, 0);
        stroke(245, 135, 0);
        strokeWeight(3);
        ellipse(knuderbest[i].x, knuderbest[i].y, 20, 20);
      }
      //Laver numrer i hver af punkterne
      if (i>9) {
        fill(0);
        text(""+(i+1), knuderbest[i].x-7, knuderbest[i].y+5);
      } else {
        fill(0);
        text(""+(i+1), knuderbest[i].x-3, knuderbest[i].y+5);
      }
    }
    if (b == true) {
      double dist = 0;
      double sum = 0;
      for (int i = 0; i <knuder.length; i++) {
        if (i == knuder.length - 1) {
          a = knuder[i].dist(knuder[0]);
          sum = sum + a;
        } else {
          a = knuder[i].dist(knuder[i+1]);
          sum = sum + a;
        }
        if (i == (knuder.length - 1)) {
          b = false;
          dist = dist+sum;
          if (dist<bestEver) {
            bestEver = dist;
            displayBest = (int) bestEver;
            arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
          }
          if (t == 0) {
            startdistance = dist;
          }
            
        }
      }
 
 
      fill(200);
      text("korteste distance = "+displayBest, 15, 15);
      text("FPS: "+frame, 15, 30);
      fill(0, 255, 0);
      text("Ping: " +(int)random(15, 90), 15, 45);
      float completeness = t/fact;
      strokeWeight(2);
      noStroke();
      fill(255);
      rect(15, 60, (float)(completeness)*160, 20);
      stroke(0, 215, 0);
      noFill();
      rect(15, 60, 160, 20);
      text((int)(completeness*100)+ "%", 90, 93);
      text("Muligheder at undersøge: " + fact, 400, 15);
      text("Muligheder undersøgt: "+ t, 400, 30);
      text("ENTER = Pause/unPause, BACKSPACE = Vis Beste Rute, TAB = Ny Graf", 10, height-5);
      text("Start-Distance: " + (int)startdistance, 15, 110);
      text("%-vis optimeret: " + (int)(-(bestEver/startdistance)*100+100) + "%", 15, 125);
      //Viser den bedste distance på skærmen
     
 
      int i = floor(random(knuder.length));
      int j = floor(random(knuder.length-2));
      if (i < knuder.length-1)
        j = i+1;
 
      swap(knuder, i, j);
      if (t == fact) p = !p;
      if (reset == true) p = !p;
    }
    if (t<fact) t = t+1;
  }
}
void keyPressed () {
  if (frame < 240) {
    if (keyCode == RIGHT) {
      frame += 1;
    }
  }
  if (frame > 1) {
    if (keyCode == LEFT) {
      frame -= 1;
    }
  }
  if (key == ENTER) {
    p = !p;
    reset = false;
  }
  if (key == BACKSPACE) {
    o = !o;
  }
  if (key == TAB) {
    a = 0;
    bestEver = 10000000000000000000000000000000000000.1;
    displayBest = 0;
    fact = 1;
    t = 0;
    for (int i = 0; i<n; i++) {
      knuder[i] = new PVector(random(width-200)+150, random(height-200)+150);
    }
    arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
    fact = n*n*(n/2);
    o = true;
    reset = true;
    for (int i = 0; i<1; i++) {
      p = !p;
    }
  }
}
 
 
void swap(PVector[] a, int i, int j) {
  PVector temp = a[i];
  a[i] = a[j];
  a[j] = temp;
  b = true;
}
