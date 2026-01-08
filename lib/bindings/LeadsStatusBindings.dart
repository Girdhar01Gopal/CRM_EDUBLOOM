import 'package:get/get.dart';
import '../controllers/LeadsStatusController.dart';

class LeadsStatusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadsStatusController>(() => LeadsStatusController());
  }
}
