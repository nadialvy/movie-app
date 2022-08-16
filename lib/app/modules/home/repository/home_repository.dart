import 'package:get/get.dart';
import 'package:movie_app/app/network/http_service.dart';

class HomeRepository extends GetConnect{
  final http = HttpService();

  Future<Response> getNowPlaying([String page = "1"]) => http.getHttp('movie/now_playing', page);
  Future <Response> getPopular() => http.getHttp('movie/popular');
  Future <Response> getTopRated() => http.getHttp('movie/top_rated');
  Future <Response> getUpcoming() => http.getHttp('movie/upcoming');
  Future <Response> getDataGenre() => http.getHttp('genre/movie/list');
}
