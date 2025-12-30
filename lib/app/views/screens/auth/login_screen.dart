import 'package:calling_app/app/routes/routes.dart';
import 'package:calling_app/app/views/widgets/text_button_widget.dart';
import 'package:calling_app/app/views/widgets/text_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool rememberMe = false;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
             SizedBox(height: 50.h),
              Icon(Icons.phone_in_talk, size: 0.3.sw, color: Theme.of(context).primaryColor),
            SizedBox(height: 10.h),
            Text(
              'loginTitle'.tr,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
            ),
              SizedBox(height: 80.h),

              /// Email
              Text(
                'enterEmail'.tr,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 6.h),
              InputField(
                hintText: 'email'.tr,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.h),

              /// Password
              Text(
                'enterPassword'.tr,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 6.h),
              InputField(hintText: 'password'.tr, obscureText: true),

              SizedBox(height: 12.h),

              StatefulBuilder(
                builder: (context, setState) {
                  return Row(
                    children: [
                      SizedBox(
                        width: 18.w,
                        height: 18.w,
                        child: Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          activeColor: const Color(0xFF39B54A),
                          visualDensity: VisualDensity
                              .compact, // removes extra touch padding
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Text('rememberMe'.tr, style: TextStyle(fontSize: 12.sp)),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          // Navigate to signup
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'forgotPassword'.tr,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 40.h),

              /// Login button
              TextWidgetButton(
                text: 'login'.tr,
                onPressed: () {
                  Get.toNamed(AppRoutes.homeScreen);
                },
              ),

              SizedBox(height: 16.h),

              /// Already have account? Sign Up (optional alternative row)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('noAccount'.tr, style: TextStyle(fontSize: 12.sp)),
                  SizedBox(width: 6.w),
                  TextButton(
                    onPressed: () {
                      // Navigate to signup
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'signUp'.tr,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
