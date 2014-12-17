library super_racer;

import 'dart:html';
import 'dart:async';
import 'dart:math';
import 'package:box2d/box2d.dart'; // Package used in controlling physics
import 'package:stagexl/stagexl.dart';

part 'RaceMapClass.dart';
part 'BoardClass.dart';
part 'RaceCarClass.dart';
//part 'sound.dart';



void main() {

  ImageElement map1Img = new ImageElement(src: "/media/map_images/map_1.png");
  ImageElement map2Img = new ImageElement(src: "/media/map_images/map_2.png");


  RaceMap map1 = new RaceMap (map1Img,
    [{'x': 84, 'y': 80, 'width': 52, 'height': 216},
    {'x': 68, 'y': 276, 'width': 20, 'height': 56},
    {'x': 136, 'y': 188, 'width': 208, 'height': 60},
    {'x': 344, 'y': 208, 'width': 64, 'height': 40},
    {'x': 368, 'y': 248, 'width': 40, 'height': 160},
    {'x': 368, 'y': 4, 'width': 140, 'height': 76},
    {'x': 4, 'y': 436, 'width': 236, 'height': 72}],
    447,
    290,
    {'x': 368, 'y': 280, 'width': 200, 'height': 0});

  RaceMap map2 = new RaceMap (map2Img,
    [{'x':120, 'y':116, 'width':8, 'height':228},
    {'x':124, 'y':100, 'width':20, 'height':20},
    {'x':140, 'y':88, 'width':16, 'height':16},
    {'x':152, 'y':84, 'width':48, 'height':8},
    {'x':196, 'y':72, 'width':16, 'height':12},
    {'x':208, 'y':68, 'width':96, 'height':8},
    {'x':296, 'y':68, 'width':8, 'height':28},
    {'x':304, 'y':88, 'width':56, 'height':8},
    {'x':352, 'y':96, 'width':8, 'height':196},
    {'x':356, 'y':288, 'width':12, 'height':36},
    {'x':364, 'y':320, 'width':16, 'height':16},
    {'x':376, 'y':332, 'width':16, 'height':16},
    {'x':388, 'y':344, 'width':16, 'height':16},
    {'x':400, 'y':356, 'width':16, 'height':16},
    {'x':412, 'y':368, 'width':12, 'height':24},
    {'x':412, 'y':244, 'width':32, 'height':8},
    {'x':476, 'y':244, 'width':32, 'height':8},
    {'x':204, 'y':0, 'width':100, 'height':36},
    {'x':196, 'y':4, 'width':8, 'height':24},
    {'x':124, 'y':340, 'width':16, 'height':16},
    {'x':136, 'y':352, 'width':16, 'height':16},
    {'x':148, 'y':364, 'width':16, 'height':16},
    {'x':160, 'y':376, 'width':16, 'height':16},
    {'x':172, 'y':388, 'width':12, 'height':12},
    {'x':180, 'y':396, 'width':12, 'height':12},
    {'x':280, 'y':284, 'width':8, 'height':224},
    {'x':268, 'y':272, 'width':16, 'height':16},
    {'x':256, 'y':260, 'width':16, 'height':16},
    {'x':248, 'y':252, 'width':12, 'height':12},
    {'x':240, 'y':244, 'width':12, 'height':12},
    {'x':232, 'y':236, 'width':12, 'height':12},
    {'x':224, 'y':228, 'width':12, 'height':12},
    {'x':216, 'y':220, 'width':12, 'height':12}],
    59,
    268,
    {'x': 4, 'y': 258, 'width': 120, 'height': 0});

  //get a reference to the canvas
  CanvasElement canvas = document.querySelector('#canvas');

  Board board1 = new Board(canvas, map1);
  Board board2 = new Board(canvas, map2);

  var resourceManager = new ResourceManager();
    resourceManager.addSound("map", "media/sounds/map1.mp3");
    resourceManager.addSound("map2", "media/sounds/map2.mp3");
    resourceManager.addSound("countdown", "media/sounds/countdown.mp3");
    resourceManager.load().then((_) {
    resourceManager.getSound("map");
    resourceManager.getSound("map2");
    resourceManager.getSound("countdown");
  });


  querySelector('#play1').onClick.listen((e) {
    board1.init();
    resourceManager.getSound("countdown").play();
    new Future.delayed(const Duration(seconds:3), () {
      resourceManager.getSound("map").play();
    });
   });


  querySelector('#play2').onClick.listen((e) {
    board2.init();
    resourceManager.getSound("countdown").play();
    new Future.delayed(const Duration(seconds:3), () {
          resourceManager.getSound("map2").play();
        });
    });


}

