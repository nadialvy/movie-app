import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/home/controllers/home_controller.dart';
import 'package:movie_app/app/modules/see_all/repository/see_all_repository.dart';
import '../../../models/list_movie_model.dart';

class SeeAllController extends GetxController{
  final SeeAllRepository seeAllRepository;
  SeeAllController({required this.seeAllRepository}); 
  
  List<dynamic> dataArguments = Get.arguments;
  late Map<String, dynamic> title = dataArguments[0];
  late List<Results> listMoviePage1 = dataArguments[1];
  var listAllMovies = <Results>[].obs;

  //for pagination
  var page = 1;
  ScrollController scrollController = ScrollController();
  var isMoreDataAvailable = true.obs;

  @override
  void onInit() {
    super.onInit();
    listAllMovies.value = listMoviePage1;
    paginateSeeAll();
  }

  void refreshList(){
    page = 1;
    getMoreMovies(title["title"], 1);
    listMoviePage1.clear();
    listAllMovies.value.clear();
  }

  void paginateSeeAll(){
    scrollController.addListener(() {
      if(scrollController.position.pixels == scrollController.position.maxScrollExtent){
        page++;
        getMoreMovies(title["title"], page);
      }
    });
  }

  void getMoreMovies(String title, int page) async {
    if(title == 'Now Playing'){
      await seeAllRepository.getSeeAllMovie('now_playing', page.toString()).then((result){
        if(ListMovieModel.fromJson(result.body).results!.isNotEmpty){
          isMoreDataAvailable(true);
          listAllMovies.addAll(ListMovieModel.fromJson(result.body).results!);
        }else{
          isMoreDataAvailable(false);
        }
      }, onError: (err){
        isMoreDataAvailable(false);
      });
    }
    else if(title == 'Popular'){
      await seeAllRepository.getSeeAllMovie('popular', page.toString()).then((result){
        if(ListMovieModel.fromJson(result.body).results!.isNotEmpty){
          isMoreDataAvailable(true);
          listAllMovies.addAll(ListMovieModel.fromJson(result.body).results!);
        }else{
          isMoreDataAvailable(false);
        }
      }, onError: (err){
        isMoreDataAvailable(false);
      });
    }
    else if(title == 'Top Rated'){
      await seeAllRepository.getSeeAllMovie('top_rated', page.toString()).then((result){
        if(ListMovieModel.fromJson(result.body).results!.isNotEmpty){
          isMoreDataAvailable(true);
          listAllMovies.addAll(ListMovieModel.fromJson(result.body).results!);
        }else{
          isMoreDataAvailable(false);
        }
      }, onError: (err){
        isMoreDataAvailable(false);
      });

    
    }
    else if(title == 'Upcoming'){
      await seeAllRepository.getSeeAllMovie('upcoming', page.toString()).then((result){
        if(ListMovieModel.fromJson(result.body).results!.isNotEmpty){
          isMoreDataAvailable(true);
          listAllMovies.addAll(ListMovieModel.fromJson(result.body).results!);
        }else{
          isMoreDataAvailable(false);
        }
      }, onError: (err){
        isMoreDataAvailable(false);
      });
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    scrollController.dispose();
  }
}
