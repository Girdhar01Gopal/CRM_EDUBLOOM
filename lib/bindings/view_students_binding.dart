import 'package:get/get.dart';
import '../controllers/view_students_controller.dart';

class ViewStudentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewStudentsController>(() => ViewStudentsController());
  }
}
