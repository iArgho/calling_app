import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:calling_app/core/constants/credentials/credential.dart';
import 'package:flutter/material.dart';

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
    } else {
      return const Center(
        child: Text(
          'Please wait for remote user to join',
          textAlign: TextAlign.center,
        ),
      );
    }
  }
}