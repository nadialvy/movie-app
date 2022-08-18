import 'package:get/get.dart';
import 'package:movie_app/app/network/http_service.dart';

class DetailPageRepository extends GetConnect{
  final http = HttpService();

  Future<Response> getDetailMovie(String id) => http.getDetail('movie/', id);
}