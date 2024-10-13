import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class NoteReadIconButton extends StatefulWidget {
  const NoteReadIconButton({Key? key}) : super(key: key);

  @override
  State createState() => _NoteReadIconButtonState();
}

class _NoteReadIconButtonState extends State<NoteReadIconButton> {
  ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);

  final flutterTts = FlutterTts()
    ..setLanguage("en-US")
    ..setSpeechRate(0.5)
    ..setVolume(1)
    ..setPitch(1.0);

  @override
  void initState() {
    _getAvailableVoices();
    super.initState();
    flutterTts.setCompletionHandler(() {
      isPlayingNotifier.value = false;
    });

    flutterTts.setPauseHandler(() {
      isPlayingNotifier.value = false;
    });

    flutterTts.setContinueHandler(() {
      isPlayingNotifier.value = true;
    });
  }

  Future<void> _getAvailableVoices() async {
    List<dynamic> voices = await flutterTts.getVoices;
    print("Number of voices available: ${voices.length}");
    voices.forEach((voice) => print(voice));
  }

  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: ValueListenableBuilder(
          valueListenable: isPlayingNotifier,
          builder: (context, bool isPlaying, _) {
            return IconButton(
              icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () async {
                if (isPlaying) {
                  await flutterTts.pause();
                } else {
                  await _speak(notesBloc.state.title! +
                      ". " +
                      notesBloc.state.controller!.document.toPlainText());
                }
                isPlayingNotifier.value = !isPlayingNotifier.value;
              },
            );
          }),
    );
  }

  Future _speak(String text) async => await flutterTts.speak(text);

  @override
  void dispose() {
    flutterTts.stop();
    isPlayingNotifier.dispose();
    super.dispose();
  }
}
