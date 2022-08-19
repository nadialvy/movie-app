import 'package:get/get.dart';
import 'package:movie_app/app/network/http_service.dart';

class SeeAllRepository extends GetConnect{
  final http = HttpService();

  Future<Response> getSeeAllMovie(String endpoint, [String page = "1"]) => http.getHttp('movie/$endpoint', {"api_key" : HttpService.API_KEY, "page" : page});
}