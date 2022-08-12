import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/list_movie_model.dart';
import '../../../widgets/list_all_movie.dart';
import '../controllers/see_all_controller.dart';

class SeeAllView extends GetView<SeeAllController> {
  List<dynamic> dataArguments = Get.arguments;

  late Map<String, dynamic> title = dataArguments[0];
  late RxList<Results> listMovie = dataArguments[1];

  @override
  Widget build(BuildContext context) {
    return ListAllMovies(title: title, listMovie: listMovie);
  }
}

