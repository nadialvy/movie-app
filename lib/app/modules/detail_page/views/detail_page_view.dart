import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/widgets/on_empty.dart';
import 'package:movie_app/app/widgets/on_error.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimension.dart';
import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Scaffold(
        backgroundColor: mainBlue,
        body: VxScrollVertical(
          physics: const AlwaysScrollableScrollPhysics(),
          child: VStack(
            [
              VxBox(
                child: Image(
                  image: NetworkImage('http://image.tmdb.org/t/p/w500${controller.detailMovie["poster_path"]}'),
                  fit: BoxFit.cover,
                )
              ).color(secondaryBlue).height(Get.height * 0.5).width(Get.width).make(),
              VStack(
                [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          '${controller.detailMovie["title"]}',
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
                        maxRating: 5.0,
                        value: controller.detailMovie['vote_average'] / 2.0,
                        count: 5,
                        selectionColor: Colors.yellow,
                        normalColor: Colors.grey,
                        size: Dimensions.font14,
                        onRatingUpdate: (String val) {},
                      ),
                      const Text(' (5.12k reviews)').text.light.size(Dimensions.font14).white.make()
                    ]
                  ),
                  SizedBox(height: Dimensions.width10,),

                  Text(
                    controller.getGenresName(controller.detailMovie["genres"])
                    .join(", ")
                  ).text.light.color(const Color.fromARGB(255, 210, 209, 209)).size(Dimensions.font14).make(),
                  
                  SizedBox(height: Dimensions.width10,),
                  
                  Text(
                    controller.detailMovie["release_date"]
                  ).text.light.color(const Color.fromARGB(255, 210, 209, 209)).size(Dimensions.font14).make(),
                  
                  SizedBox(height: Dimensions.width10,),
                  HStack(
                    [
                      Icon(
                        Icons.access_time,
                        color: tosca,
                        size: Dimensions.font14,
                      ),
                      Text(' ${controller.durationToString(controller.detailMovie["runtime"])}').text.light.color(tosca).size(Dimensions.font14).make()
                    ]
                  ),
                  SizedBox(height: Dimensions.height20,),
                  const Text('Overview').text.white.semiBold.size(Dimensions.font20).make(),
                  SizedBox(height: Dimensions.height10,),
                  Text('${controller.detailMovie["overview"]}').text.white.light.size(Dimensions.font14).make(),
                ]
              ).p20()
            ]
          ),
        ),
      ),
      onEmpty: const OnEmpty(),
      onLoading: const Center(
        child: CircularProgressIndicator(),
      ),
      onError: (String? err) => const OnError(),
    );
  }
}
