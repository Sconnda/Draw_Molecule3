abstract class Atom {
  float radius;
  int c;
  IntList bonds;
  color col;
  PVector pos, vel, acc;

  void display() {
    fill(col);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    sphere(radius);
    popMatrix();
  }

  void reposition(int index) {
    acc.set(0, 0, 0);
    for (int i = 0; i < atoms.size(); i++) {
      if (i != index) {
        Atom a = atoms.get(i);
        PVector b = new PVector(pos.x, pos.y, pos.z);
        b.sub(a.pos);
        PVector E = new PVector(b.x, b.y, b.z);
        if (b.mag() >= min(radius, a.radius)) {
          boolean bonded = false;
          if (bonds != null) {
            for (int k = 0; k < bonds.size(); k++) {
              if (i == bonds.get(k)) {
                bonded = true;
              }
            }
          }
          if (bonded) {
            E.mult(-0.25);
          } else {
            E.mult((1+1.1*c*a.c)*k/10/pow(b.mag(), 3));
          }
        } else {
          boolean bonded = false;
          if (bonds != null) {
            for (int k = 0; k < bonds.size(); k++) {
              if (i == bonds.get(k)) {
                bonded = true;
              }
            }
          }
          if (bonded) {
            E.mult(0.1*(min(radius, a.radius) - b.mag())/b.mag());
          } else {
            E.mult((1+1.1*c*a.c)*k/max(pow(b.mag(), 3), 1));
          }
        }
        acc.add(E);
      }
    }
    PVector v = new PVector(vel.x, vel.y, vel.z);
    v.mult(0.5);
    acc.sub(v);
    v = PVector.random3D();
    v.mult(1);
    acc.add(v);
  }

  void move() {
    vel.add(acc);
    pos.add(vel);
    if (pos.x < -2*width) {
      vel.x = abs(vel.x);
    } else if (pos.x > 2*width) {
      vel.x = -abs(vel.x);
    }
    if (pos.y < -2*width) {
      vel.y = abs(vel.y);
    } else if (pos.y > 2*width) {
      vel.y = -abs(vel.y);
    }
    if (pos.z < -2*width) {
      vel.z = abs(vel.z);
    } else if (pos.z > 2*width) {
      vel.z = -abs(vel.z);
    }
  }
}

class H extends Atom {
  H() {
    col = color(196);
    radius = 12;
    c = 0;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }

  H(int charge) {
    col = color(196);
    radius = 12;
    c = charge;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
}

class C extends Atom {
  C() {
    col = color(32);
    radius = 17;
    c = 0;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }

  C(int charge) {
    col = color(32);
    radius = 17;
    c = charge;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
}

class O extends Atom {
  O() {
    col = color(255, 0, 0);
    radius = 15.5;
    c = 0;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }

  O(int charge) {
    col = color(255, 0, 0);
    radius = 15.5;
    c = charge;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
}

class N extends Atom {
  N() {
    col = color(0, 0, 255);
    radius = 15.5;
    c = 0;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }

  N(int charge) {
    col = color(0, 0, 255);
    radius = 15.5;
    c = charge;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
}

class P extends Atom {
  P() {
    col = color(255, 128, 0);
    radius = 19.5;
    c = 0;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }

  P(int charge) {
    col = color(255, 128, 0);
    radius = 19.5;
    c = charge;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
}

class Empty extends Atom {
  Empty() {
    col = color(0);
    radius = 0;
    c = 0;
    bonds = new IntList();
    pos = new PVector(random(250), random(250), random(250));
    vel = new PVector(0, 0, 0);
    acc = new PVector(0, 0, 0);
  }
}