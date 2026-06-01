import 'package:fitness/core/theming/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({super.key, required this.videoId});

  final String videoId;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {

  late YoutubePlayerController _youtubeController;
  @override
  void initState() {
    super.initState();
    _youtubeController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      final id = YoutubePlayer.convertUrlToId(widget.videoId) ?? widget.videoId;

      // loading and playing the video
      // _youtubeController.load(id);

      // loading the video without playing it
      _youtubeController.dispose();
      _youtubeController = YoutubePlayerController(
        initialVideoId: id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
      setState(() {});
    }
  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.videoId.isEmpty || widget.videoId == '') {
      return Container(
        width: double.infinity,
        height: 220.h,
        color: Colors.black,
        child: const Icon(
          Icons.fitness_center,
          color: AppColors.primaryColor,
          size: 100,
        ),
      );
    }
    return YoutubePlayer(
      key: ValueKey(_youtubeController.initialVideoId),
      controller: _youtubeController,
      showVideoProgressIndicator: true,
      progressIndicatorColor: AppColors.primaryColor,
    );

  }
}
