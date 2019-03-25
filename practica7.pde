import processing.sound.*;
boolean sonar;
float ancho;
float frecuencia;
float volumen;
float r;
float g;
float b;
float rgb;

Pulse pulso;

void setup() {
  size(600, 600);
  background(255);
    
  pulso = new Pulse(this);
    
  sonar = false;
  ancho = 0.5;
  frecuencia = 512;
  volumen = 0.5;
  r = 0;
  g = 0;
  b = 0;
}

void draw() {
  pulso.width(ancho);
  pulso.freq(frecuencia);
  if (sonar) {
    pulso.play();
    pulso.amp(volumen);
    
    if (keyPressed == true) {
      if (key == CODED) {
        if (keyCode == UP) {
          ancho += 0.001;
          if (ancho >= 1) ancho = 0.99;
        } else {
          if (keyCode == DOWN) {
            ancho -= 0.001;
            if (ancho <= 0) ancho = 0.01;
          } else {
            if (keyCode == LEFT) {
              frecuencia --;
              if (frecuencia <= 0) frecuencia = 1;
            } else {
              if (keyCode == RIGHT) {
                frecuencia++;
                if (frecuencia >= 1024) frecuencia = 1023;
              }
            }
          }
        }
      }
    }
  }
  r = frecuencia/4.0;
  fill(r,0,0);
  rect(0,0,width/2,height/2);
  g = ancho*256.0;
  fill(0,g,0);
  rect(width/2,0,width/2,height/2);
  b = volumen*256.0;
  fill(0,0,b);
  rect(0,height/2,width/2,height/2);
  fill(r,g,b);
  rect(width/2,height/2,width/2,height/2);
  fill(255 - r);
  text("Controle la frecuencia con las flechas IZQUIERDA y DERECHA del teclado", 10, 10, 70, 120);
  fill(255 - g);
  text("Controle la amplitud con las flechas ARRIBA y ABAJO del teclado", width - 80, 10, 70, 120);
  fill(255 - b);
  text("Controle la amplitud con la rueda del ratón", 10, width - 90, 70, 80);
  fill(0);
  text("Comience la reproducción con el CLICK IZQUIERDO, detenga la reproducción con el CLICK DERECHO  ", width - 90, width - 130, 80, 120);
}

void mouseClicked() {
  if (mouseButton == LEFT) {
    sonar = true;
  } else {
    if (mouseButton == RIGHT) {
      pulso.stop();
      sonar = false;
    }
  }
}

void mouseWheel(MouseEvent e) {
  volumen += (float) -0.001*e.getCount();
  if (volumen <= 0) volumen = 0.01;
  if (volumen >= 1) volumen = 0.99;
}
