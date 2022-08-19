import 'package:get/get.dart';
import 'package:movie_app/app/network/http_service.dart';

class HomeRepository extends GetConnect{
  final http = HttpService();

  Future<Response> getNowPlaying([String page = "1"]) => http.getHttp('movie/now_playing', {"api_key" : HttpService.API_KEY, "page" : page});
  Future <Response> getPopular([String page = "1"]) => http.getHttp('movie/popular',  {"api_key" : HttpService.API_KEY, "page" : page});
  Future <Response> getTopRated([String page = "1"]) => http.getHttp('movie/top_rated',  {"api_key" : HttpService.API_KEY, "page" : page});
  Future <Response> getUpcoming([String page = "1"]) => http.getHttp('movie/upcoming',  {"api_key" : HttpService.API_KEY, "page" : page});
  Future <Response> getDataGenre([String page = "1"]) => http.getHttp('genre/movie/list',  {"api_key" : HttpService.API_KEY, "page" : page});
}
