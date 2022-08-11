import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:movie_app/app/routes/app_pages.dart';
import 'package:velocity_x/velocity_x.dart';

import '../controllers/see_all_controller.dart';

class SeeAllView extends GetView<SeeAllController> {
  List<dynamic> dataArguments = Get.arguments;

  late Map<String, dynamic> title = dataArguments[0];
  late List<dynamic> listMovie = dataArguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text("${title['title']}"),
        backgroundColor: mainBlue,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: listMovie.length,
        itemBuilder: (context, index){
          return InkWell(
            onTap: (){
              Get.toNamed(
                Routes.DETAIL_PAGE,
                arguments: listMovie[index]
              );
            },
            child: VxBox(
              child: HStack(
                [
                  HStack(
                    [
                      VxContinuousRectangle(
                        backgroundColor: mainBlue,
                        radius: 10,
                        width: 75,
                        height: 125,
                        backgroundImage: DecorationImage(
                          image: NetworkImage('http://image.tmdb.org/t/p/w500${listMovie[index]["poster_path"]}'),
                          fit: BoxFit.cover
                        ),
                      ),
                      SizedBox(width: Dimensions.width10,),
                      VStack(
                          [
                            Flexible(
                              child: Text(
                              '${listMovie[index]["title"]}',
                              ).text.semiBold.white.size(Dimensions.font18).make(),
                            ),
                          SizedBox(height: Dimensions.height5,),
                          Text('${listMovie[index]["release_date"]}').text.size(Dimensions.font12).color(tosca).make(),
                          SizedBox(height: Dimensions.height5,),
                          Text('Action, Adventure, Fantasy').text.light.size(Dimensions.font12).white.make(),
                          HStack(
                            [
                              VxRating(
                                onRatingUpdate: (value) {},
                                count: 5,
                                selectionColor: Colors.yellow,
                                size: Dimensions.font12,
                              ),
                              Text(' ${listMovie[index]["vote_average"]} (${listMovie[index]["vote_count"]})').text.light.size(Dimensions.font12).white.make()
                            ]
                          )
                        ],
                      ),
                    ],
                    crossAlignment: CrossAxisAlignment.start,
                  ),
                  Icon(
                    Icons.bookmark_border,
                    size: Dimensions.font22,
                    color: tosca,
                  )
                ],
                alignment: MainAxisAlignment.spaceBetween,
                crossAlignment: CrossAxisAlignment.start,
              ),
              
            ).padding(Vx.m20).margin(Vx.mV4).height(150).width(Get.width).color(secondaryBlue).make(),
          );
        },
      )
    );
  }
}
