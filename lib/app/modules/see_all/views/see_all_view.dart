import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../constant/colors.dart';
import '../../../constant/dimension.dart';
import '../../../models/list_movie_model.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/see_all_controller.dart';

class SeeAllView extends GetView<SeeAllController> {
  var homeC = Get.find<HomeController>();

  List<dynamic> dataArguments = Get.arguments;
  late Map<String, dynamic> title = dataArguments[0];
  late RxList<Results> listMovie = dataArguments[1];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: mainBlue,
      appBar: AppBar(
        title: Text("${title['title']}"),
        leading: IconButton(
          onPressed: (){
            Get.back();
            controller.refreshList();
          },
          icon: const Icon(Icons.arrow_back)
        ),
        backgroundColor: mainBlue,
        elevation: 0,
      ),
      body: Obx(
        () => ListView.builder(
          controller: controller.scrollController,
          itemCount: listMovie.length,
          itemBuilder: (context, index){
              if(index == listMovie.length && controller.isMoreDataAvailable.value == true){
                return Padding(
                  padding: EdgeInsets.all(Dimensions.height10),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              return InkWell(
                onTap: (){
                  Get.toNamed(
                    Routes.DETAIL_PAGE,
                    arguments: listMovie[index].id
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
                                image: NetworkImage(listMovie[index].posterPath != null ? 'http://image.tmdb.org/t/p/w500${listMovie[index].posterPath}' : 'https://dummyimage.com/75x125/000/0011ff&text=no+data'),
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
                                  homeC.getGenreNameById(listMovie[index].genreIds!).join(", ").text.light.size(Dimensions.font12).white.make(),
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
            }
        
      ),
        ),
    );
  }
}

