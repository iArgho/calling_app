import 'package:template_getx/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:template_getx/core/constants/language/language.dart';

class TemplateGetx extends StatelessWidget {
  const TemplateGetx({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'TemplateGetx',
          translations: Language(),
          locale: const Locale('en', 'US'), //default locale
          fallbackLocale: const Locale('en', 'US'),
          theme: ThemeData(
            primaryColor: const Color(0xFF39B54A),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            //fontFamily: 'Inter',
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Color(0xFFFFFFFF),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              ),
            ),
          ),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
