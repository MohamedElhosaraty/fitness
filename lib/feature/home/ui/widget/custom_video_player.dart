import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {

  late YoutubePlayerController _youtubeController;
  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: 'CjHIKDQ4RQo',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _youtubeController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: const Color(0xFF2563EB),
    );

  }
}
