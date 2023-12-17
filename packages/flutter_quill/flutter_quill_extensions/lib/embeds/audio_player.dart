import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlaybackWidget extends StatefulWidget {
  const AudioPlaybackWidget({required this.audioUrl, super.key});
  final audioUrl;

  @override
  State<AudioPlaybackWidget> createState() => _AudioPlaybackWidgetState();
}

class _AudioPlaybackWidgetState extends State<AudioPlaybackWidget> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration totalDuration = Duration.zero;
  Duration currentPosition = Duration.zero;

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final minutes = duration.inMinutes;
    final remainingSeconds = duration.inSeconds.remainder(60);

    return '${twoDigits(minutes)}:${twoDigits(remainingSeconds)}';
  }

  @override
  void initState() {
    super.initState();

    setAudio();

    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        isPlaying = event == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuratiom) {
      setState(() {
        totalDuration = newDuratiom;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        currentPosition = newPosition;
      });
    });

    audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
    });
  }

  Future setAudio() async {
    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.setSource(DeviceFileSource(widget.audioUrl));
  }

  @override
  void dispose() {
    super.dispose();

    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30), // Adjust the value as needed
        border: Border.all(
          color: Colors.grey, // Border color
        ),
        color: Colors.white.withOpacity(0.1),
      ), // height: 50,
      child: Row(
        children: [
          Column(
            children: [
              IconButton(
                  onPressed: () async {
                    if (isPlaying) {
                      await audioPlayer.pause();
                    } else {
                      await audioPlayer.resume();
                    }
                  },
                  color: Colors.white,
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow)),
            ],
          ),
          Slider(
              max: totalDuration.inSeconds.toDouble(),
              value: currentPosition.inSeconds.toDouble(),
              onChanged: (value) async {
                final newPosition = Duration(seconds: value.toInt());
                await audioPlayer.seek(newPosition);

                // resume if the audio was paused
                await audioPlayer.resume();
              }),
          Text(formatTime(currentPosition)),
          const Text(" / "),
          Text(formatTime(totalDuration)),
        ],
      ),
    );
  }
}
