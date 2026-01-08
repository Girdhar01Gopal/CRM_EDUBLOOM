import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/view_students_controller.dart';

class ViewStudentsScreen extends StatelessWidget {
  ViewStudentsScreen({super.key});

  // ✅ controller inject here so "controller not found" NEVER happens
  final ViewStudentsController controller = Get.put(ViewStudentsController());

  static const double _tableWidth = 760;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ====== Date Filters Row ======
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 520;
              final fieldWidth =
              isNarrow ? (constraints.maxWidth - 10.w) / 2 : 260.w;

              return Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  SizedBox(
                    width: fieldWidth,
                    child: _DateField(
                      label: "From date:",
                      controller: controller.fromDateTextController,
                      onTap: () => controller.pickFromDate(context),
                    ),
                  ),
                  SizedBox(
                    width: fieldWidth,
                    child: _DateField(
                      label: "To date:",
                      controller: controller.toDateTextController,
                      onTap: () => controller.pickToDate(context),
                    ),
                  ),
                  SizedBox(
                    width: isNarrow ? constraints.maxWidth : 120.w,
                    height: 44.h,
                    child: Obx(() {
                      return ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.fetchStudents,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE96A7A),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Text("Search"),
                      );
                    }),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 18.h),

          // ====== Search Box ======
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 700;
              return Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: isNarrow ? constraints.maxWidth : 260.w,
                  child: _SearchBox(controller: controller),
                ),
              );
            },
          ),

          SizedBox(height: 14.h),

          // ====== Table (ONE HORIZONTAL SCROLL FOR ALL) ======
          Obx(() {
            final filtered = controller.filteredStudents;

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFE5E7EB)),
                color: Colors.white,
              ),
              child: filtered.isEmpty
                  ? Container(
                height: 70.h,
                alignment: Alignment.center,
                child: Text(
                  "No data available in table",
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              )
                  : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: _tableWidth,
                  child: Column(
                    children: [
                      // Header
                      Container(
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: const Color(0xFF6D2C91),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            topRight: Radius.circular(8.r),
                          ),
                        ),
                        child: Row(
                          children: const [
                            _Th("S.No.", flex: 1),
                            _Th("Board Name", flex: 3),
                            _Th("Student Name", flex: 3),
                            _Th("Mobile", flex: 2),
                            _Th("Create Date", flex: 3),
                          ],
                        ),
                      ),

                      // Body
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const Divider(
                          height: 1,
                          color: Color(0xFFE5E7EB),
                        ),
                        itemBuilder: (context, index) {
                          final s = filtered[index];
                          return SizedBox(
                            height: 46.h,
                            child: Row(
                              children: [
                                _Td("${index + 1}", flex: 1),
                                _Td(s.boardName, flex: 3),
                                _Td(s.studentName, flex: 3),
                                _Td(s.mobile, flex: 2),
                                _Td(s.createdDate, flex: 3),
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
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: "mm/dd/yyyy",
            suffixIcon: const Icon(Icons.calendar_month_outlined),
            contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchBox extends StatelessWidget {
  final ViewStudentsController controller;
  const _SearchBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Search:",
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        TextField(
          controller: controller.searchController,
          onChanged: controller.onSearchChanged,
          decoration: InputDecoration(
            hintText: "Type to search...",
            contentPadding:
            EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
        ),
      ],
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
            fontSize: 13.sp,
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
          style: TextStyle(fontSize: 13.sp, color: const Color(0xFF111827)),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
