import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;

class BoardItem {
  final String id;
  final String name;
  BoardItem({required this.id, required this.name});
}

class AddStudentSubmitController extends GetxController {
  final boards = <BoardItem>[].obs;
  final selectedBoardId = "".obs;

  final filePath = "".obs;
  final fileName = "".obs;

  final isSubmitting = false.obs;

  final String baseUrl = "https://crmapi.edubloom.in";
  final String boardsUrl = "/api/boards";
  final String submitUrl = "/api/students/submit";

  late final Dio dio;

  @override
  void onInit() {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    fetchBoards();
    super.onInit();
  }

  Future<void> fetchBoards() async {
    try {
      final res = await dio.get(boardsUrl);
      final List data =
      (res.data is List) ? res.data : (res.data["data"] ?? []);
      boards.assignAll(
        data
            .map((e) => BoardItem(
          id: e["id"].toString(),
          name: e["name"].toString(),
        ))
            .toList(),
      );
    } catch (_) {
      Get.snackbar("Error", "Failed to load boards");
    }
  }

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["xls", "xlsx", "csv"],
    );
    if (result == null) return;

    filePath.value = result.files.first.path!;
    fileName.value = result.files.first.name;
  }

  Future<void> submitStudents() async {
    if (selectedBoardId.value.isEmpty || filePath.value.isEmpty) {
      Get.snackbar("Validation", "Select board and upload file");
      return;
    }

    isSubmitting.value = true;
    try {
      final formData = FormData.fromMap({
        "boardId": selectedBoardId.value,
        "file": await MultipartFile.fromFile(filePath.value),
      });

      await dio.post(
        submitUrl,
        data: formData,
        options: Options(contentType: "multipart/form-data"),
      );

      Get.snackbar("Success", "Students submitted successfully");
      filePath.value = "";
      fileName.value = "";
    } catch (_) {
      Get.snackbar("Error", "Submit failed");
    } finally {
      isSubmitting.value = false;
    }
  }
}
