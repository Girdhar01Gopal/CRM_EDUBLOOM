import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      resizeToAvoidBottomInset: true, // Ensures content doesn't overflow when keyboard appears
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Center(
            child: Container(
              alignment: Alignment.center, // Ensures card is centered vertically and horizontally
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height, // Ensures the card stays in the center of the screen
              ),
              child: Card(
                // Card with yellow background and black shadow
                color: Colors.white, // Card background color
                elevation: 12, // Card shadow
                shadowColor: Colors.black, // Shadow color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the card
                ),
                child: Padding(
                  padding: EdgeInsets.all(16), // Padding inside the card
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo Image
                      Image.asset(
                        'assets/images/EDUBLOOM.png', // Replace with your logo path
                        height: 80,  // Adjusted logo size for smaller card
                        width: 80,   // Adjusted logo size for smaller card
                      ),
                      SizedBox(height: 8),
                      // Edubloom CRM in Cursive
                      Text(
                        "Edubloom CRM",
                        style: TextStyle(
                          fontSize: 28,  // Adjusted font size to fit smaller card
                          fontFamily: 'Pacifico', // Cursive font (change if needed)
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 20),
                      TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          labelText: 'Enter Email',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Obx(
                            () => TextField(
                          controller: controller.passwordController,
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                            labelText: 'Enter Password',
                            border: OutlineInputBorder(),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                controller.isPasswordHidden.value =
                                !controller.isPasswordHidden.value;
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      // Forgot Password and Create Account Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Implement forgot password functionality
                            },
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.red), // Red color
                            ),
                          ),
                          // SizedBox(width: 20),
                          // TextButton(
                          //   onPressed: () {
                          //     // Implement account creation functionality
                          //   },
                          //   child: Text(
                          //     "Create Account",
                          //     style: TextStyle(color: Colors.green), // Green color
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Login Button with Gradient
                      ElevatedButton(
                        onPressed: () {
                          controller.loginUser();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200, 40), backgroundColor: Colors.transparent, // For gradient background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ).copyWith(
                          shadowColor: MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Ink(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.deepPurple, Colors.pink],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                            child: Obx(
                                  () => controller.isLoading.value
                                  ? CircularProgressIndicator(
                                color: Colors.white,
                              )
                                  : Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white, // White text
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
