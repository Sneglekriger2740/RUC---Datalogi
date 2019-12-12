int n = 250; // Størrelsen af grafen, n = antallet af byer
import java.util.Arrays;
import java.util.Collections;
import java.util.Vector;

PVector[] knuder = new PVector[n]; // Init - for vektorvariabel som array af n's størrelse.
PVector[] knuderbest = new PVector[n]; // Visualiserings array, til at displaye den korteste eulertur.
PVector[] m = new PVector[n]; // 2-opt Algoritmens middel array-del.
PVector[] l = new PVector[n]; // 2-opt Algoritmens venstre array-del.
PVector[] r = new PVector[n]; // 2-opt Algoritmens højre array-del.
double a = 0;
double bestEver = 10000000000000000000000000000000000000.1;
boolean b = true;
int displayBest = 0;
int frame = 0;
int buf = frame;
int framerate = 240;
float fact = 1;
float t = 0;
boolean o = true;
boolean reset = true;
double startdistance = 0;
int k = 0;
boolean oneshot = true;
boolean p = true;

void setup() {
  size(1000, 600);
  fact = n*n*(n/2);
  // --##Generate a random structure of vertice's of n'th size.##--
  for (int i = 0; i<n; i++) {
    knuder[i] = new PVector(random(width-200)+150, random(height-200)+150);
  }
  arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
  println("n =", n);
  System.out.println(Arrays.toString(knuder));
}
// ----####----####----####----

void draw() {
  frameRate(framerate);
  //Tegner cirkler ved hvert af punkterne
  background(55);
  // Tegner linjer imellem punkterne



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
        if (oneshot == true) {
          startdistance = dist;
          oneshot = false;
        }
      }
    }
    //Viser den bedste distance på skærmen

    int buf2 = k;
  top:
    {
      for (int i = k; i<n; i++) {
        for (int j = i + 2; j < n; j++) {
          float d1 = knuder[i].dist(knuder[(i+1)%n]) + knuder[j].dist(knuder[(j+1)%n]); 
          float d2 = knuder[i].dist(knuder[j])+(knuder[(i+1)%n].dist(knuder[(j+1)%n]));
          if (d2 < d1) {      

            m = Arrays.copyOfRange(knuder, Math.min((i + 1) % n, (j + 1) % n), Math.max((i + 1) % n, ((j + 1) % n)));
            invertUsingFor(m);
            l = Arrays.copyOfRange(knuder, 0, Math.min((i + 1) % n, (j + 1) % n));
            r = Arrays.copyOfRange(knuder, Math.max((i + 1) % n, (j + 1) % n), n);
            println("r: ", r.length, "l: ", l.length, "m: ", m.length);
            System.arraycopy(l, 0, knuder, 0, l.length);
            System.arraycopy(m, 0, knuder, l.length, m.length);
            System.arraycopy(r, 0, knuder, l.length+m.length, r.length);
            System.out.println(Arrays.toString(knuder));
            frame++;
            k = i; // Scanner kun ucheckede kanter.
            b = true;
            break top;
          }
        }
      }
      k = 0;
      //if (t == fact) p = !p;
      //if (reset == true) p = !p;
    }
    if (frame == buf && buf2 == 0) {
      b = false;
    }
  }
  for (int i = 0; i<(knuderbest.length); i++) {
    if (o == true) {
      if (i == (knuderbest.length)-1) {
        if (b == true) {
          stroke(120);
        } else {
          stroke(0, 170, 0);
        }
        strokeWeight(5);
        fill(100, 100, 100, 10);
        line(knuderbest[i].x, knuderbest[i].y, knuderbest[0].x, knuderbest[0].y);
      } else {
        if (b == true) {
          stroke(120);
        } else {
          stroke(0, 170, 0);
        }
        strokeWeight(5);
        fill(100, 100, 100, 10);
        line(knuderbest[i].x, knuderbest[i].y, knuderbest[i+1].x, knuderbest[i+1].y);
      }
    }
    if (i == (knuder.length)-1) {
      if (b == true) {
        stroke(0);
      } else {
        stroke(0, 150, 0);
      }
      strokeWeight(1);
      fill(100, 100, 100, 10);
      line(knuder[i].x, knuder[i].y, knuder[0].x, knuder[0].y);
    } else {
      if (b == true) {
        stroke(0);
      } else {
        stroke(0, 150, 0);
      }
      strokeWeight(1);
      fill(100, 100, 100, 10);
      line(knuder[i].x, knuder[i].y, knuder[i+1].x, knuder[i+1].y);
    }
  }
  for (int i = 0; i<n; i++) {
    if (o == true) {
      if (b == false) {
        fill(0, 255, 0);
        stroke(0, 215, 0);
        strokeWeight(2);
        ellipse(knuderbest[i].x, knuderbest[i].y, 6, 6);
      } else {
        fill(255, 155, 0);
        stroke(245, 135, 0);
        strokeWeight(2);
        ellipse(knuderbest[i].x, knuderbest[i].y, 6, 6);
      }
    }
    //Laver numrer i hver af punkterne
    /*if (i>9) {
     fill(0);
     text(""+(i+1), knuderbest[i].x-7, knuderbest[i].y+5);
     } else {
     fill(0);
     text(""+(i+1), knuderbest[i].x-3, knuderbest[i].y+5);
     }*/
  }
  stroke(150);
  strokeWeight(1);
  fill(60);
  rect(-5, -5, 180, 100);
  fill(255);
  text("korteste distance = "+displayBest, 15, 15);
  text("FPS: "+framerate, 15, 30);
  fill(0, 150, 0);
  text("Ping: " +(int)random(15, 90), 15, 45);
  strokeWeight(2);
  fill(255);
  text("2-Opt Algoritme", 10, height-5);
  text("Start-Distance: " + (int)startdistance, 15, 60);
  if (b == true)
    text("Arbejder..  " + (int)(-(bestEver/startdistance)*100+100) + "%", 15, 75);
  if (b == false)
    text("Færdig. " + (int)100 + "%", 15, 75);
}

void keyPressed () {
  if (frame < 240) {
    if (keyCode == RIGHT) {
      framerate += 1;
    }
  }
  if (frame > 1) {
    if (keyCode == LEFT) {
      framerate -= 1;
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
    reset = true;
    for (int i = 0; i<1; i++) {
      p = !p;
    }
    oneshot = true;
    k = 0;
    redraw();
    b = true;
  }
}

void invertUsingFor(Object[] array) {
  for (int i = 0; i < array.length / 2; i++) {
    Object temp = array[i];
    array[i] = array[array.length - 1 - i];
    array[array.length - 1 - i] = temp;
  }
}
