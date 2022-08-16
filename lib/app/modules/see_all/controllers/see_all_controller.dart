import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/home/controllers/home_controller.dart';
import 'package:movie_app/app/modules/see_all/repository/see_all_repository.dart';

import '../../../models/list_movie_model.dart';

class SeeAllController extends GetxController{
  final SeeAllRepository seeAllRepository;
  SeeAllController({required this.seeAllRepository}); 

  var homeC = Get.find<HomeController>();
  var pageNowPlaying = 1;
  var pagePopular = 1;
  var pageTopRated = 1;
  var pageUpcoming = 1;
  
  //for pagination
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    paginateNowPlaying();
    paginatePopular();
    paginateTopRated();
    paginateUpcoming();
  }

  void refreshList(){
    pageNowPlaying = 1;
    pagePopular = 1;
    pageTopRated = 1;
    pageUpcoming = 1;
    homeC.fetchNowPlaying();
    homeC.fetchPopular();
    homeC.fetchTopRated();
    homeC.fetchUpcoming();
  }

  void paginateNowPlaying(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        pageNowPlaying++;
        // print('nowplaying = $pageNowPlaying');
        getMoreNowPlaying(pageNowPlaying);
      }
    });
  }

  void getMoreNowPlaying(var page) async {
    await seeAllRepository.getNowPlaying(page.toString()).then((result){
      if(ListMovieModel.fromJson(result.body).results!.isNotEmpty){
        isMoreDataAvailable(true);
        homeC.listNowPlaying.addAll(ListMovieModel.fromJson(result.body).results!);
      }else{
        isMoreDataAvailable(false);
      }
    },
    onError: (err){
      isMoreDataAvailable(false);
    });
  }

  void paginatePopular(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        pagePopular++;
        // print('pop = $pagePopular');
        getMorePopular(pagePopular);
      }
    });
  }

  void getMorePopular(var page) async {
    await seeAllRepository.getPopular(page.toString()).then((result){
      if(ListMovieModel.fromJson(result.body).results!.isNotEmpty){
        isMoreDataAvailable(true);
        homeC.listPopular.addAll(ListMovieModel.fromJson(result.body).results!);
      }else{
        isMoreDataAvailable(false);
      }
    },
    onError: (err){
      isMoreDataAvailable(false);
    });
  }

  void paginateTopRated(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        pageTopRated++;
        // print('toprated : $pageTopRated');
        getMoreTopRated(pageTopRated);
      }
    });
  }

  void getMoreTopRated(var page) async {
    await seeAllRepository.getTopRated(page.toString()).then((result){
      if(ListMovieModel.fromJson(result.body).results!.isNotEmpty){
        isMoreDataAvailable(true);
        homeC.listTopRated.addAll(ListMovieModel.fromJson(result.body).results!);
      }else{
        isMoreDataAvailable(false);
      }
    },
    onError: (err){
      isMoreDataAvailable(false);
    });
  }

  void paginateUpcoming(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        pageUpcoming++;
        // print('UPC : $pageUpcoming');
        getMoreUpcoming(pageUpcoming);
      }
    });
  }

  void getMoreUpcoming(var page) async {
    await seeAllRepository.getUpcoming(page.toString()).then((result){
      if(ListMovieModel.fromJson(result.body).results!.isNotEmpty){
        isMoreDataAvailable(true);
        homeC.listUpcoming.addAll(ListMovieModel.fromJson(result.body).results!);
      }else{
        isMoreDataAvailable(false);
      }
    },
    onError: (err){
      isMoreDataAvailable(false);
    });
  }
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }
}
