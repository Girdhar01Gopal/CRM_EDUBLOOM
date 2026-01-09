import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/today_followup_leads_controller.dart';

class TodayFollowUpLeadsScreen extends GetView<TodayFollowUpLeadsController> {
  const TodayFollowUpLeadsScreen({super.key});

  static const double _tableWidth = 1100;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),

      // ✅ NEW APPBAR as you asked
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white), // back arrow white
        title: Text(
          "Today's Follow Up",
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Removed dashboard/breadcrumb + tabs as you said "remove other things"

            // Table card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                    color: Colors.black.withOpacity(0.06),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // ✅ FIXED: controls row is now responsive (no overflow)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isNarrow = constraints.maxWidth < 520;

                      return Wrap(
                        spacing: 12.w,
                        runSpacing: 10.h,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          // Left: Show entries
                          Wrap(
                            spacing: 10.w,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text("Show", style: TextStyle(fontSize: 12.sp)),
                              Obx(() {
                                return DropdownButton<int>(
                                  value: controller.entriesPerPage.value,
                                  underline: const SizedBox.shrink(),
                                  items: const [10, 25, 50, 100]
                                      .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text("$e"),
                                  ))
                                      .toList(),
                                  onChanged: (v) {
                                    if (v != null) controller.changeEntries(v);
                                  },
                                );
                              }),
                              Text("entries", style: TextStyle(fontSize: 12.sp)),
                            ],
                          ),

                          // Right: Search
                          Wrap(
                            spacing: 10.w,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text("Search:", style: TextStyle(fontSize: 12.sp)),
                              SizedBox(
                                width: isNarrow ? constraints.maxWidth : 220.w,
                                height: 36.h,
                                child: TextField(
                                  controller: controller.searchController,
                                  onChanged: controller.onSearchChanged,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10.w,
                                      vertical: 10.h,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.r),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),

                  SizedBox(height: 12.h),

                  // table
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    final rows = controller.pagedLeads;

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                          width: _tableWidth,
                          child: Column(
                            children: [
                              // header
                              Container(
                                height: 44.h,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF5B2B82),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.r),
                                    topRight: Radius.circular(8.r),
                                  ),
                                ),
                                child: Row(
                                  children: const [
                                    _Th("S.No.", flex: 1),
                                    _Th("Name", flex: 2),
                                    _Th("Email", flex: 3),
                                    _Th("Mobile", flex: 2),
                                    _Th("Status", flex: 2),
                                    _Th("Related To", flex: 2),
                                    _Th("Follow-up Date", flex: 2),
                                    _Th("Last Activity Date", flex: 2),
                                  ],
                                ),
                              ),

                              // body
                              if (rows.isEmpty)
                                Container(
                                  height: 60.h,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "No data available in table",
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFF6B7280),
                                    ),
                                  ),
                                )
                              else
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: rows.length,
                                  separatorBuilder: (_, __) => const Divider(
                                    height: 1,
                                    color: Color(0xFFE5E7EB),
                                  ),
                                  itemBuilder: (_, index) {
                                    final r = rows[index];
                                    final sno = ((controller.page.value - 1) *
                                        controller.entriesPerPage.value) +
                                        index +
                                        1;

                                    return SizedBox(
                                      height: 44.h,
                                      child: Row(
                                        children: [
                                          _Td("$sno", flex: 1),
                                          _Td(r.name, flex: 2),
                                          _Td(r.email, flex: 3),
                                          _Td(r.mobile, flex: 2),
                                          _Td(r.status, flex: 2),
                                          _Td(r.relatedTo, flex: 2),
                                          _Td(r.followUpDate, flex: 2),
                                          _Td(r.lastActivityDate, flex: 2),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),

                  SizedBox(height: 10.h),

                  // footer
                  Obx(() {
                    return Wrap(
                      runSpacing: 10.h,
                      spacing: 10.w,
                      alignment: WrapAlignment.spaceBetween,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "Showing ${controller.showingFrom} to ${controller.showingTo} of ${controller.totalEntries} entries",
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _PagerButton(
                              text: "Previous",
                              enabled: controller.canGoPrev,
                              onTap: controller.prevPage,
                            ),
                            SizedBox(width: 8.w),
                            _PagerButton(
                              text: "Next",
                              enabled: controller.canGoNext,
                              onTap: controller.nextPage,
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Th extends StatelessWidget {
  final String text;
  final int flex;
  const _Th(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _Td extends StatelessWidget {
  final String text;
  final int flex;
  const _Td(this.text, {required this.flex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Text(
          text,
          style: TextStyle(fontSize: 12.sp, color: const Color(0xFF111827)),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _PagerButton extends StatelessWidget {
  final String text;
  final bool enabled;
  final VoidCallback onTap;

  const _PagerButton({
    required this.text,
    required this.enabled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34.h,
      child: OutlinedButton(
        onPressed: enabled ? onTap : null,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFD1D5DB)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
        ),
        child: Text(text, style: TextStyle(fontSize: 12.sp)),
      ),
    );
  }
}
