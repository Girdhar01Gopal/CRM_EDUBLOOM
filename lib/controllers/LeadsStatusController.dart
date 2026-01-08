import 'package:get/get.dart';

class LeadsStatusController extends GetxController {
  final isLoading = false.obs;

  // ✅ Values (bind these with API later)
  final totalLeads = 0.obs;
  final registered = 0.obs;
  final duplicate = 0.obs;
  final nextSession = 0.obs;

  int get totalForChart {
    // donut total = sum of statuses (or use totalLeads if your logic wants)
    final sum = registered.value + duplicate.value + nextSession.value;
    return sum == 0 ? 1 : sum; // avoid 0 division
  }

  @override
  void onInit() {
    super.onInit();
    fetchLeadsStatus();
  }

  Future<void> fetchLeadsStatus() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 200));

    // ✅ demo (replace from API)
    totalLeads.value = 2;
    registered.value = 0;
    duplicate.value = 0;
    nextSession.value = 2;

    isLoading.value = false;
  }
}
