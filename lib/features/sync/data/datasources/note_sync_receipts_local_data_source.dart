import 'package:dairy_app/core/databases/db_schemas.dart';
import 'package:dairy_app/core/databases/sqflite_setup.dart';
import 'package:sqflite/sqflite.dart';

import 'note_sync_receipts_local_data_source_template.dart';

class NoteSyncReceiptsLocalDataSource
    implements INoteSyncReceiptsLocalDataSource {
  NoteSyncReceiptsLocalDataSource._(this._database);

  final Database _database;

  static Future<NoteSyncReceiptsLocalDataSource> create() async =>
      NoteSyncReceiptsLocalDataSource._(await DBProvider.instance.database);

  @override
  Future<void> replaceReceipts(
    String scope,
    List<Map<String, dynamic>> remoteNotes, {
    int? remoteFolderSizeBytes,
  }
  ) async {
    await _database.transaction((transaction) async {
      await transaction.delete(
        NoteSyncReceipts.TABLE_NAME,
        where: '${NoteSyncReceipts.SYNC_SCOPE} = ?',
        whereArgs: [scope],
      );
      await transaction.insert(NoteSyncReceipts.TABLE_NAME, {
        NoteSyncReceipts.SYNC_SCOPE: scope,
        NoteSyncReceipts.NOTE_ID:
            INoteSyncReceiptsLocalDataSource.snapshotMarkerId,
        NoteSyncReceipts.CONTENT_HASH: remoteFolderSizeBytes == null
            ? 'confirmed'
            : 'confirmed|bytes:$remoteFolderSizeBytes',
      });
      for (final note in remoteNotes) {
        if (note['deleted'] == 1 ||
            note['deleted'] == true ||
            note['hash'] == null) {
          continue;
        }
        await transaction.insert(NoteSyncReceipts.TABLE_NAME, {
          NoteSyncReceipts.SYNC_SCOPE: scope,
          NoteSyncReceipts.NOTE_ID: note['id'],
          NoteSyncReceipts.CONTENT_HASH: note['hash'].toString(),
        });
      }
    });
  }

  @override
  Future<Map<String, String>> fetchReceipts(String scope) async {
    final rows = await _database.query(
      NoteSyncReceipts.TABLE_NAME,
      columns: [NoteSyncReceipts.NOTE_ID, NoteSyncReceipts.CONTENT_HASH],
      where: '${NoteSyncReceipts.SYNC_SCOPE} = ?',
      whereArgs: [scope],
    );
    return {
      for (final row in rows)
        row[NoteSyncReceipts.NOTE_ID] as String:
            row[NoteSyncReceipts.CONTENT_HASH] as String,
    };
  }
}
