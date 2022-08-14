import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:movie_app/app/widgets/carousel.dart';
import 'package:movie_app/app/widgets/list_card_horizontal.dart';
import 'package:movie_app/app/widgets/on_empty.dart';
import 'package:movie_app/app/widgets/title_list_card_horizontal.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/on_error.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (data) => Scaffold(
        backgroundColor: mainBlue,
        body: SingleChildScrollView(
          child: VStack([
            // === NOW PLAYING SECTION === 
            controller.obx(
              (data) => VStack(
                [
                  TitleListCardHorizontal(listMovie: controller.listNowPlaying, title: 'Now Playing'),
                  controller.listNowPlaying.isNotEmpty || controller.listNowPlaying.length != null ? Carousel(listMovie: controller.listNowPlaying) : const CircularProgressIndicator()
                ]
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (String? err) => const OnError(),
              onEmpty: const OnEmpty(),
            ),
            
            // === POPULAR SECTION ====
            controller.obx(
              (data) => VStack(
                [
                  TitleListCardHorizontal(listMovie: controller.listPopular, title: 'Popular'),
                  controller.listPopular.isNotEmpty || controller.listPopular.length != null ? ListCardHorizontal(listMovie: controller.listPopular) : const CircularProgressIndicator()
                ]
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (String? err) => const OnError(),
              onEmpty: const OnEmpty(),
            ),

            // === TOP RATED SECTION ====
            controller.obx(
              (data) => VStack(
                [
                  TitleListCardHorizontal(listMovie: controller.listTopRated, title: 'Top Rated'),
                  controller.listTopRated.isNotEmpty || controller.listTopRated.length != null ? ListCardHorizontal(listMovie: controller.listTopRated) : const CircularProgressIndicator()
                ]
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (String? err) => const OnError(),
              onEmpty: const OnEmpty(),
            ),

            // === UPCOMING SECTION ====
            controller.obx(
              (data) => VStack(
                [
                  TitleListCardHorizontal(listMovie: controller.listUpcoming, title: 'Upcoming'),
                  controller.listUpcoming.isNotEmpty || controller.listUpcoming.length != null ? ListCardHorizontal(listMovie: controller.listUpcoming) : const CircularProgressIndicator()
                ]
              ),
              onLoading: const Center(child: CircularProgressIndicator()),
              onError: (String? err) => const OnError(),
              onEmpty: const OnEmpty(),
            ),
            SizedBox(height: Dimensions.height20,),
          ]),
        )
      ),onLoading: const Center(child: CircularProgressIndicator(),)
    );
  }
}
