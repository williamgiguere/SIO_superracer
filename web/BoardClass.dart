part of super_racer;

class Board {

  RaceMap raceMap;

  //Using time to redraw board
  Timer timer;

  CanvasElement canvas;
  CanvasRenderingContext2D context;

  //Board size (using width and height to fit canvas size)
  num width;
  num height;

  RaceCar racecar;

  //Lap Counter Images
  ImageElement lap1 = new ImageElement (src: "/media/lap1.png");
  ImageElement lap2 = new ImageElement (src: "/media/lap2.png");
  ImageElement lap3 = new ImageElement (src: "/media/lap3.png");
  ImageElement youWin = new ImageElement (src: "/media/youwin.png");


  //Boolean to indicate car collision
  bool canMoveLeft = true;
  bool canMoveRight = true;
  bool canMoveFront = true;
  bool canMoveBack = true;

  //Indicates the number of laps the player has done
  int lapNumber = 0;

  //Drawing the board to fit the canvas
  Board(this.canvas, this.raceMap) {
    context = canvas.getContext("2d");
    width = canvas.width;
    height = canvas.height;
  }

  //Initial 'Draw'
  void init() {
    context.beginPath();
    context.drawImageScaledFromSource(raceMap.background, 0, 0, 512, 512, 0, 0, 1024, 1024);
    context.closePath();
    context.fill();
    racecar = new RaceCar(this, raceMap.startX, raceMap.startY);
    // redraw every 10 ms
    timer = new Timer.periodic(const Duration(milliseconds: 10),
        // 't' to call back timer to redraw board every duration
        (t) => redraw());
  }

  // Using clear to ensure every element is erased from the canvas before redraw
  void clear() {
    context.clearRect(0, 0, width, height);
  }

