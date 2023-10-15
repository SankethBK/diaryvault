import 'package:dairy_app/core/constants/exports.dart';
import 'package:dairy_app/features/notes/core/exports.dart';

enum PageName { NoteCreatePage, NoteReadOnlyPage }

class ToggleReadWriteButton extends StatelessWidget {
  final PageName pageName;
  const ToggleReadWriteButton({Key? key, required this.pageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 13.0),
      child: IconButton(
        icon: (pageName == PageName.NoteCreatePage)
            ? const Icon(Icons.visibility)
            : const Icon(Icons.edit),
        onPressed: (pageName == PageName.NoteCreatePage)
            ? () => Navigator.of(context)
                .popAndPushNamed(NotesReadOnlyPage.routeThoughNotesCreate)
            : () => Navigator.of(context)
                .popAndPushNamed(NoteCreatePage.routeThroughNoteReadOnly),
      ),
    );
  }
}
