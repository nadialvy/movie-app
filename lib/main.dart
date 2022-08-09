import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/constant/colors.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'Roboto',
        primaryColor: mainBlue,
      ),
      debugShowCheckedModeBanner: false,
      title: "Movie App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
