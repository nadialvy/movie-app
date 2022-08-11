import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/models/list_movie_model.dart';
import 'package:movie_app/app/modules/home/repository/homeProvider.dart';

class HomeController extends GetxController with StateMixin {
  final HomeProvider homeProvider;
  HomeController({required this.homeProvider});

  final listNowPlaying = <Results>[].obs;
  final listPopular = <Results>[].obs;
  final listTopRated = <Results>[].obs;
  final listUpcoming = <Results>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchNowPlaying();
    fetchPopular();
    fetchTopRated();
    fetchUpcoming();
  }

  void fetchNowPlaying(){
    homeProvider.getNowPlaying().then((result){
      listNowPlaying.value = ListMovieModel.fromJson(result.body).results!;
      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void fetchPopular(){
    homeProvider.getPopular().then((result){
      listPopular.value = ListMovieModel.fromJson(result.body).results!;
      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void fetchTopRated(){
    homeProvider.getTopRated().then((result){
      listTopRated.value = ListMovieModel.fromJson(result.body).results!;
      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void fetchUpcoming(){
    homeProvider.getUpcoming().then((result){
      listUpcoming.value = ListMovieModel.fromJson(result.body).results!;
      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  

}
