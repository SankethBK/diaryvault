import 'dart:io';

abstract class IExportNotesRepository {
  /// Exports the notes with note id's passed in [noteList]. If [noteList] is empty
  /// then all notes will be exported. Only $title, $plainText, $createdAt and $lastModified info
  /// of notes will be exported.
  /// ! Returned should be deleted after exporting, otherwise leads to unnecessry memory usuage
  Future<String> exportNotesToTextFile(
      {required File file, List<String> noteList});

  Future<String> exportNotesToPDF({List<String> noteList});
}
