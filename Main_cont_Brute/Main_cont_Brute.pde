int n = 6; // Størrelsen af grafen, n = antallet af byer
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
boolean bOneshot = true;

int displayBest = 0;
int frame = 0;
int buf = frame;
int framerate = 20;
int[] order;

float fact = 1;
float t = 0;
boolean o = true;
boolean reset = true;
double startdistance = 0;
int k = 0;
boolean nyGraf = true;
boolean p = true;

void setup() {
  size(1000, 600);
  fact = n*n*(n/2);
  // --##Generate a random structure of vertice's of n'th size.##--
  order = new int[n];
  for (int i = 0; i<n; i++) {
    knuder[i] = new PVector(random(width-200)+150, random(height-200)+150);
    order[i] = i;
  }
  arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
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

    println(order);

    if (i == knuder.length-1) {
      if (b == true) {
        stroke(0);
      } else {
        stroke(0, 150, 0);
      } 
      strokeWeight(1);
      fill(100, 100, 100, 10);
      line(knuder[i].x, knuder[i].y, knuder[0].x, knuder[0].y);
    } else if (i < knuder.length-1) {
      if (b == true) {
        stroke(0);
      } else {
        stroke(0, 150, 0);
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
          nyGraf = false;
        }
      }
    }
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
  text("Lexografical Brute", 10, height-5);
  text("Start-Distance: " + (int)startdistance, 15, 60);
  if (b == true)
    text("Arbejder..  " + (int)(-(bestEver/startdistance)*100+100) + "%", 15, 75);
  if (b == false)
    text("Færdig. " + (int)100 + "%", 15, 75);
  println(t);
  if (bOneshot == true) {
    bOneshot = !bOneshot;
  }
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
    delay(1000000000);
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
      order[i] = i;
    }
    arrayCopy(knuder, 0, knuderbest, 0, knuder.length);
    fact = n*n*(n/2);
    reset = true;
    for (int i = 0; i<1; i++) {
      p = !p;
    }
    nyGraf = true;
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

void reorder() { 
  PVector temp[] = new PVector[knuder.length]; 

  // arr[i] should be present at index[i] index 
  for (int i=0; i<knuder.length-1; i++) 
    knuder[order[i]] = temp[i]; 

  // Copy temp[] to arr[] 
  knuder = temp;
} 
