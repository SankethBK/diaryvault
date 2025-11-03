import 'package:dairy_app/features/smart_folders/data/models/smart_folders_model.dart';
import 'package:test/test.dart';


void main() {
  test('Testing smart folder conversion to string and to Json', () {

    final smartFolder = SmartFolderModel(
        folder_id: 'a873a170-6447-11ee-9a76-c314b6be99a5',
        createdAt: DateTime.fromMillisecondsSinceEpoch(1726597075215),
        folder_name: 'MySmartFolder',
        folder_tags: ["abc","def"]
    );

    // Convert to String
    expect(smartFolder.toString(),'SmartFolder(folder_id: a873a170-6447-11ee-9a76-c314b6be99a5, createdAt: 2024-09-17 20:17:55.215, folder_name: MySmartFolder, folder_tags: ["abc","def"], authorId: null))');

    // Convert to Json
    expect(smartFolder.toJson().toString(), '{folder_id: a873a170-6447-11ee-9a76-c314b6be99a5, created_at: 1726597075215, folder_name: MySmartFolder, folder_tags: ["abc","def"]}');

    // Convert to Json then back to SmartFolderModel and verify they are considered equal
    expect(SmartFolderModel.fromJson(smartFolder.toJson()) == smartFolder, true);
  });

  test('Testing equality between two smart folders', () {

    final smartFolder = SmartFolderModel(
        folder_id: 'a873a170-6447-11ee-9a76-c314b6be99a5',
        createdAt: DateTime.fromMillisecondsSinceEpoch(1726597075215),
        folder_name: 'MySmartFolder',
        folder_tags: ["abc","def"]
    );

    final identicalSmartFolder = SmartFolderModel(
        folder_id: 'a873a170-6447-11ee-9a76-c314b6be99a5',
        createdAt: DateTime.fromMillisecondsSinceEpoch(1726597075215),
        folder_name: 'MySmartFolder',
        folder_tags: ["abc","def"]
    );

    expect(smartFolder == smartFolder, true); // identical references
    expect(smartFolder == identicalSmartFolder, true); // different references, same content

    final differentName = SmartFolderModel(
        folder_id: 'a873a170-6447-11ee-9a76-c314b6be99a5',
        createdAt: DateTime.fromMillisecondsSinceEpoch(1726597075215),
        folder_name: 'NotMySmartFolder',
        folder_tags: ["abc","def"]
    );

    final differentTags = SmartFolderModel(
        folder_id: 'a873a170-6447-11ee-9a76-c314b6be99a5',
        createdAt: DateTime.fromMillisecondsSinceEpoch(1726597075215),
        folder_name: 'MySmartFolder',
        folder_tags: ["lorem"]
    );

    final differentID = SmartFolderModel(
        folder_id: 'AAAAAA-6447-11ee-9a76-c314b6be99a5',
        createdAt: DateTime.fromMillisecondsSinceEpoch(1726597075215),
        folder_name: 'MySmartFolder',
        folder_tags: ["abc","def"]
    );

    expect(smartFolder == differentName, false);
    expect(smartFolder == differentTags, false);
    expect(smartFolder == differentID, false);

  });
}