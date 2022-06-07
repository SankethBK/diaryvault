import 'dart:io';

abstract class IOAuthClient {
  Future<void> uploadFIle(File file);
  Future<File> downloadFile();
}
