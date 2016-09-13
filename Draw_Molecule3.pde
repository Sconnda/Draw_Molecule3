ArrayList<Atom> atoms = new ArrayList<Atom>();
int selected = 0;
int[] selections = new int[2];
float k = 1000;

float transX = 0, transY = 0, zoom = 0;
float rotX = 0, rotY = 0, rotZ = PI;

void setup() {
  size(700, 700, P3D);
  selections[0] = -1;
  selections[1] = -1;

/*
  //methane
  methyl();
  hydroLink();
  bond(0, 4);
  methyl();
  bond(4, 7);
*/

  //glucose
  atoms.add(new C());
  atoms.add(new H());
  bond(0, 1);
  hydroxide();
  bond(0, 2);
  atoms.add(new C());
  bond(0, 4);
  atoms.add(new H());
  bond(4, 5);
  hydroxide();
  bond(4, 6);
  atoms.add(new C());
  bond(4, 8);
  atoms.add(new H());
  bond(8, 9);
  hydroxide();
  bond(8, 10);
  atoms.add(new C());
  bond(8, 12);
  atoms.add(new H());
  bond(12, 13);
  hydroxide();
  bond(12, 14);
  atoms.add(new C());
  bond(12, 16);
  atoms.add(new H());
  bond(16, 17);
  hydroLink();
  bond(16, 18);
  hydroxide();
  bond(18, 21);
  atoms.add(new O());
  bond(16, 23);
  bond(0, 23);

/*
  //phospholipid
  atoms.add(new C(1));
  atoms.add(new H());
  bond(0, 1);
  atoms.add(new H());
  bond(0, 2);
  atoms.add(new H());
  bond(0, 3);
  atoms.add(new N());
  bond(0, 4);
  methyl();
  bond(4, 5);
  methyl();
  bond(4, 9);
  hydroLink();
  bond(4, 13);
  hydroLink();
  bond(13, 16);
  phosphate();
  bond(16, 22);
  hydroLink();
  bond(23, 24);
  atoms.add(new C());
  bond(24, 27);
  atoms.add(new H());
  bond(27, 28);
  atoms.add(new O());
  bond(27, 29);
  hydroLink();
  bond(27, 30);
  atoms.add(new O());
  bond(30, 33);
  atoms.add(new C());  //tail1
  bond(29, 34);
  atoms.add(new O());
  bond(34, 35, 2);
  hydroLink();
  bond(34, 36);
  for (int i = 0; i < 15; i++) {
    hydroLink();
    bond(36+3*i, 39+3*i);
  }
  methyl();
  bond(81, 84);
  atoms.add(new C());  //tail2
  bond(33, 88);
  atoms.add(new O());
  bond(88, 89, 2);
  hydroLink();
  bond(88, 90);
  for (int i = 0; i < 6; i++) {
    hydroLink();
    bond(90+3*i, 93+3*i);
  }
  atoms.add(new C());
  bond(108, 111);
  atoms.add(new H());
  bond(111, 112);
  atoms.add(new C());
  bond(111, 113, 2);
  atoms.add(new H());
  bond(113, 114);
  hydroLink();
  bond(113, 115);
  for (int i = 0; i < 6; i++) {
    hydroLink();
    bond(115+3*i, 118+3*i);
  }
  methyl();
  bond(133, 136);
*/

  transX = width/2;
  transY = height/2;
}

