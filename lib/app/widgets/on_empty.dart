import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class OnEmpty extends StatelessWidget {
  const OnEmpty({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBox(
      child: Image.asset(
        'assets/images/nodata.jpg',
        fit: BoxFit.cover,
      )
    ).color(Colors.white).width(Get.width).height(250).make();
  }
}