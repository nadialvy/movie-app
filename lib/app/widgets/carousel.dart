import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/app/modules/home/controllers/home_controller.dart';
import 'package:velocity_x/velocity_x.dart';
import '../constant/dimension.dart';
import '../models/list_movie_model.dart';
import '../routes/app_pages.dart';

class Carousel extends StatelessWidget {
  final RxList<Results> listMovie;
  Carousel({required this.listMovie});

  var homeC = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return VxSwiper.builder(
      height: Get.height * 0.35,
      itemCount: listMovie.length - Dimensions.totalCardHorizontal,
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
            radius: Dimensions.radius10,
            backgroundImage: DecorationImage(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop),
              image: NetworkImage('http://image.tmdb.org/t/p/w500${listMovie[index].backdropPath}'),
              fit: BoxFit.cover,
            ),
            child: VStack(
              [
                VxContinuousRectangle(
                  width: Dimensions.width250,
                  height: Dimensions.height125,
                  radius: Dimensions.radius20,
                  backgroundImage: DecorationImage(
                    image: NetworkImage('http://image.tmdb.org/t/p/w500${listMovie[index].posterPath}'),
                    fit: BoxFit.cover
                  ),  
                ),
                SizedBox(height: Dimensions.height5,),
                '${listMovie[index].title}'.text.white.bold.size(Dimensions.font16).make(),
                (listMovie[index].genreIds == null ? " " : homeC.getGenreNameById(listMovie[index].genreIds!).join(", ")).text.white.light.size(Dimensions.font12).make(),
                HStack(
                  [
                    Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: Dimensions.font12,
                    ),
                    ' ${listMovie[index].voteAverage} '.text.light.size(Dimensions.font12).white.make(),
                    '(${listMovie[index].voteCount})'.text.light.size(Dimensions.font12).white.make(),
                  ]
                )
              ],
              crossAlignment: CrossAxisAlignment.center,
              alignment: MainAxisAlignment.spaceAround,
            ).p12(),
          ).p4(),
        );
      }
    );
  }
}