import 'dart:io';

abstract class IOAuthClient {
  Future<bool> initialieClient();

  Future<bool> isFilePresent(String fileName, {bool folder = false});

  Future<bool> createFolder(String folderName, {String? parentFolder});

  Future<bool> deleteFile(String fileName, {bool folder = false});

  /// File content can be a Flutter File object, or file content, name and extension can be passed separately
  Future<bool> uploadFile({
    String? fileContent,
    String? fileName,
    String? fileExtension,
    File? file,
    required String parentFolder,
  });

  Future<File> downloadFile();
}
