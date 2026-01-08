import 'package:get/get.dart';

import '../../bindings/LeadsStatusBindings.dart';
import '../../bindings/add_student_submit_binding.dart';
import '../../bindings/home_binding.dart';
import '../../bindings/login_binding.dart';
import '../../bindings/view_students_binding.dart';
import '../../controllers/LeadsStatusController.dart';
import '../../screens/LeadsStatusScreen.dart';
import '../../screens/add_student_submit_screen.dart';
import '../../screens/admin_splash_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/login_screen.dart';
import '../../screens/view_students_screen.dart';


class AdminRoutes {
  // ==================
  // Route Names
  // ==================
  static const ADMIN_SPLASH = '/admin/splash';
  static const LOGIN = '/login';
  static const homescreen = '/homescreen';
  static const leadsstatus = '/leadsstatus';
  static const studentdata = '/studentdata';
  static const viewstudentdata = '/viewstudentdata';





  // ==================
  // Route Definitions
  // ==================
  static final List<GetPage> routes = [
    // ---------- SPLASH ----------
    GetPage(
      name: ADMIN_SPLASH,
      page: () => AdminSplashScreen(),
      transition: Transition.fadeIn,
      transitionDuration: Duration(milliseconds: 400),
    ),


    // ---------- LOGIN ----------
    GetPage(
      name: LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: homescreen,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: leadsstatus,
      page: () => LeadsStatusScreen(),
      binding: LeadsStatusBinding(),
    ),

    GetPage(
      name: studentdata,
      page: () => AddStudentSubmitScreen(),
      binding: AddStudentSubmitBinding(),
    ),

    GetPage(
      name: viewstudentdata,
      page: () => ViewStudentsScreen(),
      binding: ViewStudentsBinding(),
    ),

  ];
}
