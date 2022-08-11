import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constant/dimension.dart';
import '../models/list_movie_model.dart';
import '../routes/app_pages.dart';

class Carousel extends StatelessWidget {
  final RxList<Results> listMovie;
  Carousel({required this.listMovie});

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
      itemCount: listMovie.length - 15,
      itemBuilder: (context, index){
        return InkWell(
          onTap: (){
            Get.toNamed(
              Routes.DETAIL_PAGE,
              arguments: listMovie[index]
            );
          },
          child: VxContinuousRectangle(
            backgroundColor: Colors.black,
            radius: 10,
            backgroundImage: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: NetworkImage('http://image.tmdb.org/t/p/w500${listMovie[index].posterPath}'),
              fit: BoxFit.cover,
            ), 
            child: VStack(
              [
                VxContinuousRectangle(
                  width: 250,
                  height: 125,
                  radius: 20,
                  backgroundImage: DecorationImage(
                    image: NetworkImage('http://image.tmdb.org/t/p/w500${listMovie[index].posterPath}'),
                    fit: BoxFit.cover
                  ),  
                ),
                '${listMovie[index].title}'.text.white.bold.size(Dimensions.font18).make(),
                HStack(
                  [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: Dimensions.font12,
                    ),
                    ' ${listMovie[index].voteAverage} '.text.size(Dimensions.font14).white.make(),
                    '(${listMovie[index].voteCount})'.text.size(Dimensions.font14).white.make(),
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
  }
}