import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:movie_app/app/routes/app_pages.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constant/colors.dart';
import '../models/list_movie_model.dart';

class TitleListCardHorizontal extends StatelessWidget {
  final RxList<Results> listMovie;
  final String title;

  const TitleListCardHorizontal({required this.listMovie, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
      child: Row(
        children: [
          Text(title).text.white.semiBold.size(Dimensions.font18).make(),
          InkWell(
            onTap: (){
              Get.toNamed(
                Routes.SEE_ALL,
                arguments: [
                  {"title" : title},
                  listMovie,
                ]
              );
            },
            child: const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make()
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}