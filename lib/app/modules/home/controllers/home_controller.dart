import 'package:get/get.dart';
import 'package:movie_app/app/models/list_movie_model.dart';
import 'package:movie_app/app/modules/home/repository/homeProvider.dart';

import '../../../models/genre_model.dart';

class HomeController extends GetxController with StateMixin {
  final HomeProvider homeProvider;
  HomeController({required this.homeProvider});

  final listNowPlaying = <Results>[].obs;
  final listPopular = <Results>[].obs;
  final listTopRated = <Results>[].obs;
  final listUpcoming = <Results>[].obs;
  final listDataGenres = <Genres>[].obs;
  final listUpdateGenre = <Genres>[].obs;
  
  @override
  void onInit() {
    super.onInit();

    fetchDataGenres();
    fetchNowPlaying();
    fetchPopular();
    fetchTopRated();
    fetchUpcoming();
  }

  void fetchDataGenres() async{
    change(null, status: RxStatus.loading());
    await homeProvider.getDataGenre().then((result){
      listDataGenres.value = GenreModel.fromJson(result.body).genres!;
      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error());
    }
    );
  }

  void fetchNowPlaying() async {
    change(null, status: RxStatus.loading());
    await homeProvider.getNowPlaying().then((result){
      listNowPlaying.value = ListMovieModel.fromJson(result.body).results!;

      for (var dataGenre in listDataGenres) {        
        for (var value in listNowPlaying) {
          for(int i = 0; i < value.genreIds!.length; i++){
            if(dataGenre.id == value.genreIds![i]){
              value.genreIds!.add(dataGenre.name);
            }
          }
        }
      }
      

      for(var value in listNowPlaying){
        value.genreIds!.removeWhere((element) => element.runtimeType == int);
      }

      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void fetchPopular() async {
    change(null, status: RxStatus.loading());
    await homeProvider.getPopular().then((result){
      listPopular.value = ListMovieModel.fromJson(result.body).results!;

      for (var dataGenre in listDataGenres) {
        for (var value in listPopular) {
          for(int i = 0; i < value.genreIds!.length; i++){
            if(dataGenre.id == value.genreIds![i]){
              value.genreIds!.add(dataGenre.name);
            }
          }
        }
      }

      for(var value in listPopular){
        value.genreIds!.removeWhere((element) => element.runtimeType == int);
      }
      

      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void fetchTopRated() async {
    change(null, status: RxStatus.loading());
    await homeProvider.getTopRated().then((result){
      listTopRated.value = ListMovieModel.fromJson(result.body).results!;

      for (var dataGenre in listDataGenres) {
        for (var value in listTopRated) {
          for(int i = 0; i < value.genreIds!.length; i++){
            if(dataGenre.id == value.genreIds![i]){
              value.genreIds!.add(dataGenre.name);
            }
          }
        }
      }

      for(var value in listTopRated){
        value.genreIds!.removeWhere((element) => element.runtimeType == int);
      }

      listTopRated.forEach((value){
        print(value.genreIds);
      });

      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });

  }

  void fetchUpcoming() async {
    change(null, status: RxStatus.loading());
    await homeProvider.getUpcoming().then((result){
      listUpcoming.value = ListMovieModel.fromJson(result.body).results!;

      for (var dataGenre in listDataGenres) {
        for (var value in listUpcoming) {
          for(int i = 0; i < value.genreIds!.length; i++){
            if(dataGenre.id == value.genreIds![i]){
              value.genreIds!.add(dataGenre.name);
            }
          }
        }
      }

      for(var value in listUpcoming){
        value.genreIds!.removeWhere((element) => element.runtimeType == int);
      }

      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });

  }
}
