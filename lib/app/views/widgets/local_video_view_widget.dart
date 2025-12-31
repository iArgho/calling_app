import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocalVideoView extends StatelessWidget {
  final RtcEngine engine;
  final bool joined;

  const LocalVideoView({
    super.key,
    required this.engine,
    required this.joined,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 150.h,
      child: joined
          ? Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.9),
                  width: 1.5.w,
                ),
                
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                ),
              ),
            )
          : Center(
              child: SizedBox(
                width: 24.w,
                height: 24.w,
                child: const CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
    );
  }
}