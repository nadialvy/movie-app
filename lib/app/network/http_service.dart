import 'package:get/get.dart';

class HttpService extends GetConnect{
  final BASE_URL = 'https://api.themoviedb.org/3/';
  final API_KEY = '81728309a12b337c7334a06681733deb';

  Future<Response> getHttp(String endpoint, [String page = "1"]){
    return get(BASE_URL+endpoint, query: {
      "api_key" : API_KEY,
      "page" : page
    });
  }
}