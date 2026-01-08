import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/home_screen.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;
  var isPasswordHidden = true.obs;
  var selectedRole = 'School'.obs;

  final box = GetStorage();

  // Removed API call for now

  Future<void> loginUser() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar(
        "Error",
        "Email & Password can't be empty",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    isLoading.value = true;

    // Simulating a successful login without API call
    Future.delayed(const Duration(seconds: 2), () {
      // Assuming login is successful
      Get.snackbar(
        "Success",
        "Login Successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Save login status
      box.write("isLoggedIn", true);

      // Navigate to HomeScreen
      Get.off(() => HomeScreen());
    });

    isLoading.value = false;
  }
}
