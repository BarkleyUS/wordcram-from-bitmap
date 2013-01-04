import wordcram.*;
import java.util.List;

public final int IDLE = 0;
public final int BUILDING_CLOUD = 1;
WordCloud cloud;
int appState;

void setup() {
  size(800, 600);
  cloud = new WordCloud(this);
  cloud.init();
  setAppState(BUILDING_CLOUD);
}

void draw() {

  switch(appState) {
  case IDLE:
    break;
  case BUILDING_CLOUD:
    background(255);
    cloud.update();
    image(cloud.canvas, 0, 0);
    blend(cloud.getSourceImage(), 0, 0, width, height, 0, 0, width, height, DIFFERENCE);
    break;
  }
}

void setAppState(int state) {
  if (appState==state) return;
  appState = state;
}

