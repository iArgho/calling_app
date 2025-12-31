import 'package:calling_app/app/services/agora_service.dart';
import 'package:calling_app/app/views/widgets/local_video_view_widget.dart';
import 'package:calling_app/app/views/widgets/remote_video_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AgoraService _agoraService = AgoraService();

  RtcEngine? _engine;
  int? _remoteUid;
  bool _localJoined = false;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  @override
  void dispose() {
    _agoraService.dispose();
    super.dispose();
  }

  Future<void> _initAgora() async {
    _engine = await _agoraService.init(
      onLocalJoined: () {
        setState(() => _localJoined = true);
      },
      onRemoteJoined: (uid) {
        setState(() => _remoteUid = uid);
      },
      onRemoteLeft: () {
        setState(() => _remoteUid = null);
      },
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_engine == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          RemoteVideoView(
            engine: _engine!,
            remoteUid: _remoteUid,
          ),
          Positioned(
            top: 20,
            left: 20,
            child: LocalVideoView(
              engine: _engine!,
              joined: _localJoined,
            ),
          ),
        ],
      ),
    );
  }
}