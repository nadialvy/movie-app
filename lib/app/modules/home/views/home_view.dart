import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainBlue,
        body: VStack(
          [
            HStack(
              [
                const Text('Now Playing').text.white.size(Dimensions.font18).make(),
                const Text('See All').text.uppercase.size(Dimensions.font14).color(tosca).make()
              ],
              alignment: MainAxisAlignment.spaceBetween,
            ).p20(),
          FutureBuilder(
            future: controller.getNowPlaying(),
            builder: ((context, AsyncSnapshot snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

              var nowPlaying = snapshot.data!;
              // print(nowPlaying[0]);

              return VxSwiper.builder(
                itemCount: nowPlaying.length - 15,
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: VxContinuousRectangle(
                      backgroundImage: DecorationImage(
                        colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.dstATop),
                        image: NetworkImage('http://image.tmdb.org/t/p/w500${nowPlaying[index]["poster_path"]}'),
                        fit: BoxFit.cover,
                      ), 
                      child: VStack(
                        [
                          VxContinuousRectangle(
                            width: 250,
                            height: 125,
                            radius: 20,
                            backgroundImage: DecorationImage(
                              image: NetworkImage('http://image.tmdb.org/t/p/w500${nowPlaying[index]["poster_path"]}'),
                              fit: BoxFit.cover
                            ),  
                          ),
                          '${nowPlaying[index]["original_title"]}'.text.white.bold.size(Dimensions.font18).make(),
                          HStack(
                            [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: Dimensions.font12,
                              ),
                              ' ${nowPlaying[index]["vote_average"]} '.text.size(Dimensions.font14).white.make(),
                              '(${nowPlaying[index]["vote_count"]})'.text.size(Dimensions.font14).white.make(),
                            ]
                          )
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                        alignment: MainAxisAlignment.spaceAround,
                      ),
                      backgroundColor: Colors.grey,
                      radius: 10,
                      width: Get.width,
                    )
                  );
                }
              );
            })
          ),
          const SizedBox(
            height: 5,
          ),
          HStack(
            [const Text('Popular').text.white.size(Dimensions.font18).make(), const Text('See All').text.uppercase.size(Dimensions.font14).color(tosca).make()],
            alignment: MainAxisAlignment.spaceBetween,
            crossAlignment: CrossAxisAlignment.center,
          ).p20(),
        ]
      )
    );
  }
}
