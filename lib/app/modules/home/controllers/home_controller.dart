import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List<dynamic> nowPlaying = [];
  List<dynamic> popular = [];
  List<dynamic> topRated = [];

  @override
  void onInit() {
    super.onInit();
    getNowPlaying();
    getTopRated();
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

  Future<List<dynamic>> getPopular() async{
    try{
      var resp = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=81728309a12b337c7334a06681733deb')
      );

      popular = json.decode(resp.body)['results'] as List;
      update();

      return popular;
    }catch(e){
      print(e);
      return [
        "message", "Cannot get data"
      ];
    }
  }

  Future<List<dynamic>> getTopRated() async{
    try{
      var resp = await http.get(
        Uri.parse('https://api.themoviedb.org/3/movie/upcoming?api_key=81728309a12b337c7334a06681733deb&language=en-US&page=1')
      );

     topRated = json.decode(resp.body)['results'] as List;
     update();

     return topRated;
    }catch(e){
      print(e);
      return [
        "message", "Cannot get data"
      ];
    }
  }

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
