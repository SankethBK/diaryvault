import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../../auth/presentation/bloc/user_config/user_config_cubit.dart';

class NoteReadIconButton extends StatefulWidget {
  const NoteReadIconButton({Key? key}) : super(key: key);

  @override
  State createState() => _NoteReadIconButtonState();
}

class _NoteReadIconButtonState extends State<NoteReadIconButton> {
  ValueNotifier<bool> isPlayingNotifier = ValueNotifier(false);

  final flutterTts = FlutterTts()
    //..setLanguage("en-US")
    ..setSpeechRate(0.5)
    ..setVolume(1)
    ..setPitch(1.0);

  @override
  void initState() {
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

  Future<void> _speak(String text) async {
    // Get selected voice from UserConfigCubit
    final userConfigCubit = context.read<UserConfigCubit>();
    final selectedVoice = userConfigCubit.state.userConfigModel?.prefKeyVoice;

    // Set voice if available, and await completion
    if (selectedVoice != null) {
      await flutterTts.setVoice({
        'name': selectedVoice['name'],
        'locale': selectedVoice['locale'],
      });
    }

    // Now start speaking
    await flutterTts.speak(text);
  }

  @override
  void dispose() {
    flutterTts.stop();
    isPlayingNotifier.dispose();
    super.dispose();
  }
}
