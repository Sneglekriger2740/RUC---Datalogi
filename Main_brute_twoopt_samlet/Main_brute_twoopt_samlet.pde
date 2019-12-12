int n = 8; // Størrelsen af grafen, n = antallet af byer
import java.util.Arrays;
import java.util.Collections;
import java.util.Vector;


PVector[] knuder = new PVector[n]; // Init - for vektorvariabel som array af n's størrelse.
PVector[] knuder2 = new PVector[n];
PVector[] knuderbest = new PVector[n]; // Visualiserings array, til at displaye den korteste eulertur.
PVector[] knuderbest2 = new PVector[n];
PVector[] m = new PVector[n]; // 2-opt Algoritmens middel array-del.
PVector[] l = new PVector[n]; // 2-opt Algoritmens venstre array-del.
PVector[] r = new PVector[n]; // 2-opt Algoritmens højre array-del.
double a = 0;
double a2 = 0;
double bestEver = 10000000000000000000000000000000000000.1;
double bestEver2 = 10000000000000000000000000000000000000.1;
boolean b = true;
boolean bOneshot = true;

float displayBest = 0;
float displayBest2 = 0;
int t2 = 0;
int buf = t2;
int framerate = 1000;
int[] order;

float fact = 1;
float t = 0;
boolean o = true;
boolean reset = true;
double startdistance = 0;
double startdistance2 = 0;
int k = 0;
boolean nyGraf = true;
boolean p = true;
boolean b2 = true;
boolean oneshot2 = true;


void setup() {
  size(1000, 600);
  fact = factorial(n);
  // --##Generate a random structure of vertice's of n'th size.##--
  order = new int[n];
  for (int i = 0; i<n; i++) {
    knuder[i] = new PVector(random(width-200)+170, random(height-200)+150);
    order[i] = i;
  }
  arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
  arrayCopy(knuder, 0, knuder2, 0, knuder.length);
  arrayCopy(knuder2, 0, knuderbest2, 0, knuder2.length);
  println("n =", n);
  System.out.println(Arrays.toString(knuder));
}
// ----####----####----####----

