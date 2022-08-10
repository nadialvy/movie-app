import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:movie_app/app/routes/app_pages.dart';
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
              // === NOW PLAYING SECTION ====
              VxBox(
                child: VStack(
                  [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                      child: Row(
                        children: [
                          const Text('Now Playing').text.semiBold.white.size(Dimensions.font18).make(),
                          const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make(),
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
                            return InkWell(
                              onTap: (){
                                Get.toNamed(
                                  Routes.DETAIL_PAGE,
                                  arguments: nowPlaying[index]
                                );
                              },
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
                              ).p4(),
                            );
                          }
                        );
                      })
                    ),
                  ]
                )
              ).make(),

              // === POPULAR SECTION ====
              VxBox(
                child: VStack(
                  [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      child: Row(
                        children: [
                          const Text('Popular').text.white.semiBold.size(Dimensions.font18).make(),
                          const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make(),
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

                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: popular.length - 15,
                            itemBuilder: (context, index){

                              return InkWell(
                                onTap: (){
                                  Get.toNamed(
                                    Routes.DETAIL_PAGE,
                                    arguments: popular[index]
                                  );
                                },
                                child: VxContinuousRectangle(
                                  backgroundColor: secondaryBlue,
                                  radius: Dimensions.radius10,
                                  width: 115,
                                  child: VStack(
                                    [
                                      Container(
                                        height: 175,
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
                                      VStack(
                                        [
                                          const SizedBox(height: 10,),
                                          Text('${popular[index]["title"]}',).text.white.size(Dimensions.font14).overflow(TextOverflow.ellipsis).make(),
                                          const SizedBox(height: 10,),
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
                                      ).px12(),
                                    ],
                                  ),
                                ).px4(),
                              );
                            }
                          );
                        })
                      ),
                    ).height(250).make(),
                  ],
                ),
              ).make(),

              // === TOP RATED SECTION ====
              VxBox(
                child: VStack(
                  [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      child: Row(
                        children: [
                          const Text('Top Rated').text.semiBold.white.size(Dimensions.font18).make(),
                          const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    VxBox(
                      child: FutureBuilder(
                        future: controller.getTopRated(),
                        builder: ((context, AsyncSnapshot snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var topRated = snapshot.data!;

                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: topRated.length - 15,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(
                                    Routes.DETAIL_PAGE,
                                    arguments: topRated[index]
                                  );
                                },
                                child: VxContinuousRectangle(
                                  backgroundColor: secondaryBlue,
                                  radius: Dimensions.radius10,
                                  width: 115,
                                  child: VStack(
                                    [
                                      Container(
                                        height: 175,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(Dimensions.radius5),
                                            topLeft: Radius.circular(Dimensions.radius5),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage('http://image.tmdb.org/t/p/w500${topRated[index]["poster_path"]}'),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ),
                                      VStack(
                                        [
                                          const SizedBox(height: 10,),
                                          Text('${topRated[index]["title"]}').text.white.size(Dimensions.font14).overflow(TextOverflow.ellipsis).make(),
                                          const SizedBox(height: 10,),
                                          VStack(
                                            [
                                              Text('${DateFormat.y().format(DateTime.parse(topRated[index]["release_date"]))} Action').text.size(Dimensions.font8).white.make(),
                                              HStack(
                                                [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: Dimensions.font12,
                                                  ),
                                                  ' ${topRated[index]["vote_average"]} '.text.size(Dimensions.font8).white.make(),
                                                  '(${topRated[index]["vote_count"]})'.text.size(Dimensions.font8).white.make(),
                                                ]
                                              )
                                            ]
                                          )
                                        ],
                                        alignment: MainAxisAlignment.spaceBetween,
                                        crossAlignment: CrossAxisAlignment.start,
                                      ).px12(),
                                    ],
                                  ),
                                ).px4(),
                              );
                            }
                          );
                        })
                      ),
                    ).height(250).make(),
                  ],
                )
              ).make(),

              // === UPCOMING SECTION ====
              VxBox(
                child: VStack(
                  [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                      child: Row(
                        children: [
                          const Text('Upcoming').text.semiBold.white.size(Dimensions.font18).make(),
                          const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make(),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                    VxBox(
                      child: FutureBuilder(
                        future: controller.getUpcoming(),
                        builder: ((context, AsyncSnapshot snapshot){
                          if(snapshot.connectionState == ConnectionState.waiting){
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var upComing = snapshot.data!;

                          return ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: upComing.length - 15,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(
                                    Routes.DETAIL_PAGE,
                                    arguments: upComing[index]
                                  );
                                },
                                child: VxContinuousRectangle(
                                  backgroundColor: secondaryBlue,
                                  radius: Dimensions.radius10,
                                  width: 115,
                                  child: VStack(
                                    [
                                      Container(
                                        height: 175,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(Dimensions.radius5),
                                            topLeft: Radius.circular(Dimensions.radius5),
                                          ),
                                          image: DecorationImage(
                                            image: NetworkImage('http://image.tmdb.org/t/p/w500${upComing[index]["poster_path"]}'),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ),
                                      VStack(
                                        [
                                          const SizedBox(height: 10,),
                                          Text('${upComing[index]["title"]}').text.white.size(Dimensions.font14).overflow(TextOverflow.ellipsis).make(),
                                          const SizedBox(height: 10,),
                                          VStack(
                                            [
                                              Text('${DateFormat.y().format(DateTime.parse(upComing[index]["release_date"]))} Action').text.size(Dimensions.font8).white.make(),
                                              HStack(
                                                [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: Dimensions.font12,
                                                  ),
                                                  ' ${upComing[index]["vote_average"]} '.text.size(Dimensions.font8).white.make(),
                                                  '(${upComing[index]["vote_count"]})'.text.size(Dimensions.font8).white.make(),
                                                ]
                                              )
                                            ]
                                          )
                                        ],
                                        alignment: MainAxisAlignment.spaceBetween,
                                        crossAlignment: CrossAxisAlignment.start,
                                      ).px12(),
                                    ],
                                  ),
                                ).px4(),
                              );
                            }
                          );
                        })
                      ),
                    ).height(250).make(),
                    const SizedBox(height: 20,),
                  ],
                )
              ).make(),
            ]
          ),
        )
    );
  }
}
