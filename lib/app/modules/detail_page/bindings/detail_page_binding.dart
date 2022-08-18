import 'package:get/get.dart';
import 'package:movie_app/app/modules/detail_page/reporitory/detail_page_repository.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailPageRepository());
    Get.lazyPut(() => DetailPageController(detailPageRepository: Get.find<DetailPageRepository>()));
  }
}
