abstract class INoteSyncReceiptsLocalDataSource {
  static const String snapshotMarkerId = '__backup_snapshot_confirmed__';

  Future<void> replaceReceipts(
    String scope,
    List<Map<String, dynamic>> remoteNotes, {
    int? remoteFolderSizeBytes,
  }
  );

  Future<Map<String, String>> fetchReceipts(String scope);
}
