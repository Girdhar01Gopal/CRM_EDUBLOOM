import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../infrastructure/routes/admin_routes.dart';

class HomeScreenController extends GetxController {
  final isLoading = false.obs;

  final bottomIndex = 2.obs; // start from Home

  void onBottomTap(int index) {
    bottomIndex.value = index;

    switch (index) {
    // case 0: Get.toNamed(AdminRoutes.productivityReport); break;
    // case 1: Get.toNamed(AdminRoutes.followUpTask); break;
    // case 2: break;
    // case 3: Get.toNamed(AdminRoutes.leadDisposition); break;
      case 4:
        Get.toNamed(AdminRoutes.todayfollowupleads);
        break;
      default:
        break;
    }
  }

  // Dashboard values
  final todayfollowup = 0.obs;
  final totalLeads = 0.obs;
  final todaysLeads = 0.obs;
  final hotLeads = 0.obs;
  final todaysCompletedCalls = 0.obs;
  final contacted = 0.obs;
  final registered = 0.obs;
  final pending = 0.obs;
  final totalClass = 0.obs;
  final totalCounsellor = 0.obs;

  // Dashboard cards
  late final List<DashboardCardItem> dashboardCards = [
    DashboardCardItem(
      title: "Today Follow up",
      value: todayfollowup,
      icon: Icons.today,
      route: AdminRoutes.todayfollowupleads, // ✅ only this route given by you
    ),
    DashboardCardItem(title: "Total Leads", value: totalLeads, icon: Icons.groups,
      route: AdminRoutes.todayfollowupleads,),
    DashboardCardItem(title: "Today's Leads", value: todaysLeads, icon: Icons.today,
      route: AdminRoutes.todayfollowupleads,),
    DashboardCardItem(title: "Hot Leads", value: hotLeads, icon: Icons.local_fire_department,
      route: AdminRoutes.todayfollowupleads,),
    DashboardCardItem(title: "Today's Completed Calls", value: todaysCompletedCalls, icon: Icons.call,
      route: AdminRoutes.todayfollowupleads,),
    DashboardCardItem(title: "Contacted", value: contacted, icon: Icons.support_agent,
      route: AdminRoutes.todayfollowupleads,),
    DashboardCardItem(title: "Registered", value: registered, icon: Icons.how_to_reg,
      route: AdminRoutes.todayfollowupleads,),
    DashboardCardItem(title: "Pending", value: pending, icon: Icons.pending_actions,
      route: AdminRoutes.todayfollowupleads,),
    DashboardCardItem(title: "Total Class", value: totalClass, icon: Icons.class_,
      route: AdminRoutes.todayfollowupleads,),
    DashboardCardItem(title: "Total Counsellor", value: totalCounsellor, icon: Icons.person_pin,
      route: AdminRoutes.todayfollowupleads,),
  ];

  // ✅ tap handler
  void onCardTap(DashboardCardItem item) {
    if (item.route != null && item.route!.isNotEmpty) {
      Get.toNamed(item.route!);
    } else {
      Get.snackbar("Info", "${item.title} - Coming soon");
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    isLoading.value = true;

    await Future.delayed(const Duration(milliseconds: 700));

    todayfollowup.value = 0;
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
  final String? route;

  DashboardCardItem({
    required this.title,
    required this.value,
    required this.icon,
    this.route,
  });
}
