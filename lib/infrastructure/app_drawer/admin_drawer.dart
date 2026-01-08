import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../infrastructure/routes/admin_routes.dart';
import '../../utils/constants/color_constants.dart';

class AdminDrawer extends StatefulWidget {
  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  String? hoveredRoute;

  @override
  Widget build(BuildContext context) {
    final currentRoute = Get.currentRoute;

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ==================== UPDATED HEADER ====================
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 90.w,
                    height: 90.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/images/EDUBLOOM.png'), // Logo path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            // ==================== MENU ITEMS ====================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDrawerItem("Dashboard", Icons.home, AdminRoutes.homescreen, currentRoute, Colors.blue),
                    _buildDrawerItem("Settings", Icons.settings, AdminRoutes.homescreen, currentRoute, Colors.pink),
                    _buildDrawerItem("Lead Manager", Icons.person, AdminRoutes.homescreen, currentRoute, Colors.brown),
                    _buildDrawerItem("Lead Report", Icons.check_circle, AdminRoutes.homescreen, currentRoute, Colors.orange),
                    _buildDrawerItem("Row Data", Icons.assignment, AdminRoutes.homescreen, currentRoute, Colors.cyan),
                    _buildDrawerItem("Communication", Icons.class_, AdminRoutes.homescreen, currentRoute, Colors.green),
                    _buildDrawerItem("SMS Reports", Icons.notifications, AdminRoutes.homescreen, currentRoute, Colors.indigo),
                    _buildDrawerItem("Students Data", Icons.group, AdminRoutes.homescreen, currentRoute, Colors.purple),
                    _buildDrawerItem("Marketing Materials", Icons.assessment, AdminRoutes.homescreen, currentRoute, Colors.teal),

                    SizedBox(height: 20.h),

                    // ==================== LOGOUT TEXT ====================
                    _buildDrawerItem("LOG OUT", Icons.logout, AdminRoutes.LOGIN, currentRoute, Colors.red, isLogout: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Drawer Item Widget for Logout with additional parameters for customization
  Widget _buildDrawerItem(String title, IconData icon, String route, String currentRoute, Color iconColor, {bool isLogout = false}) {
    bool isSelected = currentRoute == route;
    bool isLastItem = route == AdminRoutes.LOGIN; // Check if the item is the last one

    return Column(
      children: [
        ListTile(
          selected: isSelected,
          onTap: () => Get.toNamed(route),
          leading: Icon(
            icon,
            color: isLogout ? Colors.red : iconColor, // Red color for logout icon
          ),
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
              color: Colors.black, // Set text color to black for all items
            ),
          ),
        ),
        // Add a divider between items except for the last one
        if (!isLastItem) Divider(thickness: 1, color: Colors.grey.shade300),
        if (isSelected) SizedBox(height: 8.h), // Spacer when selected
      ],
    );
  }
}
