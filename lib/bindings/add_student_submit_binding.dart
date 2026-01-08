import 'package:get/get.dart';
import '../controllers/add_student_submit_controller.dart';

class AddStudentSubmitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddStudentSubmitController>(() => AddStudentSubmitController());
  }
}
