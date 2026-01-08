import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controllers/LeadsStatusController.dart';
import '../infrastructure/app_drawer/admin_drawer.dart';

class LeadsStatusScreen extends StatelessWidget {
  LeadsStatusScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final LeadsStatusController c = Get.put(LeadsStatusController());

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

      // ✅ SAME header/appbar (copy-paste from your HomeScreen)
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
        foregroundColor: Colors.white,

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

      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: EdgeInsets.all(14.w),
          child: Column(
            children: [
              _LeadsStatusCard(
                totalLeads: c.totalLeads.value,
                registered: c.registered.value,
                duplicate: c.duplicate.value,
                nextSession: c.nextSession.value,
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _LeadsStatusCard extends StatelessWidget {
  final int totalLeads;
  final int registered;
  final int duplicate;
  final int nextSession;

  const _LeadsStatusCard({
    required this.totalLeads,
    required this.registered,
    required this.duplicate,
    required this.nextSession,
  });

  @override
  Widget build(BuildContext context) {
    final sum = registered + duplicate + nextSession;
    final safeTotal = sum == 0 ? 1 : sum;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 14.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // ✅ Same web-like header (purple->pink)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              gradient: const LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFFE91E63)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.pie_chart_rounded, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  "Leads Status",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(14.w),
            child: Column(
              children: [
                // ✅ Legend row like web
                Wrap(
                  spacing: 12.w,
                  runSpacing: 8.h,
                  children: [
                    _LegendDot(label: "Total Leads", color: const Color(0xFFFFC107), value: totalLeads),
                    _LegendDot(label: "Registered", color: const Color(0xFF00BFA5), value: registered),
                    _LegendDot(label: "Duplicate", color: const Color(0xFF1E3A8A), value: duplicate),
                    _LegendDot(label: "Next Session", color: const Color(0xFFE53935), value: nextSession),
                  ],
                ),

                SizedBox(height: 16.h),

                SizedBox(
                  height: 220.h,
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 55.r,
                      sectionsSpace: 2,
                      startDegreeOffset: -90,
                      sections: [
                        PieChartSectionData(
                          value: registered.toDouble(),
                          color: const Color(0xFF00BFA5),
                          radius: 45.r,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: duplicate.toDouble(),
                          color: const Color(0xFF1E3A8A),
                          radius: 45.r,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: nextSession.toDouble(),
                          color: const Color(0xFFFF9800),
                          radius: 45.r,
                          showTitle: false,
                        ),
                        // optional: show total leads as ring portion (if you want)
                        PieChartSectionData(
                          value: (safeTotal - (registered + duplicate + nextSession)).toDouble().clamp(0, double.infinity),
                          color: const Color(0xFFFFC107),
                          radius: 45.r,
                          showTitle: false,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                // ✅ Center summary (optional)
                Text(
                  "Total: $safeTotal",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
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

class _LegendDot extends StatelessWidget {
  final String label;
  final Color color;
  final int value;

  const _LegendDot({
    required this.label,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
        SizedBox(width: 6.w),
        Text(
          "$label",
          style: TextStyle(fontSize: 11.sp, color: Colors.black87),
        ),
        SizedBox(width: 6.w),
        Text(
          "($value)",
          style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
