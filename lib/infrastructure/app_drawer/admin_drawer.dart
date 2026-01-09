import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../infrastructure/routes/admin_routes.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({super.key});

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  // ✅ ONE PLACE TO CONTROL SPACING
  final double itemVerticalPadding = 7.h; // gap inside item
  final double dividerVerticalGap = 0.h; // space above/below divider
  final double itemFontSize = 13.sp; // text size
  final double iconSize = 22.sp; // icon size

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==================== HEADER ====================
            Container(
              width: double.infinity,
              height: 150.h,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Container(
                  width: 90.w,
                  height: 90.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/EDUBLOOM.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // ==================== MENU ITEMS ====================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDrawerItem(
                      title: "Dashboard",
                      icon: Icons.home,
                      route: AdminRoutes.leadsstatus,
                      currentRoute: currentRoute,
                      iconColor: Colors.blue,
                    ),
                    _buildDrawerItem(
                      title: "Settings",
                      icon: Icons.settings,
                      route: AdminRoutes.studentdata,
                      currentRoute: currentRoute,
                      iconColor: Colors.pink,
                    ),
                    _buildDrawerItem(
                      title: "Lead Manager",
                      icon: Icons.person,
                      route: AdminRoutes.studentdata,
                      currentRoute: currentRoute,
                      iconColor: Colors.brown,
                    ),
                    _buildDrawerItem(
                      title: "Lead Report",
                      icon: Icons.check_circle,
                      route: AdminRoutes.studentdata,
                      currentRoute: currentRoute,
                      iconColor: Colors.orange,
                    ),
                    _buildDrawerItem(
                      title: "Row Data",
                      icon: Icons.assignment,
                      route: AdminRoutes.studentdata,
                      currentRoute: currentRoute,
                      iconColor: Colors.cyan,
                    ),
                    _buildDrawerItem(
                      title: "Communication",
                      icon: Icons.class_,
                      route: AdminRoutes.studentdata,
                      currentRoute: currentRoute,
                      iconColor: Colors.green,
                    ),
                    _buildDrawerItem(
                      title: "SMS Reports",
                      icon: Icons.notifications,
                      route: AdminRoutes.studentdata,
                      currentRoute: currentRoute,
                      iconColor: Colors.indigo,
                    ),
                    _buildDrawerItem(
                      title: "Students Data",
                      icon: Icons.group,
                      route: AdminRoutes.studentdata,
                      currentRoute: currentRoute,
                      iconColor: Colors.purple,
                    ),
                    _buildDrawerItem(
                      title: "Marketing Materials",
                      icon: Icons.assessment,
                      route: AdminRoutes.studentdata,
                      currentRoute: currentRoute,
                      iconColor: Colors.teal,
                    ),

                    SizedBox(height: 6.h),

                    // ==================== LOGOUT ====================
                    _buildDrawerItem(
                      title: "LOG OUT",
                      icon: Icons.logout,
                      route: AdminRoutes.LOGIN,
                      currentRoute: currentRoute,
                      iconColor: Colors.red,
                      textColor: Colors.white, // ✅ logout text white
                      tileColor: Colors.red, // ✅ optional: red background
                      isLogout: true,
                      isLastItem: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required String route,
    required String currentRoute,
    required Color iconColor,
    Color textColor = Colors.black,     // ✅ ADD
    Color? tileColor,                  // ✅ ADD (optional)
    bool isLogout = false,
    bool isLastItem = false,
  }) {
    final bool isSelected = currentRoute == route;

    return Column(
      children: [
        ListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -3),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: itemVerticalPadding,
          ),
          selected: isSelected,
          selectedTileColor: Colors.black.withOpacity(0.04),
          tileColor: tileColor, // ✅ APPLY optional background
          onTap: () {
            if (isLogout) {
              // ✅ Clear stack on logout
              Get.offAllNamed(route);
            } else {
              Get.toNamed(route);
            }
          },
          leading: Icon(
            icon,
            size: iconSize,
            color: isLogout ? Colors.white : iconColor, // ✅ if logout bg red, icon white
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: itemFontSize,
              fontWeight: FontWeight.w700,
              color: textColor, // ✅ APPLY textColor
            ),
          ),
        ),

        if (!isLastItem)
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: dividerVerticalGap,
            ),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade300,
            ),
          ),
      ],
    );
  }
}
