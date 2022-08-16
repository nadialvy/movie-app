import 'package:get/get.dart';
import 'package:movie_app/app/modules/home/repository/home_repository.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeRepository());
    Get.lazyPut(() => HomeController(homeRepository: Get.find<HomeRepository>()));
  }
}
