import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainBlue,
        body: SingleChildScrollView(
          child: VStack(
            [
              VxBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Row(
                        children: [
                          Text('Now Playing').text.white.size(Dimensions.font18).make(),
                          Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    FutureBuilder(
                      future: controller.getNowPlaying(),
                      builder: ((context, AsyncSnapshot snapshot){
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        var nowPlaying = snapshot.data!;

                        return VxSwiper.builder(
                          itemCount: nowPlaying.length - 15,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: VxContinuousRectangle(
                                backgroundColor: Colors.black,
                                radius: 10,
                                backgroundImage: DecorationImage(
                                  colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
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
                              )
                            );
                          }
                        );
                      })
                    ),
                  ]
                )
              ).make(),

              VxBox(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      child: Row(
                        children: [
                          Text('Popular').text.white.size(Dimensions.font18).make(),
                          Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    VxBox(
                      child: FutureBuilder(
                        future: controller.getPopular(),
                        builder: ((context, AsyncSnapshot snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var popular = snapshot.data!;
                          String dateStr = popular[0]['release_date'];
                          print(DateTime.parse(dateStr));
                          

                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: popular.length - 15,
                            itemBuilder: (context, index){
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: VxContinuousRectangle(
                                  backgroundColor: secondaryBlue,
                                  radius: Dimensions.radius10,
                                  width: 115,
                                  child: VStack(
                                    [
                                      Container(
                                        height: 150,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(Dimensions.radius5),
                                            topLeft: Radius.circular(Dimensions.radius5),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage('http://image.tmdb.org/t/p/w500${popular[index]["poster_path"]}'),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: VStack(
                                          [
                                            SizedBox(height: 10,),
                                            Text(
                                              '${popular[index]["title"]}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: Dimensions.font14,
                                                color: Colors.white
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            VStack(
                                              [
                                                Text('${DateFormat.y().format(DateTime.parse(popular[index]["release_date"]))} Action').text.size(Dimensions.font8).white.make(),
                                                HStack(
                                                  [
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                      size: Dimensions.font12,
                                                    ),
                                                    ' ${popular[index]["vote_average"]} '.text.size(Dimensions.font8).white.make(),
                                                    '(${popular[index]["vote_count"]})'.text.size(Dimensions.font8).white.make(),
                                                  ]
                                                )
                                              ]
                                            )
                                          ],
                                          alignment: MainAxisAlignment.spaceBetween,
                                          crossAlignment: CrossAxisAlignment.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              );
                            }
                          );
                        })
                      ),
                    ).height(225).make(),
                  ],
                ),
              ).make(),
              VxBox().make(),
            ]
          ),
        )
    );
  }
}
