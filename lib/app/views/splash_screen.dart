import 'package:calling_app/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(AppRoutes.loginScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.phone_in_talk, size: 0.5.sw, color: Theme.of(context).primaryColor),
            SizedBox(height: 10.h),
            Text(
              'title'.tr,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
