import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/notes/core/exports.dart';

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

  Future _speak(String text) async => await flutterTts.speak(text);

  @override
  void dispose() {
    flutterTts.stop();
    isPlayingNotifier.dispose();
    super.dispose();
  }
}
