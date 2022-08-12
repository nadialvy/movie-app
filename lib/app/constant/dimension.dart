import 'package:get/get.dart';

class Dimensions {
  static double screenHeight = Get.context!.height; //667
  static double screenWidth = Get.context!.width; //375

  //font
  static double font8 = screenHeight/83.4;
  static double font10 = screenHeight/66.7;
  static double font12 = screenHeight/55.6;
  static double font14 = screenHeight/47.7;
  static double font16 = screenHeight/41.7;
  static double font18 = screenHeight/37;
  static double font20 = screenHeight/33.35;
  static double font22 = screenHeight/30;
  static double font26 = screenHeight/25.7;
  static double font28 = screenHeight/23.8;
  static double font60 = screenHeight/11.1;

  // border radius
  static double radius5 = screenHeight/133.4;
  static double radius10 = screenHeight/66.7;
  static double radius17 = screenHeight/39.2;
  static double radius20 = screenHeight/33.35;

  //icon
  static double icon28 = screenHeight/23.8;

  //height
  static double height5 = screenHeight/133.4;
  static double height10 = screenHeight/66.7;
  static double height20 = screenHeight/33.35;
  static double height50 = screenHeight/13.34;
  static double height53 = screenHeight/12.58;
  static double height125 = screenHeight/5.3;
  static double height150 = screenHeight/4.4;
  static double height175 = screenHeight/3.8;
  static double height250 = screenHeight/2.668;

  //width for padding
  static double width5 = screenWidth/82.4;
  static double width10 = screenWidth/40.12;
  static double width20 = screenWidth/20.6;
  static double width40 = screenWidth/10.3;
  static double width75 = screenWidth/5;
  static double width115 = screenWidth/3.3;
  static double width250 = screenWidth/1.5;

  static double cardDouble = screenWidth / 50;
  static int totalCardHorizontal = cardDouble.toInt();

}