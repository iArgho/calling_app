import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template_getx/app/routes/routes.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            SvgPicture.asset(
              'assets/logos/aurora.svg',
              width: 0.8.sw,
              colorFilter: const ColorFilter.mode(
                Color(0xFF39B54A),
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              'title'.tr,
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
