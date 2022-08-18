import 'package:get/get.dart';
import 'package:movie_app/app/network/http_service.dart';

class SeeAllRepository extends GetConnect{
  final http = HttpService();

  Future<Response> getNowPlaying([String page = "1"]) => http.getHttp('movie/now_playing', page);
  Future<Response> getPopular([String page = "1"]) => http.getHttp('movie/popular', page);
  Future<Response> getTopRated([String page = "1"]) => http.getHttp('movie/top_rated', page);
  Future<Response> getUpcoming([String page = "1"]) => http.getHttp('movie/upcoming', page);
}