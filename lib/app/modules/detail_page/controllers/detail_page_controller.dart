import 'package:get/get.dart';
import 'package:movie_app/app/modules/detail_page/reporitory/detail_page_repository.dart';

import '../../../models/detail_movie_model.dart';

class DetailPageController extends GetxController with StateMixin{
  int movieId = Get.arguments;
  final DetailPageRepository detailPageRepository;
  DetailPageController({required this.detailPageRepository});

  final detailMovie = DetailMovieModel().obs; // cara 1

  // final Rx<DetailMovieModel> detailMovie2; //cara 2

  @override
  void onInit() {
    super.onInit();
    fetchDetailMovie(movieId);
  }

  void fetchDetailMovie(int id) async {
    change(null, status: RxStatus.loading());

    await detailPageRepository.getDetailMovie(movieId.toString()).then((result){
      detailMovie.value = DetailMovieModel.fromJson(result.body);
      change(null, status: RxStatus.success());
    }, onError: (err){
      change(null, status: RxStatus.error(err.toString()));
    });
  }

  String durationToString(int minutes) {
    var d = Duration(minutes:minutes);
    List<String> parts = d.toString().split(':');
    return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
  } 

  List getGenresName(List<Genres> listGenres){
    List genresName = [];
    for (var element in listGenres) {
      genresName.add(element.name);
    }
    return genresName;
  }

}
