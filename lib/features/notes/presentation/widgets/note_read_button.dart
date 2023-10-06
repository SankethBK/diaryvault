import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';


class NoteReadIconButton extends StatefulWidget {
  const NoteReadIconButton({Key? key}) : super(key: key);

  @override
  State<NoteReadIconButton> createState() => _NoteReadIconButtonState();
}

class _NoteReadIconButtonState extends State<NoteReadIconButton> {
  final FlutterTts flutterTts = FlutterTts()
    ..setLanguage("en-US")
    ..setSpeechRate(0.5)
    ..setPitch(1.0);
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    flutterTts.setPauseHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    flutterTts.setContinueHandler(() {
      setState(() {
        isPlaying = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final notesBloc = BlocProvider.of<NotesBloc>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: IconButton(
        icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        onPressed: () async {
          if (isPlaying) {
            await flutterTts.pause();
          } else {
            await _speak(notesBloc.state.title! +
                ". " +
                notesBloc.state.controller!.document.toPlainText());
          }
          setState(() => isPlaying = !isPlaying);
        },
      ),
    );
  }

  Future _speak(String text) async =>  
    await flutterTts.speak(text);

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
