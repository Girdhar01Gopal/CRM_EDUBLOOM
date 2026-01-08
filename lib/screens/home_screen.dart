import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/home_controller.dart';
import '../infrastructure/app_drawer/admin_drawer.dart';
import '../infrastructure/routes/admin_routes.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeScreenController controller = Get.put(HomeScreenController());

  static const Color _navyDark = Color(0xFF0B1B3A);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,

      appBar: AppBar(
        title: Column(
          children: [
            Container(
              width: 40.w,
              height: 30.h,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/EDUBLOOM.png'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            Text(
              'SN Kids School',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.pie_chart_rounded),
            color: Colors.green,
            tooltip: "Leads Status",
            onPressed: () => Get.toNamed(AdminRoutes.leadsstatus),
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      drawer: AdminDrawer(),

      // ✅ Center FAB Home (fab type)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(() {
        final isSelected = controller.bottomIndex.value == 2;
        return FloatingActionButton(
          elevation: 2,
          backgroundColor: isSelected ? Colors.white : Colors.white,
          onPressed: () => controller.onBottomTap(2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Icon(
            Icons.home_rounded,
            color: _navyDark,
            size: 26.sp,
          ),
        );
      }),

      // ✅ BottomAppBar: 2 left + notch + 2 right (dark navy)
      bottomNavigationBar: Obx(() {
        return SafeArea(
          top: false,
          child: BottomAppBar(
            color: _navyDark,
            shape: const CircularNotchedRectangle(),
            notchMargin: 8,
            child: SizedBox(
              height: 64.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // LEFT 2
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _NavItem(
                          label: "Productivity\nReport",
                          icon: Icons.bar_chart_rounded,
                          selected: controller.bottomIndex.value == 0,
                          onTap: () => controller.onBottomTap(0),
                        ),
                        _NavItem(
                          label: "Follow Up\nTask",
                          icon: Icons.task_alt_rounded,
                          selected: controller.bottomIndex.value == 1,
                          onTap: () => controller.onBottomTap(1),
                        ),
                      ],
                    ),
                  ),

                  // GAP for FAB
                  SizedBox(width: 30.w),

                  // RIGHT 2
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _NavItem(
                          label: "Lead\nDisposition",
                          icon: Icons.rule_folder_rounded,
                          selected: controller.bottomIndex.value == 3,
                          onTap: () => controller.onBottomTap(3),
                        ),
                        _NavItem(
                          label: "Today's\nFollow Up",
                          icon: Icons.today_rounded,
                          selected: controller.bottomIndex.value == 4,
                          onTap: () => controller.onBottomTap(4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),

      // ✅ BODY (UPDATED): more scrollable + responsive, rest same
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final cards = controller.dashboardCards;

        return SafeArea(
          top: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              // ✅ Responsive grid rules
              final crossAxisCount = constraints.maxWidth < 380 ? 2 : 3;
              final aspect = constraints.maxWidth < 380 ? 1.55 : 1.35;

              return Padding(
                padding: EdgeInsets.all(14.w),
                child: GridView.builder(
                  // ✅ always scrollable + smooth
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    bottom: 90.h, // ✅ space for bottom bar + FAB
                  ),
                  itemCount: cards.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                    childAspectRatio: aspect,
                  ),
                  itemBuilder: (context, index) {
                    final item = cards[index];
                    return _DashboardCard(
                      title: item.title,
                      value: item.value.value,
                      icon: item.icon,
                    );
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        width: 74.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 22.sp,
              color: selected ? Colors.white : Colors.white70,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
                height: 1.1,
                color: selected ? Colors.white : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const _DashboardCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEF0),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: Colors.redAccent, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
