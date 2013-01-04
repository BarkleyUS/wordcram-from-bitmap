import wordcram.*;

public class WordCloud {

  PApplet parent;
  WordCram wc;
  PGraphics canvas;
  ArrayList<PVector> blackPixels = new ArrayList<PVector>();
  PImage sourceImage;

  WordCloud(PApplet pParent) {
    parent = pParent;
    canvas = createGraphics(width, height, JAVA2D);
    sourceImage = loadImage("image.jpg");
  }

  void init() {
    getBlackPixels();
    wc = new WordCram(parent).fromTextFile("text.txt").withCustomCanvas(canvas).withColor(color(0)).angledAt(radians(30), radians(-60)).withPlacer(fromBitmap()).sizedByWeight(15, 100);
  }

  void reset() {
    wc = null;
    canvas.beginDraw();
    canvas.background(0, 0);
    canvas.endDraw();
    blackPixels.clear();
  }

  public PImage getSourceImage() {
    return sourceImage;
  }


  void update() {
    if (wc == null) return;
    if (wc.hasMore()) {
      canvas.beginDraw();
      setAppState(BUILDING_CLOUD);
      wc.drawNext();
      canvas.endDraw();
    } 
    else {
      setAppState(IDLE);
    }
  }

  PGraphics canvas() {
    return canvas;
  }

  public void getBlackPixels() {
    sourceImage.loadPixels();
    for (int x = 0; x<sourceImage.width; x++) {
      for (int y = 0; y<sourceImage.height; y++) {
        if (red(sourceImage.pixels[x+(y*sourceImage.width)])<1) {
          blackPixels.add(new PVector(x, y));
        }
      }
    }
  }

  WordPlacer fromBitmap() {
    return new WordPlacer() {
      public PVector place(Word word, int rank, int wordCount, int wordWidth, int wordHeight, int fieldWidth, int fieldHeight) {
        Collections.shuffle(blackPixels);
        return blackPixels.get(0);
      }
    };
  }
}

