import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StudentRow {
  final String boardName;
  final String studentName;
  final String mobile;
  final String createdDate;

  StudentRow({
    required this.boardName,
    required this.studentName,
    required this.mobile,
    required this.createdDate,
  });
}

class ViewStudentsController extends GetxController {
  // Date inputs
  final fromDateTextController = TextEditingController();
  final toDateTextController = TextEditingController();

  // Search input (datatable search)
  final searchController = TextEditingController();
  final searchQuery = "".obs;

  // Pagination
  final page = 1.obs;
  final pageSize = 10;
  final totalEntries = 0.obs;

  // Loading
  final isLoading = false.obs;

  // Data (simulate API list)
  final students = <StudentRow>[].obs;

  // Filtered list (search + page)
  List<StudentRow> get filteredStudents {
    final q = searchQuery.value.trim().toLowerCase();
    final list = q.isEmpty
        ? students
        : students.where((s) {
      return s.boardName.toLowerCase().contains(q) ||
          s.studentName.toLowerCase().contains(q) ||
          s.mobile.toLowerCase().contains(q) ||
          s.createdDate.toLowerCase().contains(q);
    }).toList();

    totalEntries.value = list.length;

    final start = (page.value - 1) * pageSize;
    final end = start + pageSize;

    if (start >= list.length) return [];
    return list.sublist(start, end > list.length ? list.length : end);
  }

  int get showingFrom => totalEntries.value == 0 ? 0 : ((page.value - 1) * pageSize) + 1;
  int get showingTo {
    final to = page.value * pageSize;
    return to > totalEntries.value ? totalEntries.value : to;
  }

  bool get canGoNext => (page.value * pageSize) < totalEntries.value;

  @override
  void onInit() {
    super.onInit();
    // initial load (optional)
    fetchStudents();
  }

  void onSearchChanged(String val) {
    searchQuery.value = val;
    page.value = 1; // reset to first page
  }

  Future<void> pickFromDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      fromDateTextController.text = DateFormat("MM/dd/yyyy").format(picked);
    }
  }

  Future<void> pickToDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      toDateTextController.text = DateFormat("MM/dd/yyyy").format(picked);
    }
  }

  Future<void> fetchStudents() async {
    isLoading.value = true;
    try {
      // TODO: Replace with your API call using Dio
      // Use fromDateTextController.text and toDateTextController.text in request
      await Future.delayed(const Duration(milliseconds: 500));

      // Dummy data (remove when API comes)
      students.assignAll([
        StudentRow(
          boardName: "CBSE",
          studentName: "Aarav Sharma",
          mobile: "9876543210",
          createdDate: "01/08/2026",
        ),
        StudentRow(
          boardName: "ICSE",
          studentName: "Ananya Singh",
          mobile: "9123456780",
          createdDate: "01/07/2026",
        ),
      ]);

      page.value = 1;
    } catch (_) {
      Get.snackbar("Error", "Failed to load students");
    } finally {
      isLoading.value = false;
    }
  }

  void prevPage() {
    if (page.value > 1) page.value--;
  }

  void nextPage() {
    if (canGoNext) page.value++;
  }

  // Export placeholders (wire with backend later)


  @override
  void onClose() {
    fromDateTextController.dispose();
    toDateTextController.dispose();
    searchController.dispose();
    super.onClose();
  }
}
