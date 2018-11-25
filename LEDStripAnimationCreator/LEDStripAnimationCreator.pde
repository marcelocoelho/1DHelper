
import gifAnimation.*;

PImage[] animation;
int animationSize;
int currentFrame;


public void setup() {
  size(30, 1);
  
  frameRate(15);
  
  animation = Gif.getPImages(this, "Animation.gif");
  animationSize = animation.length; 
  currentFrame = 0;
 
}

void draw() {
 image(animation[nextFrame()], 0,0);
 
 //println(animation[nextFrame()].width); // grabing pixel width of GIF
 
 println(int(red(animation[nextFrame()].pixels[15])));
  
}


// little helper function to advance frames and loop 
int nextFrame() {
  if (currentFrame < animationSize-1) {
    currentFrame++;
  } else {
    currentFrame = 0;
  }
  return currentFrame;
}
