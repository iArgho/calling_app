import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:calling_app/core/constants/credentials/credential.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemoteVideoView extends StatelessWidget {
  final RtcEngine engine;
  final int? remoteUid;

  const RemoteVideoView({
    super.key,
    required this.engine,
    required this.remoteUid,
  });

  @override
  Widget build(BuildContext context) {
    if (remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: engine,
          canvas: VideoCanvas(uid: remoteUid),
          connection: const RtcConnection(channelId: channel),
        ),
      );
    }

    /// Waiting state
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 32.w,
            height: 32.w,
            child: const CircularProgressIndicator(strokeWidth: 3),
          ),
          SizedBox(height: 16.h),
          Text(
            'Please wait for remote user to join',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}