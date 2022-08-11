import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:movie_app/app/models/list_movie_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  Results detailMovie = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      body: VxScrollVertical(
        physics: const AlwaysScrollableScrollPhysics(),
        child: VStack(
          [
            VxBox(
              child: Image(
                image: NetworkImage('http://image.tmdb.org/t/p/w500${detailMovie.posterPath}'),
                fit: BoxFit.cover,
              )
            ).color(secondaryBlue).height(Get.height * 0.5).width(Get.width).make(),
            VStack(
              [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${detailMovie.title}',
                      ).text.overflow(TextOverflow.visible).semiBold.white.size(Dimensions.font22).make(),
                    ),
                    Icon(
                      Icons.bookmark_border,
                      size: Dimensions.font22,
                      color: tosca,
                    )
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
                const SizedBox(height: 10,),
                HStack(
                  [
                    VxRating(
                      onRatingUpdate: (value) {},
                      count: 5,
                      selectionColor: Colors.yellow,
                      size: Dimensions.font14,
                    ),
                    const Text(' (5.12k reviews)').text.light.size(Dimensions.font14).white.make()
                  ]
                ),
                const SizedBox(height: 10,),
                const Text('Fantasy, Action, Adventure').text.light.color(const Color.fromARGB(255, 210, 209, 209)).size(Dimensions.font14).make(),
                const SizedBox(height: 10,),
                Text('${detailMovie.releaseDate}').text.light.color(const Color.fromARGB(255, 210, 209, 209)).size(Dimensions.font14).make(),
                const SizedBox(height: 10,),
                HStack(
                  [
                    //icon jam
                    Icon(
                      Icons.access_time,
                      color: tosca,
                      size: Dimensions.font14,
                    ),
                    const Text(' 2:45').text.light.color(tosca).size(Dimensions.font14).make()
                  ]
                ),
                const SizedBox(height: 20,),
                const Text('Overview').text.white.semiBold.size(Dimensions.font20).make(),
                const SizedBox(height: 8,),
                Text('${detailMovie.overview}').text.white.size(Dimensions.font14).make(),
              ]
            ).p20()
          ]
        ),
      ),
    );
  }
}