void draw() {
  background(255);
  noStroke();
  ambientLight(102, 102, 102);
  lightSpecular(204, 204, 204);
  directionalLight(102, 102, 102, 0, 0, -1);
  specular(255, 255, 255);
  shininess(5);
  translate(transX, transY, zoom);
  rotateX(rotX);
  rotateY(rotY);
  rotateZ(rotZ);
  if (atoms.size() > 0) {
    PVector pos = atoms.get(selected).pos;
    float rad = atoms.get(selected).radius;
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    stroke(0, 255, 0, 50);
    noFill();
//    sphere(1.1*rad);
    noStroke();
    popMatrix();
    for (int i = 0; i < selections.length; i++) {
      if (selections[i] != -1) {
        pos = atoms.get(selections[i]).pos;
        rad = atoms.get(selections[i]).radius;
        pushMatrix();
        translate(pos.x, pos.y, pos.z);
        stroke(128, 255, 128, 50);
        noFill();
//        sphere(1.1*rad);
        noStroke();
        popMatrix();
      }
    }
  }
  for (int i = 0; i < atoms.size(); i++) {
    atoms.get(i).display();
    atoms.get(i).reposition(i);
  }
  for (int i = 0; i < atoms.size(); i++) {
    atoms.get(i).move();
  }
  if (mousePressed) {
    rotX += 2*PI*(pmouseY-mouseY)/width;
    rotY -= 2*PI*(pmouseX-mouseX)/width;
  }
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      rotX += 0.1;
    } else if (key == 's' || key == 'S') {
      rotX -= 0.1;
    } else if (key == 'd' || key == 'D') {
      rotY += 0.1;
    } else if (key == 'a' || key == 'A') {
      rotY -= 0.1;
    }
    if (key == '+') {
      zoom += 25;
    } else if (key == '-') {
      zoom -= 25;
    }
    if (keyCode == UP) {
      transY += 10;
    } else if (keyCode == DOWN) {
      transY -= 10;
    } else if (keyCode == LEFT) {
      transX += 10;
    } else if (keyCode == RIGHT) {
      transX -= 10;
    }
  }
  frameRate(100);
}

void bond(int i, int j) {
  if (atoms.size() > max(i, j)) {
    atoms.get(i).bonds.append(j);
    atoms.get(j).bonds.append(i);
  }
}

void bond(int i, int j, int num) {
  if (atoms.size() > max(i, j)) {
    for (int n = 0; n < num; n++) {
      atoms.get(i).bonds.append(j);
      atoms.get(j).bonds.append(i);
    }
  }
}

void methyl() {
  atoms.add(new C());
  atoms.add(new H());
  atoms.add(new H());
  atoms.add(new H());
  int i = atoms.size()-4;
  atoms.get(i).bonds.append(i+1);
  atoms.get(i).bonds.append(i+2);
  atoms.get(i).bonds.append(i+3);
  atoms.get(i+1).bonds.append(i);
  atoms.get(i+2).bonds.append(i);
  atoms.get(i+3).bonds.append(i);
}

void hydroLink() {
  atoms.add(new C());
  atoms.add(new H());
  atoms.add(new H());
  int i = atoms.size()-3;
  atoms.get(i).bonds.append(i+1);
  atoms.get(i).bonds.append(i+2);
  atoms.get(i+1).bonds.append(i);
  atoms.get(i+2).bonds.append(i);
}

void phosphate() {
  atoms.add(new P());
  atoms.add(new O(-1));
  atoms.add(new O());
  atoms.add(new O());
  atoms.add(new O());
  int i = atoms.size()-5;
  atoms.get(i).bonds.append(i+1);
  atoms.get(i).bonds.append(i+2);
  atoms.get(i).bonds.append(i+3);
  atoms.get(i).bonds.append(i+3);
  atoms.get(i).bonds.append(i+4);
  atoms.get(i+1).bonds.append(i);
  atoms.get(i+2).bonds.append(i);
  atoms.get(i+3).bonds.append(i);
  atoms.get(i+3).bonds.append(i);
  atoms.get(i+4).bonds.append(i);
}

void nitrate() {
  atoms.add(new N());
  atoms.add(new H());
  atoms.add(new H());
  int i = atoms.size()-3;
  atoms.get(i).bonds.append(i+1);
  atoms.get(i).bonds.append(i+2);
  atoms.get(i+1).bonds.append(i);
  atoms.get(i+2).bonds.append(i);
}

void hydroxide() {
  atoms.add(new O());
  atoms.add(new H());
  int i = atoms.size()-2;
  atoms.get(i).bonds.append(i+1);
  atoms.get(i+1).bonds.append(i);
}

void keyTyped() {
  if (key == ',') {
    selected--;
    selected += atoms.size();
    selected %= atoms.size();
  } else if (key == '.') {
    selected++;
    selected %= atoms.size();
  } else if (key == ' ') {
    if (selections[0] == -1) {
      selections[0] = selected;
    } else {
      selections[1] = selected;
      atoms.get(selections[0]).bonds.append(selections[1]);
      atoms.get(selections[1]).bonds.append(selections[0]);
      for (int i = 0; i < selections.length; i++) {
        selections[i] = -1;
      }
    }
  }
}