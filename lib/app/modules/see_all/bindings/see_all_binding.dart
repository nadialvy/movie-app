import 'package:get/get.dart';

import '../controllers/see_all_controller.dart';
import '../repository/see_all_repository.dart';

class SeeAllBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SeeAllRepository());
    Get.lazyPut<SeeAllController>(
      () => SeeAllController(seeAllRepository: Get.find<SeeAllRepository>()),
    );
  }
}
