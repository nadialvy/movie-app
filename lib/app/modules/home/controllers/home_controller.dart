import 'package:get/get.dart';
import 'package:movie_app/app/models/list_movie_model.dart';
import 'package:movie_app/app/modules/home/repository/home_repository.dart';
import '../../../models/genre_model.dart';

class HomeController extends GetxController with StateMixin {
  final HomeRepository homeRepository;
  HomeController({required this.homeRepository});

  final listNowPlaying = <Results>[].obs;
  final listPopular = <Results>[].obs;
  final listTopRated = <Results>[].obs;
  final listUpcoming = <Results>[].obs;
  final listDataGenres = <Genres>[].obs;

  @override
  void onInit() {
    super.onInit();

    fetchDataGenres();
    fetchNowPlaying();
    fetchPopular();
    fetchUpcoming();
    fetchTopRated();
    
  }

  void fetchDataGenres() async{
    change(null, status: RxStatus.loading());
    await homeRepository.getDataGenre().then((result){
      listDataGenres.value = GenreModel.fromJson(result.body).genres!;
      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error());
    });
  }

  List<String?> getGenreNameById(List<int> genreIds){
    List<Genres> filteredGenres = [];
    filteredGenres.addAll(listDataGenres);
    filteredGenres.retainWhere((element) => genreIds.contains(element.id));

    return filteredGenres.map((element) => element.name).toList();
  }

  void fetchNowPlaying() async {
    change(null, status: RxStatus.loading());
    await homeRepository.getNowPlaying().then((result){
      listNowPlaying.value = ListMovieModel.fromJson(result.body).results!;

      if(listNowPlaying.value.isEmpty){
        change(null, status: RxStatus.empty());
      } else {
        change(null, status: RxStatus.success());
      }

    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    },);
  }

  void fetchPopular() async {
    change(null, status: RxStatus.loading());
    await homeRepository.getPopular().then((result){
      listPopular.value = ListMovieModel.fromJson(result.body).results!;

      if(listPopular.value.isEmpty){
        change(null, status: RxStatus.empty());
      }else {
        change(null, status: RxStatus.success());
      }

    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  void fetchTopRated() async {
    change(null, status: RxStatus.loading());
    await homeRepository.getTopRated().then((result){
      listTopRated.value = ListMovieModel.fromJson(result.body).results!;

      if(listTopRated.value.isEmpty){
        change(null, status: RxStatus.empty());
      }else {
        change(null, status: RxStatus.success());
      }

      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });

  }

  void fetchUpcoming() async {
    change(null, status: RxStatus.loading());
    await homeRepository.getUpcoming().then((result){
      listUpcoming.value = ListMovieModel.fromJson(result.body).results!;

      if(listUpcoming.value.isEmpty){
        change(null, status: RxStatus.empty());
      }else {
        change(null, status: RxStatus.success());
      }

      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

}