  void redraw() {
      clear();
      racecar.draw();
      context.beginPath();
      context.drawImageScaledFromSource(raceMap.background, racecar.carPositionX/2, racecar.carPositionY/2, 512, 512, 0, 0, 1024, 1024);
      context.closePath();
      context.fill();


      //Right collisions
      for (var i = 0; i < raceMap.collisions.length; i++) {
        if (raceMap.collisions.elementAt(i)['x'] <= racecar.carPositionX + racecar.carWidth &&
         raceMap.collisions.elementAt(i)['x'] + raceMap.collisions.elementAt(i)['width'] > racecar.carPositionX &&
         raceMap.collisions.elementAt(i)['y'] < racecar.carPositionY + racecar.carHeight &&
         raceMap.collisions.elementAt(i)['height'] + raceMap.collisions.elementAt(i)['y'] > racecar.carPositionY ||
         racecar.carPositionX + racecar.carWidth >= 508) {
           canMoveRight = false; {racecar.carPositionX -= racecar.collisionImpact;
         }
           racecar.draw();
         } else if (racecar.carPositionX < 508) {
           canMoveRight = true;
         }
      }

      //Left collisions
      for (var i = 0; i < raceMap.collisions.length; i++) {
        if (raceMap.collisions.elementAt(i)['x'] < racecar.carPositionX + racecar.carWidth &&
        raceMap.collisions.elementAt(i)['x'] + raceMap.collisions.elementAt(i)['width'] >= racecar.carPositionX &&
        raceMap.collisions.elementAt(i)['y'] < racecar.carPositionY + racecar.carHeight &&
        raceMap.collisions.elementAt(i)['height'] + raceMap.collisions.elementAt(i)['y'] > racecar.carPositionY ||
        racecar.carPositionX <= 4) {
          canMoveLeft = false; {racecar.carPositionX += racecar.collisionImpact;
          }
          racecar.draw();
        } else if (racecar.carPositionX > 4) {
          canMoveLeft = true;
        }
      }


      //Front collisions
      for (var i = 0; i < raceMap.collisions.length; i++) {
        if (raceMap.collisions.elementAt(i)['x'] < racecar.carPositionX + racecar.carWidth &&
        raceMap.collisions.elementAt(i)['x'] + raceMap.collisions.elementAt(i)['width'] > racecar.carPositionX &&
        raceMap.collisions.elementAt(i)['y'] < racecar.carPositionY + racecar.carHeight &&
        raceMap.collisions.elementAt(i)['height'] + raceMap.collisions.elementAt(i)['y'] >= racecar.carPositionY ||
        racecar.carPositionY <= 4) {
          canMoveFront = false; {racecar.carPositionY += racecar.collisionImpact;
          }
          racecar.draw();
        } else if (racecar.carPositionY > 4) {
          canMoveFront = true;
        }
      }

      //Back collisions
      for (var i = 0; i < raceMap.collisions.length; i++) {
         if (raceMap.collisions.elementAt(i)['x'] < racecar.carPositionX + racecar.carWidth &&
         raceMap.collisions.elementAt(i)['x'] + raceMap.collisions.elementAt(i)['width'] > racecar.carPositionX &&
         raceMap.collisions.elementAt(i)['y'] <= racecar.carPositionY + racecar.carHeight &&
         raceMap.collisions.elementAt(i)['height'] + raceMap.collisions.elementAt(i)['y'] > racecar.carPositionY ||
         racecar.carPositionY + racecar.carHeight >= 508) {
           canMoveBack = false; {racecar.carPositionY -= racecar.collisionImpact;
           }
           racecar.draw();
         } else if (racecar.carPositionY < 508) {
           canMoveBack = true;
         }
      }


      if (racecar.backDown && canMoveBack && racecar.speed <= racecar.maxSpeed) {racecar.speed *= 2; racecar.carPositionY += racecar.speed;
      }
      else if (racecar.backDown && canMoveBack && racecar.speed >= racecar.maxSpeed) {racecar.carPositionY += racecar.maxSpeed;
      }
      if (racecar.frontDown && canMoveFront && racecar.speed <= racecar.maxSpeed) {racecar.speed *= 2; racecar.carPositionY -= racecar.speed;
      }
      else if (racecar.frontDown && canMoveFront && racecar.speed >= racecar.maxSpeed) {racecar.carPositionY -= racecar.maxSpeed;
      }
      if (racecar.rightDown && canMoveRight && racecar.speed <= racecar.maxSpeed) {racecar.speed *= 2; racecar.carPositionX += racecar.speed;
      }
      else if (racecar.rightDown && canMoveRight && racecar.speed >= racecar.maxSpeed) {racecar.carPositionX += racecar.maxSpeed;
      }
      if (racecar.leftDown && canMoveLeft && racecar.speed <= racecar.maxSpeed) {racecar.speed *= 2; racecar.carPositionX -= racecar.speed;
      }
      else if (racecar.leftDown && canMoveLeft && racecar.speed >= racecar.maxSpeed) {racecar.carPositionX -= racecar.maxSpeed;
      }

      if (!racecar.leftDown && !racecar.backDown && !racecar.frontDown && !racecar.rightDown) {racecar.speed = 0.1;
      }
      racecar.draw();


      //Lap Counter
      if (raceMap.finishLine['x'] < racecar.carPositionX &&
      raceMap.finishLine['x'] + raceMap.finishLine['width'] > racecar.carPositionX &&
      raceMap.finishLine['y'] <= racecar.carPositionY &&
      raceMap.finishLine['height'] + raceMap.finishLine['y'] >= racecar.carPositionY &&
      racecar.frontDown) {
        lapNumber += 1;
      } else if (raceMap.finishLine['x'] < racecar.carPositionX &&
      raceMap.finishLine['x'] + raceMap.finishLine['width'] > racecar.carPositionX &&
      raceMap.finishLine['y'] <= racecar.carPositionY &&
      raceMap.finishLine['height'] + raceMap.finishLine['y'] >= racecar.carPositionY &&
      racecar.backDown) {
        lapNumber -= 1;
      }

      if (lapNumber < 2) {
        context.beginPath();
        context.drawImage(lap1, 450, 0);
        context.closePath();
        context.fill();
      }
      if (1 < lapNumber && lapNumber < 3) {
        context.beginPath();
        context.drawImage(lap2, 450, 0);
        context.closePath();
        context.fill();
      }
      if (2 < lapNumber && lapNumber < 4) {
        context.beginPath();
        context.drawImage(lap3, 450, 0);
        context.closePath();
        context.fill();
      }
      if (3 < lapNumber) {
        context.beginPath();
        context.drawImage(youWin, 10, 106);
        context.closePath();
        context.fill();
        }


  }
}
