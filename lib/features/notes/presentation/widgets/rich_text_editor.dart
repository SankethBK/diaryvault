import 'dart:async';
import 'dart:io';

import 'package:dairy_app/core/widgets/glassmorphism_cover.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuple/tuple.dart';

// import 'read_only_page.dart';

class RichTextEditor extends StatelessWidget {
  final FocusNode _focusNode = FocusNode();
  QuillController? controller;

  RichTextEditor({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return Expanded(child: GlassPaneForEditor(quillEditor: Container()));
    }

    return _buildWelcomeEditor(context);
  }

  Widget _buildWelcomeEditor(BuildContext context) {
    var quillEditor = QuillEditor(
        controller: controller!,
        scrollController: ScrollController(),
        scrollable: true,
        focusNode: _focusNode,
        autoFocus: false,
        readOnly: false,
        placeholder: 'Write something here...',
        expands: false,
        padding: EdgeInsets.zero,
        customStyles: DefaultStyles(
          h1: DefaultTextBlockStyle(
              const TextStyle(
                fontSize: 32,
                color: Colors.black,
                height: 1.15,
                fontWeight: FontWeight.w300,
              ),
              const Tuple2(16, 0),
              const Tuple2(0, 0),
              null),
          sizeSmall: const TextStyle(fontSize: 9),
        ));

    return Expanded(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        GlassMorphismCover(
          displayShadow: false,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: Container(
            child: Toolbar(controller: controller!),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.8),
                  Colors.white.withOpacity(0.7),
                ],
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
              ),
            ),
          ),
        ),
        Expanded(
          child: GlassPaneForEditor(quillEditor: quillEditor),
        )
      ]),
    );
  }
}

class Toolbar extends StatelessWidget {
  final QuillController controller;
  const Toolbar({Key? key, required this.controller}) : super(key: key);

  // Renders the image picked by imagePicker from local file storage
  // You can also upload the picked image to any server (eg : AWS s3
  // or Firebase) and then return the uploaded image URL.
  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }

  // Renders the video picked by imagePicker from local file storage
  // You can also upload the picked video to any server (eg : AWS s3
  // or Firebase) and then return the uploaded video URL.
  Future<String> _onVideoPickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
        await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }

  // ignore: unused_element
  Future<MediaPickSetting?> _selectMediaPickSetting(BuildContext context) {
    return showDialog<MediaPickSetting>(
      context: context,
      builder: (ctx) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.collections),
              label: const Text('Gallery'),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Gallery),
            ),
            TextButton.icon(
              icon: const Icon(Icons.link),
              label: const Text('Link'),
              onPressed: () => Navigator.pop(ctx, MediaPickSetting.Link),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    QuillIconTheme quillIconTheme = QuillIconTheme(
      iconSelectedColor: Colors.white,
      iconUnselectedColor: Colors.pink.shade300,
      iconSelectedFillColor: Colors.pink.shade300,
      iconUnselectedFillColor: Colors.transparent,
      disabledIconColor: Colors.cyan,
      borderRadius: 5.0,
    );

    return QuillToolbar.basic(
      controller: controller,
      // provide a callback to enable picking images from device.
      // if omit, "image" button only allows adding images from url.
      // same goes for videos.
      onImagePickCallback: _onImagePickCallback,
      onVideoPickCallback: _onVideoPickCallback,
      // uncomment to provide a custom "pick from" dialog.
      mediaPickSettingSelector: _selectMediaPickSetting,
      color: Colors.transparent,
      showFontSize: false,
      toolbarIconSize: 23,
      toolbarSectionSpacing: 4,
      toolbarIconAlignment: WrapAlignment.center,
      showDividers: true,
      showBoldButton: true,
      showItalicButton: true,
      showSmallButton: false,
      showUnderLineButton: true,
      showStrikeThrough: true,
      showInlineCode: false,
      showColorButton: true,
      showBackgroundColorButton: true,
      showClearFormat: false,
      showAlignmentButtons: false,
      showLeftAlignment: false,
      showCenterAlignment: false,
      showRightAlignment: false,
      showJustifyAlignment: false,
      showHeaderStyle: true,
      showListNumbers: true,
      showListBullets: true,
      showListCheck: false,
      showCodeBlock: false,
      showQuote: true,
      showIndent: false,
      showLink: true,
      showUndo: false,
      showRedo: false,
      multiRowsDisplay: false,
      showImageButton: true,
      showVideoButton: true,
      showCameraButton: true,
      showDirection: false,
      iconTheme: quillIconTheme,
    );
  }
}

class GlassPaneForEditor extends StatelessWidget {
  const GlassPaneForEditor({
    Key? key,
    required this.quillEditor,
  }) : super(key: key);

  final Widget quillEditor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: GlassMorphismCover(
        displayShadow: false,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 5),
          // margin: const EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.7),
                Colors.white.withOpacity(0.5),
              ],
              begin: AlignmentDirectional.topStart,
              end: AlignmentDirectional.bottomEnd,
            ),
          ),
          child: quillEditor,
        ),
      ),
    );
  }
}
