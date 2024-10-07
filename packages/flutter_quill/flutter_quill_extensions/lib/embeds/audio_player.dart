import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlaybackWidget extends StatefulWidget {
  const AudioPlaybackWidget(
      {required this.audioUrl, required this.fileName, super.key});
  final audioUrl;
  final String fileName;

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
      if (mounted) {
        setState(() {
          isPlaying = event == PlayerState.playing;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((newDuratiom) {
      if (mounted) {
        setState(() {
          totalDuration = newDuratiom;
        });
      }
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      if (mounted) {
        setState(() {
          currentPosition = newPosition;
        });
      }
    });

    audioPlayer.onPlayerComplete.listen((event) {
      if (mounted) {
        setState(() {
          isPlaying = false;
        });
      }
    });
  }

  Future setAudio() async {
    await audioPlayer.setReleaseMode(ReleaseMode.stop);
    await audioPlayer.setSource(DeviceFileSource(widget.audioUrl));
  }

  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
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
        child: SizedBox(
          height: 55,
          child: isPlaying ? _buildPlayer() : _buildInitialView(),
        ) // Use isPlaying to toggle between views
        );
  }

  // Audio player view that appears after the audio starts playing
  Widget _buildInitialView() {
    return ListTile(
      leading: Icon(Icons.audiotrack, color: Colors.grey.shade700),
      title: Row(
        children: [
          // Clipped file name with ellipsis
          Expanded(
            child: Text(
              widget.fileName,
              maxLines: 1, // Ensures only one line
              overflow:
                  TextOverflow.ellipsis, // Clip text with ellipsis if too long
            ),
          ),
          const SizedBox(width: 15),
          // Display the total duration of the audio file
          Text(
            formatTime(totalDuration),
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
      onTap: () async {
        await audioPlayer.play(DeviceFileSource(widget.audioUrl));
        setState(() {
          isPlaying = true;
        });
      },
    );
  }

  // Audio player view that appears after the audio starts playing
  Widget _buildPlayer() {
    return Row(
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
          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        ),
        Expanded(
          child: Slider(
            max: totalDuration.inSeconds.toDouble(),
            value: currentPosition.inSeconds.toDouble(),
            onChanged: (value) async {
              final newPosition = Duration(seconds: value.toInt());
              await audioPlayer.seek(newPosition);

              // resume if the audio was paused
              await audioPlayer.resume();
            },
          ),
        ),
        Text('${formatTime(currentPosition)} / ${formatTime(totalDuration)}'),
        const SizedBox(width: 15),
      ],
    );
  }
}
