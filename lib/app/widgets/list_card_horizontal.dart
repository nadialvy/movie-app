import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/app/constant/colors.dart';
import 'package:movie_app/app/constant/dimension.dart';
import 'package:movie_app/app/models/list_movie_model.dart';
import 'package:movie_app/app/routes/app_pages.dart';
import 'package:velocity_x/velocity_x.dart';

class ListCardHorizontal extends StatelessWidget{
  final RxList<Results> listMovie;

  const ListCardHorizontal({required this.listMovie});

  @override 
  Widget build(BuildContext context) {
    return
        VxBox(
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
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
                            image: NetworkImage('http://image.tmdb.org/t/p/w500${listMovie[index].posterPath}'),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                      VStack(
                        [
                          const SizedBox(height: 10,),
                          Text('${listMovie[index].title}',).text.white.size(Dimensions.font14).overflow(TextOverflow.ellipsis).make(),
                          const SizedBox(height: 10,),
                          VStack(
                            [
                              Text('${DateFormat.y().format(DateTime.parse(listMovie[index].releaseDate.toString()))} Action').text.light.size(Dimensions.font8).white.make(),
                              SizedBox(height: Dimensions.height5,),
                              HStack(
                                [
                                  Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: Dimensions.font12,
                                  ),
                                  ' ${listMovie[index].voteAverage} '.text.light.size(Dimensions.font8).white.make(),
                                  '(${listMovie[index].voteCount})'.text.light.size(Dimensions.font8).white.make(),
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
          ),
        ).height(250).make();
  }

}