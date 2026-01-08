import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/add_student_submit_controller.dart';
import 'view_students_screen.dart';

class AddStudentSubmitScreen extends StatelessWidget {
  AddStudentSubmitScreen({super.key});

  // ✅ inject here so controller always available
  final AddStudentSubmitController controller =
  Get.put(AddStudentSubmitController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFF4F6F8),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: const Color(0xFF8E2DE2),
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            "STUDENT DATA",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: Column(
              children: [
                // ✅ tabbar with vertical divider effect
                SizedBox(
                  height: 48.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: TabBar(
                          indicatorColor: Colors.white,
                          indicatorWeight: 3,
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white.withOpacity(0.75),
                          labelStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          unselectedLabelStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          tabs: const [
                            Tab(text: "Add Student"),
                            Tab(text: "View Student"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ✅ line below tabbar
                Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.35),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // TAB 1: ADD STUDENT (same UI)
            SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(18.w),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add Student",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isNarrow = constraints.maxWidth < 680;
                            return Wrap(
                              runSpacing: 14.h,
                              spacing: 16.w,
                              children: [
                                SizedBox(
                                  width: isNarrow
                                      ? constraints.maxWidth
                                      : (constraints.maxWidth - 16.w) / 2,
                                  child: _BoardDropdown(controller: controller),
                                ),
                                SizedBox(
                                  width: isNarrow
                                      ? constraints.maxWidth
                                      : (constraints.maxWidth - 16.w) / 2,
                                  child:
                                  _FilePickerField(controller: controller),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 18.h),
                        Obx(() {
                          final loading = controller.isSubmitting.value;
                          return SizedBox(
                            height: 42.h,
                            width: 140.w,
                            child: ElevatedButton.icon(
                              onPressed:
                              loading ? null : controller.submitStudents,
                              icon: loading
                                  ? SizedBox(
                                width: 18.w,
                                height: 18.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                                  : const Icon(Icons.send),
                              label: Text(loading ? "Submitting..." : "Submit"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF00B894),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // TAB 2: VIEW STUDENT (embedded)
            ViewStudentsScreen(),
          ],
        ),
      ),
    );
  }
}

class _BoardDropdown extends StatelessWidget {
  final AddStudentSubmitController controller;
  const _BoardDropdown({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Board Name",
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        Obx(() {
          return DropdownButtonFormField<String>(
            value: controller.selectedBoardId.value.isEmpty
                ? null
                : controller.selectedBoardId.value,
            items: controller.boards
                .map(
                  (b) => DropdownMenuItem<String>(
                value: b.id,
                child: Text(b.name),
              ),
            )
                .toList(),
            onChanged: (val) => controller.selectedBoardId.value = val ?? "",
            decoration: InputDecoration(
              hintText: "--Select Board Name--",
              contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
          );
        }),
      ],
    );
  }
}

class _FilePickerField extends StatelessWidget {
  final AddStudentSubmitController controller;
  const _FilePickerField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Upload",
            style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600)),
        SizedBox(height: 8.h),
        Obx(() {
          return InkWell(
            onTap: controller.pickFile,
            borderRadius: BorderRadius.circular(6.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: const Color(0xFFD0D5DD)),
              ),
              child: Row(
                children: [
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(color: const Color(0xFFD0D5DD)),
                      color: const Color(0xFFF9FAFB),
                    ),
                    child: Text("Choose file",
                        style: TextStyle(fontSize: 12.sp)),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      controller.fileName.value.isEmpty
                          ? "No file chosen"
                          : controller.fileName.value,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF6B7280),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
