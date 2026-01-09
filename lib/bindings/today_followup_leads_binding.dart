import 'package:get/get.dart';
import '../controllers/today_followup_leads_controller.dart';

class TodayFollowUpLeadsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TodayFollowUpLeadsController>(() => TodayFollowUpLeadsController());
  }
}