void draw() {
  frameRate(framerate);
  background(55);




  // BRUTE FORCE 


  for (int i = 0; i<(order.length); i++) {
    if (o == true) {
      if (i == (order.length)-1) {
        if (b == true) {
          stroke(120);
        } else {
          stroke(255, 0, 0);
        }
        strokeWeight(5);
        fill(100, 100, 100, 10);
        line(knuderbest[i].x, knuderbest[i].y, knuderbest[0].x, knuderbest[0].y);
      } else {
        if (b == true) {
          stroke(120);
        } else {
          stroke(255, 0, 0);
        }
        strokeWeight(5);
        fill(100, 100, 100, 10);
        line(knuderbest[i].x, knuderbest[i].y, knuderbest[i+1].x, knuderbest[i+1].y);
      }
    }

    println(order);

    if (i == knuder.length-1) {
      if (b == true) {
        stroke(0);
      } else {
        noStroke();
      } 
      strokeWeight(1);
      fill(100, 100, 100, 10);
      line(knuder[i].x, knuder[i].y, knuder[0].x, knuder[0].y);
    } else if (i < knuder.length-1) {
      if (b == true) {
        stroke(0);
      } else {
        noStroke();
      }
      strokeWeight(1);
      //println(""+e);
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
  for (int i = 0; i<(knuderbest2.length); i++) {
    if (o == true) {
      if (i == (knuderbest2.length)-1) {
        if (b2 == true) {
          stroke(120);
        } else {
          stroke(0, 170, 0);
        }
        strokeWeight(5);
        fill(100, 100, 100, 10);
        line(knuderbest2[i].x, knuderbest2[i].y, knuderbest2[0].x, knuderbest2[0].y);
      } else {
        if (b2 == true) {
          stroke(120);
        } else {
          stroke(0, 170, 0);
        }
        strokeWeight(5);
        fill(100, 100, 100, 10);
        line(knuderbest2[i].x, knuderbest2[i].y, knuderbest2[i+1].x, knuderbest2[i+1].y);
      }
    }
    if (i == (knuder2.length)-1) {
      if (b2 == true) {
        stroke(0);
      } else {
        stroke(0, 150, 0);
      }
      strokeWeight(1);
      fill(100, 100, 100, 10);
      line(knuder2[i].x, knuder2[i].y, knuder2[0].x, knuder2[0].y);
    } else {
      if (b2 == true) {
        stroke(0);
      } else {
        stroke(0, 150, 0);
      }
      strokeWeight(1);
      fill(100, 100, 100, 10);
      line(knuder2[i].x, knuder2[i].y, knuder2[i+1].x, knuder2[i+1].y);
    }
  }
  for (int i = 0; i<n; i++) {
    if (o == true) {
      if (b2 == false) {
        fill(0, 255, 0);
        stroke(0, 215, 0);
        strokeWeight(2);
        ellipse(knuderbest2[i].x, knuderbest2[i].y, 6, 6);
      } else {
        fill(255, 155, 0);
        stroke(245, 135, 0);
        strokeWeight(2);
        ellipse(knuderbest2[i].x, knuderbest2[i].y, 6, 6);
      }
    }
  }
  //if (t > 120) delay(1000000000);
  if (b == true) {
    bruteForce();

    double dist = 0;
    double sum = 0;

    System.out.println(Arrays.toString(knuder));
    for (int i = 0; i <knuder.length; i++) {
      if (i == knuder.length - 1) {
        a = knuder[i].dist(knuder[0]);
        sum = sum + a;
      } else {
        a = knuder[i].dist(knuder[i+1]);
        sum = sum + a;
      }

      if (i == (knuder.length - 1)) {
        dist = dist+sum;
        if (dist<bestEver) {
          bestEver = dist;
          displayBest = (int) bestEver;
          arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
        }
        if (nyGraf == true) {
          startdistance = dist;
        }
      }
    }
  }
  if (b2 == true) {
    double dist2 = 0;
    double sum2 = 0;
    for (int i = 0; i <knuder2.length; i++) {
      if (i == knuder2.length - 1) {
        a2 = knuder2[i].dist(knuder2[0]);
        sum2 = sum2 + a2;
      } else {
        a2 = knuder2[i].dist(knuder2[i+1]);
        sum2 = sum2 + a2;
      }
      if (i == (knuder2.length - 1)) {
        b2 = false;
        dist2 = dist2+sum2;
        if (dist2<bestEver2) {
          bestEver2 = dist2;
          displayBest2 = (int) bestEver2;
          arrayCopy(knuder2, 0, knuderbest2, 0, knuder2.length);
        }
        if (nyGraf == true) {
          startdistance2 = startdistance;
          nyGraf = false;
        }
      }
    }

    int buf2 = k;
  top:
    {
      for (int i = k; i<n; i++) {
        for (int j = i + 2; j < n; j++) {
          float d1 = knuder2[i].dist(knuder2[(i+1)%n]) + knuder2[j].dist(knuder2[(j+1)%n]); 
          float d2 = knuder2[i].dist(knuder2[j])+(knuder2[(i+1)%n].dist(knuder2[(j+1)%n]));
          if (d2 < d1) {      

            m = Arrays.copyOfRange(knuder2, Math.min((i + 1) % n, (j + 1) % n), Math.max((i + 1) % n, ((j + 1) % n)));
            invertUsingFor(m);
            l = Arrays.copyOfRange(knuder2, 0, Math.min((i + 1) % n, (j + 1) % n));
            r = Arrays.copyOfRange(knuder2, Math.max((i + 1) % n, (j + 1) % n), n);
            println("r: ", r.length, "l: ", l.length, "m: ", m.length);
            System.arraycopy(l, 0, knuder2, 0, l.length);
            System.arraycopy(m, 0, knuder2, l.length, m.length);
            System.arraycopy(r, 0, knuder2, l.length+m.length, r.length);
            //System.out.println(Arrays.toString(knuder));
            t2++;
            k = i; // Scanner kun ucheckede kanter.
            b2 = true;
            break top;
          }
        }
      }
      k = 0;
      //if (t == fact) p = !p;
      //if (reset == true) p = !p;
    }
    if (t2 == buf && buf2 == 0) {
      b2 = false;
    }
  }
  fill(255);
  text("-Brute", 230, 20);
  text("-2-Opt", 230, 35);
  strokeWeight(5);
  stroke(255, 0, 0);
  line(200, 15, 220, 15);
  stroke(0, 150, 0);
  line(200, 30, 220, 30);
  stroke(150);
  strokeWeight(1);
  fill(60);
  rect(-1, 0, 160, height);
  fill(255);
  text("Start-dist: Brute = " +(int)startdistance, 15, 15);
  text("FPS: "+framerate, 15, 165);
  strokeWeight(2);
  text("Leksiografisk Brute + 2-opt", 10, height-5);
  text("Kortest-Dist: Brute =" + (int)displayBest, 15, 30);
  if (b == true)
    text("Arbejder..  " + (int)((t/fact)*100) + "%", 15, 105);
  if (b == false)
    text("Færdig. " + (int)100 + "%", 15, 105);
  text("Start-Dist: 2-Opt =" + (int)startdistance2, 15, 45);
  text("Kortest-Dist: 2-Opt =" +(int)displayBest2, 15, 60);
  if (displayBest < displayBest2)
    text("Ikke optimal heurestik", 15, 120);
  println(t);
  if (bOneshot == true) {
    bOneshot = !bOneshot;
  }
  if (b == false) {
    text("Tid-Sparret: " + (100-((t2/fact)*100)) +"%", 15, 135);
    text("Brute-force steps: " + t,15, 180);
    text("2-Opt steps: " + t2, 15, 195);
    if (displayBest < displayBest2)
      text("Fejl-Margen: " + (float)((displayBest2/displayBest)*100-100) + "%", 15, 150);
  }
}

void keyPressed () {
  if (framerate < 240) {
    if (keyCode == RIGHT) {
      framerate += 1;
    }
  }
  if (framerate > 1) {
    if (keyCode == LEFT) {
      framerate -= 1;
    }
  }
  if (key == ENTER) {
    delay(10000);
  }

  if (key == BACKSPACE) {
    o = !o;
  }
  if (key == TAB) {
    a = 0;
    bestEver = 10000000000000000000000000000000000000.1;
    displayBest = 0;
    fact = 1;
    a2 = 0;
    bestEver2 = 10000000000000000000000000000000000000.1;
    displayBest2 = 0;
    t = 0;
    t2 = 0;
    for (int i = 0; i<n; i++) {
      knuder[i] = new PVector(random(width-200)+170, random(height-200)+150);
      order[i] = i;
    }
    arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
    arrayCopy(knuder, 0, knuder2, 0, knuder.length);
    arrayCopy(knuder2, 0, knuderbest2, 0, knuder2.length);
    fact = factorial(n);
    reset = true;
    for (int i = 0; i<1; i++) {
      p = !p;
    }
    nyGraf = true;
    k = 0;
    redraw();
    b = true;
    b2 = true;
  }
}

void invertUsingFor(Object[] array) {
  for (int i = 0; i < array.length / 2; i++) {
    Object temp = array[i];
    array[i] = array[array.length - 1 - i];
    array[array.length - 1 - i] = temp;
  }
}

void bruteForce() {
  t++;
  // STEP 1 of the algorithm
  // https://www.quora.com/How-would-you-explain-an-algorithm-that-generates-permutations-using-lexicographic-ordering
  int largestI = -1;
  for (int i = 0; i < order.length - 1; i++) {
    if (order[i] < order[i + 1]) {
      largestI = i;
    }
  }

  if (largestI == -1) {
    println("finished & LargestI =" + largestI);
    b = false;
  }

  if (largestI != -1) {
    // STEP 2
    int largestJ = -1;
    for (int j = 0; j < order.length; j++) {
      if (order[largestI] < order[j]) {
        largestJ = j;
      }
    }
    // STEP 3
    swap(order, largestI, largestJ);

    // STEP 4: reverse from largestI + 1 to the end
    int size = order.length - largestI - 1;
    int[] endArray = new int[size];
    arrayCopy(order, largestI + 1, endArray, 0, size);
    endArray = reverse(endArray);
    arrayCopy(endArray, 0, order, largestI+1, size);
    PVector temp2[] = new PVector[knuder.length]; 

    for (int i=0; i<knuder.length; i++) {
      temp2[order[i]] = knuder[i];
    }
    for (int i=0; i<knuder.length; i++) {
      knuder[i] = temp2[i];
    }
  }
}

int factorial(int n) {
  if (n == 1) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}

void swap(int[] a, int i, int j) {
  int temp = a[i];
  a[i] = a[j];
  a[j] = temp;
}

void order() { 
  PVector temp[] = new PVector[knuder.length]; 

  for (int i=0; i<knuder.length-1; i++) 
    knuder[order[i]] = temp[i]; 

  knuder = temp;
}
