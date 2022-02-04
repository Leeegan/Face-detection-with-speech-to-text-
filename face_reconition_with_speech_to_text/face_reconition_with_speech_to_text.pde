import processing.video.*;
import gab.opencv.*;
import java.awt.*;
import websockets.*; // import chrome for speech to text

WebsocketServer socket; //for speech to text
Capture video;
OpenCV opencv;

void setup() {
  size(1700, 680);
  video = new Capture(this, 1700/2, 680/2);
  opencv = new OpenCV(this, 1700/2, 680/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  socket = new WebsocketServer(this, 1337, "/p5websocket"); //speech to text 

  video.start();
}

void draw() {
  scale(2);
  opencv.loadImage(video);

  image(video, 0, 0 );
  Rectangle[] faces = opencv.detect();
  noFill();
  stroke(0, 255, 285);
  strokeWeight(3);


  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

void captureEvent(Capture c) {
  c.read();
}
void webSocketServerEvent(String msg) {
  println(msg);
}
