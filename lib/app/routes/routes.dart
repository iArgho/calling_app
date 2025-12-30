import 'package:calling_app/app/views/screens/auth/login_screen.dart';
import 'package:calling_app/app/views/screens/home/home_screen.dart';
import 'package:calling_app/app/views/splash_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static String splashScreen = "/splash-screen";
  static String loginScreen = "/login-screen";
  static String homeScreen = "/home-screen";
  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen(title: '',)),
  ];
}
