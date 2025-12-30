import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';

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
      width: 100,
      height: 150,
      child: joined
          ? AgoraVideoView(
              controller: VideoViewController(
                rtcEngine: engine,
                canvas: const VideoCanvas(uid: 0),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}