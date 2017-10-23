// modified from https://rbnrpi.wordpress.com/2016/12/23/using-processing-to-control-sonic-pi/

import oscP5.*; //libraries required
import netP5.*;

OscP5 oscP5;
NetAddress sonicPi;

float mX;
float mY;
float easing = 1; //change to 1 to get immediate following
int radius = 24;
int edge = 100;
int inner = edge + radius;

void setup() {
size(640, 360);
noStroke();
ellipseMode(RADIUS);
rectMode(CORNERS);
oscP5 = new OscP5(this, 8000);
sonicPi = new NetAddress("127.0.0.1",4559);

}
void sendOscNote(float mX,float mY) {
OscMessage toSend = new OscMessage("/notesend");
toSend.add(mX); //add mouseX and mouseY values as floating numbers
toSend.add(mY);
oscP5.send(toSend, sonicPi);
println(toSend);
}
void draw() {
background(51);

if (abs(mouseX - mX) > 0.1) {
mX = mX + (mouseX - mX) * easing;
}
if (abs(mouseY - mY) > 0.1) {
mY = mY + (mouseY- mY) * easing;
}

mX = constrain(mX, inner, width - inner);
mY = constrain(mY, inner, height - inner);
fill(76);
rect(edge, edge, width-edge, height-edge);
fill(255);
ellipse(mX, mY, radius, radius);
sendOscNote(mX,mY); //send the mx and my values to SP
}