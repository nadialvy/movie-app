import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/models/list_movie_model.dart';
import '../../../widgets/detail_movie.dart';
import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  Results detailMovie = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return DetailMovie(detailMovie: detailMovie);
  }
}
