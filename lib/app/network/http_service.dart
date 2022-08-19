import 'package:get/get.dart';

class HttpService extends GetConnect{
  final BASE_URL = 'https://api.themoviedb.org/3/';
  static const API_KEY = '81728309a12b337c7334a06681733deb';

  Future<Response> getHttp(String endpoint, Map<String, dynamic> query,){
    return get(BASE_URL+endpoint, query: query);
  }

}