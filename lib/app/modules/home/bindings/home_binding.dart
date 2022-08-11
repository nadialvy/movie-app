import 'package:get/get.dart';
import 'package:movie_app/app/modules/home/repository/homeProvider.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeProvider());
    Get.lazyPut(() => HomeController(homeProvider: Get.find()));
  }
}
