import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:movie_app/app/models/list_movie_model.dart';
import 'package:movie_app/app/modules/detail_page/controllers/detail_page_controller.dart';
import 'package:movie_app/app/modules/home/controllers/home_controller.dart';
import 'package:movie_app/app/routes/app_pages.dart';
import 'package:movie_app/app/widgets/on_empty.dart';
import 'package:velocity_x/velocity_x.dart';

class ListCardHorizontal extends StatelessWidget{

  final RxList<Results> listMovie;
  ListCardHorizontal({Key? key, required this.listMovie}) : super(key: key);
  
  var homeC = Get.find<HomeController>();

  @override 
  Widget build(BuildContext context) {
    if(listMovie.isNotEmpty){
      return VxBox(
        child: ListView.builder(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: listMovie.isEmpty ? 0 : listMovie.length,
          itemBuilder: (context, index){
              return InkWell(
                  onTap: (){
                    Get.toNamed(
                      Routes.DETAIL_PAGE,
                      arguments: listMovie[index].id
                    );
                  },
                  child: VxContinuousRectangle(
                    backgroundColor: secondaryBlue,
                    radius: Dimensions.radius10,
                    width: Dimensions.width115,
                    child: VStack(
                      [
                        Container(
                          height: Dimensions.height175,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(Dimensions.radius5),
                              topLeft: Radius.circular(Dimensions.radius5),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('http://image.tmdb.org/t/p/w500${listMovie[index].posterPath}'),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                        Expanded(
                          child: VStack(
                            [
                              SizedBox(height: Dimensions.height10,),
                              Text(
                                '${listMovie[index].title}'
                              ).text.white.size(Dimensions.font14).overflow(TextOverflow.ellipsis).make(),
                              SizedBox(height: Dimensions.height10,),
                              Expanded(
                                child: VStack(
                                  [
                                    Text(
                                      '${DateFormat.y().format(DateTime.parse(listMovie[index].releaseDate.toString()))} ${listMovie[index].genreIds!.isEmpty ? " " : homeC.getGenreNameById(listMovie[index].genreIds!).first}',
                                    ).text.light.size(Dimensions.font8).white.make(),
                                    SizedBox(height: Dimensions.height5,),
                                    Expanded(
                                      child: HStack(
                                        [
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                            size: Dimensions.font12,
                                          ),
                                          ' ${listMovie[index].voteAverage} '.text.light.size(Dimensions.font8).white.make(),
                                          '(${listMovie[index].voteCount})'.text.light.size(Dimensions.font8).white.make(),
                                        ]
                                      ),
                                    )
                                  ]
                                ).pOnly(bottom: Dimensions.height5),
                              )
                            ],
                            alignment: MainAxisAlignment.spaceBetween,
                            crossAlignment: CrossAxisAlignment.start,
                          ).px8(),
                        ),
                      ],
                    ),
                  ).px4(),
                );

            }
          
        ),
      ).height(Dimensions.height250).make();

    }else {
      return const OnEmpty();
    }

  }

}