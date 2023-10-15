import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/notes/core/exports.dart';

class NotesCloseButton extends StatelessWidget {
  final Function() onNotesClosed;

  const NotesCloseButton({Key? key, required this.onNotesClosed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.safe) {
          return IconButton(
            icon: const Icon(
              Icons.close,
              size: 25,
            ),
            onPressed: () async {
              bool? result = await showCloseDialog(context);
              if (result != null && result == true) {
                onNotesClosed();
              }
            },
          );
        }
        return Container();
      },
    );
  }
}
