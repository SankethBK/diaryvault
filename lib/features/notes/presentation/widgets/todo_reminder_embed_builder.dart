import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/features/notes/core/utils/todo_delta_parser.dart';
import 'package:dairy_app/features/notes/presentation/widgets/todo_reminder_actions.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:intl/intl.dart';

/// Renders the reminder chip that sits at the end of a todo line. In edit
/// mode tapping it offers to change or remove the reminder; in read mode
/// it is display-only.
class TodoReminderEmbedBuilder extends EmbedBuilder {
  const TodoReminderEmbedBuilder({this.embedKey = kTodoReminderEmbedType});

  final String embedKey;

  @override
  String get key => embedKey;

  @override
  bool get expanded => false;

  @override
  Widget build(BuildContext context, QuillController controller, Embed node,
      bool readOnly, bool inline, TextStyle textStyle) {
    final custom = _customEmbed(node);
    if (node.value.type == kTodoReminderActionEmbedType ||
        custom?.type == kTodoReminderActionEmbedType) {
      if (readOnly) return const SizedBox.shrink();
      final color = Theme.of(context)
              .extension<NoteCreatePageThemeExtensions>()
              ?.mainTextColor ??
          Theme.of(context).colorScheme.primary;
      return Padding(
        padding: const EdgeInsets.only(left: 3, right: 5),
        child: IconButton(
          tooltip: S.current.setTodoReminder,
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints(minWidth: 30, minHeight: 30),
          padding: EdgeInsets.zero,
          icon: Icon(Icons.alarm_add, size: 19, color: color.withOpacity(0.6)),
          onPressed: readOnly
              ? null
              : () => TodoReminderActions.setReminderAtOffset(
                  context, controller, node.documentOffset),
        ),
      );
    }

    DateTime? time;
    try {
      final data = _decodeReminderData(node);
      if (data != null) {
        time = DateTime.fromMillisecondsSinceEpoch(data["time"] as int);
      }
    } catch (_) {}

    final label = time == null ? '' : DateFormat('d MMM, h:mm a').format(time);

    final mainTextColor = Theme.of(context)
            .extension<NoteCreatePageThemeExtensions>()
            ?.mainTextColor ??
        Theme.of(context).colorScheme.onSurface;

    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8, end: 2),
      child: InkWell(
        onTap: () => TodoReminderActions.onReminderChipTapped(
            context, controller, node),
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: mainTextColor.withOpacity(0.35)),
            color: mainTextColor.withOpacity(0.08),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.alarm, size: 13, color: mainTextColor.withOpacity(0.85)),
              if (label.isNotEmpty) ...[
                const SizedBox(width: 3),
                Text(
                  label,
                  style: TextStyle(
                      fontSize: 11, color: mainTextColor.withOpacity(0.85)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Map<String, dynamic>? _decodeReminderData(Embed node) {
    if (node.value.type == kTodoReminderEmbedType) {
      return decodeTodoReminderData(node.value.data as String);
    }

    final custom = _customEmbed(node);
    if (custom == null) return null;
    if (custom.type != kTodoReminderEmbedType) return null;
    return decodeTodoReminderData(custom.data as String);
  }

  CustomBlockEmbed? _customEmbed(Embed node) {
    if (node.value.type != BlockEmbed.customType) return null;
    try {
      return CustomBlockEmbed.fromJsonString(node.value.data as String);
    } catch (_) {
      return null;
    }
  }
}
