import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:movie_app/app/widgets/carousel.dart';
import 'package:movie_app/app/widgets/list_card_horizontal.dart';
import 'package:movie_app/app/widgets/on_empty.dart';
import 'package:movie_app/app/widgets/title_list_card_horizontal.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../widgets/on_error.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBlue,
      body: SingleChildScrollView(
        child: controller.obx((data) => 
          VStack(
            [
              // === NOW PLAYING SECTION === 
              controller.obx(
                (data) => VStack(
                  [
                    TitleListCardHorizontal(listMovie: controller.listNowPlaying, title: 'Now Playing'),
                    Carousel(listMovie: controller.listNowPlaying)
                  ]
                ),
                onError: (String? err) => const OnError(),
                onEmpty:const OnEmpty(),
                onLoading: const Center(child: CircularProgressIndicator())
              ),
              
              // === POPULAR SECTION ====
              controller.obx(
                (data) => VStack(
                  [
                    TitleListCardHorizontal(listMovie: controller.listPopular, title: 'Popular'),
                    ListCardHorizontal(listMovie: controller.listPopular)
                  ]
                ),
                onError: (String? err) => const OnError(),
                onEmpty: const OnEmpty(),
                onLoading: const Center(child: CircularProgressIndicator())
              ),

              // === TOP RATED SECTION ====
              controller.obx(
                (data) => VStack(
                  [
                    TitleListCardHorizontal(listMovie: controller.listTopRated, title: 'Top Rated'),
                    ListCardHorizontal(listMovie: controller.listTopRated)
                  ]
                ),
                onError: (String? err) => const OnError(),
                onEmpty: const OnEmpty(),
                onLoading: const Center(child: CircularProgressIndicator())
              ),

              // === UPCOMING SECTION ====
              controller.obx(
                (data) => VStack(
                  [
                    TitleListCardHorizontal(listMovie: controller.listUpcoming, title: 'Upcoming'),
                    ListCardHorizontal(listMovie: controller.listUpcoming,),
                  ]
                ),
                onError: (String? err) => const OnError(),
                onEmpty: const OnEmpty(),
                onLoading: const Center(child: CircularProgressIndicator())
              ),
              SizedBox(height: Dimensions.height20,),
            ]
          ),
          onError: (String? err) => const OnError(),
          onEmpty: const OnEmpty(),
          onLoading: const Center(child: CircularProgressIndicator())
        ),
      )
    );
  }

}
