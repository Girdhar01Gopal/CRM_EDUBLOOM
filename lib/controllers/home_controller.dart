import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final isLoading = false.obs;

  // ✅ 0: Productivity Report
  // ✅ 1: Follow Up Task
  // ✅ 2: Home (FAB)
  // ✅ 3: Lead Disposition
  // ✅ 4: Today's Follow Up
  final bottomIndex = 2.obs; // start from Home

  void onBottomTap(int index) {
    bottomIndex.value = index;

    // Routing later if you want (optional)
    // switch (index) {
    //   case 0: Get.toNamed(AdminRoutes.productivityReport); break;
    //   case 1: Get.toNamed(AdminRoutes.followUpTask); break;
    //   case 2: break;
    //   case 3: Get.toNamed(AdminRoutes.leadDisposition); break;
    //   case 4: Get.toNamed(AdminRoutes.todaysFollowUp); break;
    // }
  }

  // 9 dashboard values
  final totalLeads = 0.obs;
  final todaysLeads = 0.obs;
  final hotLeads = 0.obs;
  final todaysCompletedCalls = 0.obs;
  final contacted = 0.obs;
  final registered = 0.obs;
  final pending = 0.obs;
  final totalClass = 0.obs;
  final totalCounsellor = 0.obs;

  late final List<DashboardCardItem> dashboardCards = [
    DashboardCardItem(title: "Total Leads", value: totalLeads, icon: Icons.groups),
    DashboardCardItem(title: "Today's Leads", value: todaysLeads, icon: Icons.today),
    DashboardCardItem(title: "Hot Leads", value: hotLeads, icon: Icons.local_fire_department),
    DashboardCardItem(title: "Today's Completed Calls", value: todaysCompletedCalls, icon: Icons.call),
    DashboardCardItem(title: "Contacted", value: contacted, icon: Icons.support_agent),
    DashboardCardItem(title: "Registered", value: registered, icon: Icons.how_to_reg),
    DashboardCardItem(title: "Pending", value: pending, icon: Icons.pending_actions),
    DashboardCardItem(title: "Total Class", value: totalClass, icon: Icons.class_),
    DashboardCardItem(title: "Total Counsellor", value: totalCounsellor, icon: Icons.person_pin),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 700));

    totalLeads.value = 2;
    todaysLeads.value = 0;
    hotLeads.value = 1;
    todaysCompletedCalls.value = 0;
    contacted.value = 1;
    registered.value = 0;
    pending.value = 0;
    totalClass.value = 1;
    totalCounsellor.value = 2;

    isLoading.value = false;
  }
}

class DashboardCardItem {
  final String title;
  final RxInt value;
  final IconData icon;

  DashboardCardItem({
    required this.title,
    required this.value,
    required this.icon,
  });
}
