import 'dart:io';

class FileUtils {
  static Future<File> createFileWithStringContent(String content, String path) async {
    return await File(path).writeAsString(content);
  }

  static File copyAndDeleteOriginalFile(String generatedFilePath, String targetDirectory, String targetName) {
    final fileOriginal = new File(generatedFilePath);
    final fileCopy = new File('$targetDirectory/$targetName.pdf');
    fileCopy.writeAsBytesSync(File.fromUri(fileOriginal.uri).readAsBytesSync());
    fileOriginal.delete();
    return fileCopy;
  }
}
