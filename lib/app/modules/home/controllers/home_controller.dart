import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/app/entities/now_playing_model.dart';

class HomeController extends GetxController {
  List<dynamic> nowPlaying = [];
  @override
  void onInit() {
    super.onInit();
    getNowPlaying();
  }

  Future<List<dynamic>> getNowPlaying() async{
    try{
      var resp = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=81728309a12b337c7334a06681733deb')
      );

      nowPlaying = json.decode(resp.body)['results'] as List;
      update();

      return nowPlaying;
    }catch (e){
      print(e);
      return [
        "message", "Cannot get data"
      ];
    }
  }

  // void getPopular() async{
  //   try{
  //     var resp = await http.get(
  //       Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=81728309a12b337c7334a06681733deb')
  //     );

  //     Map<String, dynamic> popular = json.decode(resp.body);
  //   }catch(e){
  //     print(e);
  //   }
  // }

  // void getTopRated() async{
  //   try{
  //     var resp = await http.get(
  //       Uri.parse('https://api.themoviedb.org/3/movie/most_rated?api_key=81728309a12b337c7334a06681733deb')
  //     );

  //     Map<String, dynamic> topRated = json.decode(resp.body);
  //   }catch(e){
  //     print(e);
  //   }
  // }

  // void getUpcoming() async{
  //   try{
  //     var resp = await http.get(
  //       Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=81728309a12b337c7334a06681733deb')
  //     );

  //     Map<String, dynamic> upcoming = json.decode(resp.body);
  //   }catch(e){
  //     print(e);
  //   }
  // }

}
