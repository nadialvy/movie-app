
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constant/colors.dart';
import '../constant/dimension.dart';
import '../models/list_movie_model.dart';

class DetailMovie extends StatelessWidget {
  const DetailMovie({
    Key? key,
    required this.detailMovie,
  }) : super(key: key);

  final Results detailMovie;

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
                      ).text.overflow(TextOverflow.visible).semiBold.white.size(Dimensions.font20).make(),
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
                SizedBox(height: Dimensions.height10,),
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
                SizedBox(height: Dimensions.width10,),
                const Text('Fantasy, Action, Adventure').text.light.color(const Color.fromARGB(255, 210, 209, 209)).size(Dimensions.font14).make(),
                SizedBox(height: Dimensions.width10,),
                Text('${detailMovie.releaseDate}').text.light.color(const Color.fromARGB(255, 210, 209, 209)).size(Dimensions.font14).make(),
                SizedBox(height: Dimensions.width10,),
                HStack(
                  [
                    Icon(
                      Icons.access_time,
                      color: tosca,
                      size: Dimensions.font14,
                    ),
                    const Text(' 2:45').text.light.color(tosca).size(Dimensions.font14).make()
                  ]
                ),
                SizedBox(height: Dimensions.height20,),
                const Text('Overview').text.white.semiBold.size(Dimensions.font20).make(),
                SizedBox(height: Dimensions.height10,),
                Text('${detailMovie.overview}').text.white.light.size(Dimensions.font14).make(),
              ]
            ).p20()
          ]
        ),
      ),
    );
  }
}
