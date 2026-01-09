import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayFollowUpLeadRow {
  final String name;
  final String email;
  final String mobile;
  final String status;
  final String relatedTo;
  final String followUpDate;
  final String lastActivityDate;

  TodayFollowUpLeadRow({
    required this.name,
    required this.email,
    required this.mobile,
    required this.status,
    required this.relatedTo,
    required this.followUpDate,
    required this.lastActivityDate,
  });
}

class TodayFollowUpLeadsController extends GetxController {
  final isLoading = false.obs;

  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  final entriesPerPage = 10.obs;
  final page = 1.obs;

  final leads = <TodayFollowUpLeadRow>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodayFollowUpLeads();
  }

  void onSearchChanged(String value) {
    searchQuery.value = value.trim();
    page.value = 1;
  }

  void changeEntries(int value) {
    entriesPerPage.value = value;
    page.value = 1;
  }

  List<TodayFollowUpLeadRow> get _filtered {
    final q = searchQuery.value.toLowerCase();
    if (q.isEmpty) return leads;

    return leads.where((e) {
      return e.name.toLowerCase().contains(q) ||
          e.email.toLowerCase().contains(q) ||
          e.mobile.toLowerCase().contains(q) ||
          e.status.toLowerCase().contains(q) ||
          e.relatedTo.toLowerCase().contains(q) ||
          e.followUpDate.toLowerCase().contains(q) ||
          e.lastActivityDate.toLowerCase().contains(q);
    }).toList();
  }

  int get totalEntries => _filtered.length;

  List<TodayFollowUpLeadRow> get pagedLeads {
    final list = _filtered;
    final start = (page.value - 1) * entriesPerPage.value;
    final end = start + entriesPerPage.value;

    if (start >= list.length) return [];
    return list.sublist(start, end > list.length ? list.length : end);
  }

  int get showingFrom =>
      totalEntries == 0 ? 0 : ((page.value - 1) * entriesPerPage.value) + 1;

  int get showingTo {
    final to = page.value * entriesPerPage.value;
    return to > totalEntries ? totalEntries : to;
  }

  bool get canGoPrev => page.value > 1;
  bool get canGoNext => (page.value * entriesPerPage.value) < totalEntries;

  void prevPage() {
    if (canGoPrev) page.value--;
  }

  void nextPage() {
    if (canGoNext) page.value++;
  }

  Future<void> fetchTodayFollowUpLeads() async {
    isLoading.value = true;
    try {
      // TODO: Replace with API call
      await Future.delayed(const Duration(milliseconds: 400));

      // ✅ Keep empty to match screenshot (No data)
      leads.assignAll([]);

      page.value = 1;
    } catch (_) {
      Get.snackbar("Error", "Failed to load leads");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
