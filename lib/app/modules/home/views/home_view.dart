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
          child: controller.obx((data) => 
            VStack(
              [
                controller.obx(
                  (data) => VStack(
                    [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                        child: Row(
                          children: [
                            const Text('Now Playing').text.semiBold.white.size(Dimensions.font18).make(),
                            InkWell(
                              onTap: (){
                                // print(controller.listNowPlaying.runtimeType);
                                Get.toNamed(
                                  Routes.SEE_ALL,
                                  arguments: [
                                    {"title" : "Now Playing"},
                                    controller.listNowPlaying, //rxlist results
                                  ]
                                );
                              },
                              child: const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make()
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                      VxSwiper.builder(
                        itemCount: controller.listNowPlaying.length - 15,
                        itemBuilder: (context, index){
                          return InkWell(
                            onTap: (){
                              Get.toNamed(
                                Routes.DETAIL_PAGE,
                                arguments: controller.listNowPlaying[index]
                              );
                            },
                            child: VxContinuousRectangle(
                              backgroundColor: Colors.black,
                              radius: 10,
                              backgroundImage: DecorationImage(
                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
                                image: NetworkImage('http://image.tmdb.org/t/p/w500${controller.listNowPlaying[index].posterPath}'),
                                fit: BoxFit.cover,
                              ), 
                              child: VStack(
                                [
                                  VxContinuousRectangle(
                                    width: 250,
                                    height: 125,
                                    radius: 20,
                                    backgroundImage: DecorationImage(
                                      image: NetworkImage('http://image.tmdb.org/t/p/w500${controller.listNowPlaying[index].posterPath}'),
                                      fit: BoxFit.cover
                                    ),  
                                  ),
                                  '${controller.listNowPlaying[index].title}'.text.white.bold.size(Dimensions.font18).make(),
                                  HStack(
                                    [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: Dimensions.font12,
                                      ),
                                      ' ${controller.listNowPlaying[index].voteAverage} '.text.size(Dimensions.font14).white.make(),
                                      '(${controller.listNowPlaying[index].voteCount})'.text.size(Dimensions.font14).white.make(),
                                    ]
                                  )
                                ],
                                crossAlignment: CrossAxisAlignment.center,
                                alignment: MainAxisAlignment.spaceAround,
                              ),
                            ).p4(),
                          );
                        }
                      )
                    ]
                  ),
                  onEmpty: VxBox(
                    child: Image.asset(
                      'assets/images/nodata.jpg',
                      fit: BoxFit.cover,
                    )
                  ).color(Colors.white).width(Get.width).height(250).make(),
                  onLoading: const Center(child: CircularProgressIndicator())
                ),
                
                // === POPULAR SECTION ====
                controller.obx(
                  (data) => VStack(
                    [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Row(
                          children: [
                            const Text('Popular').text.white.semiBold.size(Dimensions.font18).make(),
                            InkWell(
                              onTap: (){
                                Get.toNamed(
                                  Routes.SEE_ALL,
                                  arguments: [
                                    {"title" : "Popular"},
                                    controller.listPopular,
                                  ]
                                );
                              },
                              child: const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make()
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                      VxBox(
                        child:
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.listPopular.length - 15,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(
                                    Routes.DETAIL_PAGE,
                                    arguments: controller.listPopular[index]
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
                                            image: NetworkImage('http://image.tmdb.org/t/p/w500${controller.listPopular[index].posterPath}'),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ),
                                      VStack(
                                        [
                                          const SizedBox(height: 10,),
                                          Text('${controller.listPopular[index].title}',).text.white.size(Dimensions.font14).overflow(TextOverflow.ellipsis).make(),
                                          const SizedBox(height: 10,),
                                          VStack(
                                            [
                                              Text('${DateFormat.y().format(DateTime.parse(controller.listPopular[index].releaseDate.toString()))} Action').text.light.size(Dimensions.font8).white.make(),
                                              SizedBox(height: Dimensions.height5,),
                                              HStack(
                                                [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: Dimensions.font12,
                                                  ),
                                                  ' ${controller.listPopular[index].voteAverage} '.text.light.size(Dimensions.font8).white.make(),
                                                  '(${controller.listPopular[index].voteCount})'.text.light.size(Dimensions.font8).white.make(),
                                                ]
                                              )
                                            ]
                                          )
                                        ],
                                        alignment: MainAxisAlignment.spaceBetween,
                                        crossAlignment: CrossAxisAlignment.start,
                                      ).px8(),
                                    ],
                                  ),
                                ).px4(),
                              );
                            }
                          )
                      ).height(250).make(),
                    ]
                  ),
                  onEmpty: VxBox(
                    child: Image.asset(
                      'assets/images/nodata.jpg',
                      fit: BoxFit.cover,
                    )
                  ).color(Colors.white).width(Get.width).height(250).make(),
                  onLoading: const Center(child: CircularProgressIndicator())
                ),

                // === TOP RATED SECTION ====
                controller.obx(
                  (data) => VStack(
                    [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Row(
                          children: [
                            const Text('Top Rated').text.white.semiBold.size(Dimensions.font18).make(),
                            InkWell(
                              onTap: (){
                                Get.toNamed(
                                  Routes.SEE_ALL,
                                  arguments: [
                                    {"title" : "Popular"},
                                    controller.listTopRated,
                                  ]
                                );
                              },
                              child: const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make()
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                      VxBox(
                        child:
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.listTopRated.length - 15,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(
                                    Routes.DETAIL_PAGE,
                                    arguments: controller.listTopRated[index]
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
                                            image: NetworkImage('http://image.tmdb.org/t/p/w500${controller.listTopRated[index].posterPath}'),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ),
                                      VStack(
                                        [
                                          const SizedBox(height: 10,),
                                          Text('${controller.listTopRated[index].title}',).text.white.size(Dimensions.font14).overflow(TextOverflow.ellipsis).make(),
                                          const SizedBox(height: 10,),
                                          VStack(
                                            [
                                              Text('${DateFormat.y().format(DateTime.parse(controller.listTopRated[index].releaseDate.toString()))} Action').text.light.size(Dimensions.font8).white.make(),
                                              SizedBox(height: Dimensions.height5,),
                                              HStack(
                                                [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: Dimensions.font12,
                                                  ),
                                                  ' ${controller.listTopRated[index].voteAverage} '.text.light.size(Dimensions.font8).white.make(),
                                                  '(${controller.listTopRated[index].voteCount})'.text.light.size(Dimensions.font8).white.make(),
                                                ]
                                              )
                                            ]
                                          )
                                        ],
                                        alignment: MainAxisAlignment.spaceBetween,
                                        crossAlignment: CrossAxisAlignment.start,
                                      ).px8(),
                                    ],
                                  ),
                                ).px4(),
                              );
                            }
                          )
                      ).height(250).make(),
                    ]
                  ),
                  onEmpty: VxBox(
                    child: Image.asset(
                      'assets/images/nodata.jpg',
                      fit: BoxFit.cover,
                    )
                  ).color(Colors.white).width(Get.width).height(250).make(),
                  onLoading: const Center(child: CircularProgressIndicator())
                ),

                // === UPCOMING SECTION ====
                controller.obx(
                  (data) => VStack(
                    [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Row(
                          children: [
                            const Text('Upcoming').text.white.semiBold.size(Dimensions.font18).make(),
                            InkWell(
                              onTap: (){
                                Get.toNamed(
                                  Routes.SEE_ALL,
                                  arguments: [
                                    {"title" : "Popular"},
                                    controller.listUpcoming,
                                  ]
                                );
                              },
                              child: const Text('SEE ALL').text.color(tosca).size(Dimensions.font12).make()
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                      VxBox(
                        child:
                          ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.listUpcoming.length - 15,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  Get.toNamed(
                                    Routes.DETAIL_PAGE,
                                    arguments: controller.listUpcoming[index]
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
                                            image: NetworkImage('http://image.tmdb.org/t/p/w500${controller.listUpcoming[index].posterPath}'),
                                            fit: BoxFit.cover
                                          )
                                        ),
                                      ),
                                      VStack(
                                        [
                                          const SizedBox(height: 10,),
                                          Text('${controller.listUpcoming[index].title}',).text.white.size(Dimensions.font14).overflow(TextOverflow.ellipsis).make(),
                                          const SizedBox(height: 10,),
                                          VStack(
                                            [
                                              Text('${DateFormat.y().format(DateTime.parse(controller.listUpcoming[index].releaseDate.toString()))} Action').text.light.size(Dimensions.font8).white.make(),
                                              SizedBox(height: Dimensions.height5,),
                                              HStack(
                                                [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: Dimensions.font12,
                                                  ),
                                                  ' ${controller.listUpcoming[index].voteAverage} '.text.light.size(Dimensions.font8).white.make(),
                                                  '(${controller.listUpcoming[index].voteCount})'.text.light.size(Dimensions.font8).white.make(),
                                                ]
                                              )
                                            ]
                                          )
                                        ],
                                        alignment: MainAxisAlignment.spaceBetween,
                                        crossAlignment: CrossAxisAlignment.start,
                                      ).px8(),
                                    ],
                                  ),
                                ).px4(),
                              );
                            }
                          )
                      ).height(250).make(),
                    ]
                  ),
                  onEmpty: VxBox(
                    child: Image.asset(
                      'assets/images/nodata.jpg',
                      fit: BoxFit.cover,
                    )
                  ).color(Colors.white).width(Get.width).height(250).make(),
                  onLoading: const Center(child: CircularProgressIndicator())
                ),

                SizedBox(height: Dimensions.height20,),
              ]
            ),onLoading: const Center(child: CircularProgressIndicator())
          ),
          
        )
    );
  }
}
