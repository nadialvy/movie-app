import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constant/colors.dart';
import '../constant/dimension.dart';
import '../models/list_movie_model.dart';
import '../routes/app_pages.dart';

class ListAllMovies extends StatelessWidget {
  const ListAllMovies({
    Key? key,
    required this.title,
    required this.listMovie,
  }) : super(key: key);

  final Map<String, dynamic> title;
  final RxList<Results> listMovie;

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
                  Expanded(
                    child: HStack(
                      [
                        VxContinuousRectangle(
                          backgroundColor: mainBlue,
                          radius: Dimensions.radius10,
                          width: Dimensions.width75,
                          height: Dimensions.height125,
                          backgroundImage: DecorationImage(
                            image: NetworkImage('http://image.tmdb.org/t/p/w500${listMovie[index].posterPath}'),
                            fit: BoxFit.cover
                          ),
                        ),
                        SizedBox(width: Dimensions.width10,),
                        Expanded(
                          child: VStack(
                              [
                                Text(
                                '${listMovie[index].title}',
                                ).text.overflow(TextOverflow.visible).semiBold.white.size(Dimensions.font16).make(),
                              SizedBox(height: Dimensions.height5,),
                              Text('${listMovie[index].releaseDate}').text.size(Dimensions.font12).color(tosca).make(),
                              SizedBox(height: Dimensions.height5,),
                              Text('Action, Adventure, Fantasy').text.light.size(Dimensions.font12).white.make(),
                              HStack(
                                [
                                  VxRating(
                                    maxRating: 5.0,
                                    value: listMovie[index].voteAverage! / 2,
                                    count: 5,
                                    selectionColor: Colors.yellow,
                                    normalColor: Colors.grey,
                                    size: Dimensions.font14,
                                    onRatingUpdate: (String val) {},
                                  ),
                                  Text(' ${listMovie[index].voteAverage} (${listMovie[index].voteCount})').text.light.size(Dimensions.font12).white.make()
                                ]
                              )
                            ],
                          ),
                        ),
                      ],
                      crossAlignment: CrossAxisAlignment.start,
                    ),
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
              
            ).padding(Vx.m20).margin(Vx.mV4).height(Dimensions.height150).width(Get.width).color(secondaryBlue).make(),
          );
        },
      )
    );
  }
}
