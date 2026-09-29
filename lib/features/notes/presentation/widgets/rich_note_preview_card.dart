import 'dart:convert';

import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/search_highlight_color.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/entities/notes.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/notes/presentation/bloc/selectable_list/selectable_list_cubit.dart';
import 'package:dairy_app/features/notes/presentation/pages/note_read_only_page.dart';
import 'package:dairy_app/features/notes/presentation/widgets/note_preview_card.dart';
import 'package:dairy_app/features/notes/presentation/widgets/read_only_editor.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart'
    show Document, QuillController;
import 'package:intl/intl.dart';

/// Card-styled note preview with a multi-line body snippet, tags and an
/// inline expandable rich-text preview. Coexists with [NotePreviewCard];
/// swap the widget used in the notes list to switch between the two.
class RichNotePreviewCard extends StatefulWidget {
  const RichNotePreviewCard({
    Key? key,
    required this.note,
    required this.index,
    this.searchText = '',
    this.initiallyExpanded = false,
  }) : super(key: key);

  final NotePreview note;
  final int index;
  final String searchText;
  final bool initiallyExpanded;

  @override
  State<RichNotePreviewCard> createState() => _RichNotePreviewCardState();
}

class _RichNotePreviewCardState extends State<RichNotePreviewCard>
    with TickerProviderStateMixin {
  late bool _expanded;
  NoteModel? _fullNote;
  QuillController? _previewController;

  bool get _canExpand =>
      !widget.note.isEncrypted &&
      _fullNote != null &&
      _previewController != null;

  @override
  void initState() {
    super.initState();
    _expanded = widget.initiallyExpanded && !widget.note.isEncrypted;
    if (!widget.note.isEncrypted) _loadNote();
  }

  @override
  void didUpdateWidget(RichNotePreviewCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.note.id != oldWidget.note.id ||
        widget.note.title != oldWidget.note.title ||
        widget.note.plainText != oldWidget.note.plainText) {
      _fullNote = null;
      _previewController?.dispose();
      _previewController = null;
      if (!widget.note.isEncrypted) _loadNote();
    }
  }

  Future<void> _loadNote() async {
    final result = await sl<INotesRepository>().getNote(widget.note.id);
    if (!mounted) return;
    result.fold((_) {}, (note) {
      QuillController? controller;
      try {
        controller = QuillController(
          document: Document.fromJson(jsonDecode(note.body)),
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (_) {
        controller?.dispose();
        controller = null;
      }
      if (!mounted) {
        controller?.dispose();
        return;
      }
      setState(() {
        _fullNote = note;
        _previewController = controller;
      });
    });
  }

  void _toggleExpanded() {
    if (!_canExpand) return;
    setState(() => _expanded = !_expanded);
  }

  @override
  void dispose() {
    _previewController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final strings = S.of(context);
    final locale = Localizations.localeOf(context).toString();

    return BlocBuilder<SelectableListCubit, SelectableListState>(
      builder: (context, state) {
        final cubit = BlocProvider.of<SelectableListCubit>(context);
        final selected = cubit.state.selectedItems.contains(widget.note.id);
        final selecting = state is SelectableListEnabled;

        final gradientStartColor = selected
            ? homeTheme.notePreviewSelectedGradientStartColor
            : homeTheme.notePreviewUnselectedGradientStartColor;
        final gradientEndColor = selected
            ? homeTheme.notePreviewSelectedGradientEndColor
            : homeTheme.notePreviewUnselectedGradientEndColor;

        final tags = widget.note.isEncrypted
            ? const <String>[]
            : _fullNote?.tags ?? const <String>[];
        final plainText = widget.note.plainText
            .replaceAll('￼', ' ')
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim();

        return GestureDetector(
          onLongPress: () {
            if (state is SelectableListDisabled) {
              cubit.enableSelectableList(widget.note.id);
            }
          },
          onTap: () {
            if (selecting) {
              selected
                  ? cubit.removeItemFromSelection(widget.note.id)
                  : cubit.addItemToSelection(widget.note.id);
            } else {
              Navigator.of(context).pushNamed(
                NotesReadOnlyPage.routeThroughHome,
                arguments: widget.note.id,
              );
            }
          },
          child: Container(
            margin: EdgeInsets.fromLTRB(10, widget.index == 0 ? 2 : 4, 10, 4),
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: selected
                    ? theme.colorScheme.primary
                    : homeTheme.notePreviewBorderColor,
                width: selected ? 1.4 : 1.0,
              ),
              gradient: LinearGradient(
                colors: [
                  homeTheme.glassPaneSurface(gradientStartColor),
                  homeTheme.glassPaneSurface(gradientEndColor),
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
              boxShadow: [
                BoxShadow(
                  color: gradientEndColor.withValues(alpha: 0.22),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (selecting)
                      SelectBox(
                        isSelected: selected,
                        selectableListCubit: cubit,
                        note: widget.note,
                      )
                    else if (widget.note.isEncrypted)
                      Padding(
                        padding: const EdgeInsets.only(right: 8, top: 1),
                        child: Icon(
                          Icons.lock_rounded,
                          size: 16,
                          color: homeTheme.previewTitleColor,
                        ),
                      ),
                    Expanded(
                      child: _highlightedText(
                        widget.note.title,
                        TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.lerp(
                            FontWeight.w500,
                            FontWeight.w600,
                            0.5,
                          )!,
                          color: homeTheme.previewTitleColor,
                        ),
                        maxLines: 2,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          DateFormat.E(locale).format(widget.note.createdAt),
                          style: _dateStyle(homeTheme),
                        ),
                        Text(
                          DateFormat.yMMMd(locale)
                              .format(widget.note.createdAt),
                          style: _dateStyle(homeTheme),
                        ),
                      ],
                    ),
                  ],
                ),
                if (!_expanded && plainText.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  _highlightedText(
                    _bodySnippet(plainText, widget.searchText),
                    TextStyle(
                      fontSize: 14,
                      height: 1.35,
                      color: homeTheme.previewBodyColor,
                    ),
                    maxLines: 3,
                  ),
                ],
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: AlignmentDirectional.topCenter,
                  child: _expanded && _canExpand
                      ? Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: ConstrainedBox(
                            constraints:
                                const BoxConstraints(maxHeight: 240),
                            child: ReadOnlyEditor(
                              controller: _previewController,
                            ),
                          ),
                        )
                      : const SizedBox(width: double.infinity, height: 0),
                ),
                if (tags.isNotEmpty || _canExpand) ...[
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: tags.isEmpty
                            ? const SizedBox.shrink()
                            : Wrap(
                                spacing: 6,
                                runSpacing: 6,
                                children: tags
                                    .map(
                                      (tag) => Container(
                                        padding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 3,
                                        ),
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary
                                              .withOpacity(0.13),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                            color: theme.colorScheme
                                                .primary
                                                .withOpacity(0.35),
                                            width: 0.6,
                                          ),
                                        ),
                                        child: Text(
                                          '#$tag',
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            fontSize: 11.5,
                                            color:
                                                theme.colorScheme.primary,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                      ),
                      if (_canExpand)
                        Semantics(
                          button: true,
                          label: _expanded
                              ? strings.noteCollapsePreview
                              : strings.noteExpandPreview,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _toggleExpanded,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8, bottom: 2),
                              child: AnimatedRotation(
                                turns: _expanded ? 0.5 : 0,
                                duration:
                                    const Duration(milliseconds: 200),
                                child: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 22,
                                  color: homeTheme.dateColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  TextStyle _dateStyle(HomePageThemeExtensions homeTheme) {
    return TextStyle(
      color: homeTheme.dateColor,
      fontStyle: FontStyle.italic,
      fontSize: 12.5,
    );
  }

  String _bodySnippet(String body, String query) {
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty) return body;

    final matchIndex =
        body.toLowerCase().indexOf(normalizedQuery.toLowerCase());
    if (matchIndex < 0) return body;

    // Start the snippet at the match so the searched word is always visible.
    const contextLength = 0;
    final start = (matchIndex - contextLength).clamp(0, body.length);
    final end = (start + 220).clamp(0, body.length);
    final prefix = start > 0 ? '…' : '';
    final suffix = end < body.length ? '…' : '';
    return '$prefix${body.substring(start, end)}$suffix';
  }

  Widget _highlightedText(
    String value,
    TextStyle style, {
    int maxLines = 1,
  }) {
    final highlightColor = searchHighlightColor(context);
    final query = widget.searchText.trim();
    if (query.isEmpty || value.isEmpty) {
      return Text(value,
          style: style, maxLines: maxLines, overflow: TextOverflow.ellipsis);
    }

    final lowerValue = value.toLowerCase();
    final lowerQuery = query.toLowerCase();
    final spans = <TextSpan>[];
    var cursor = 0;
    while (cursor < value.length) {
      final match = lowerValue.indexOf(lowerQuery, cursor);
      if (match < 0) {
        spans.add(TextSpan(text: value.substring(cursor)));
        break;
      }
      if (match > cursor) {
        spans.add(TextSpan(text: value.substring(cursor, match)));
      }
      spans.add(TextSpan(
        text: value.substring(match, match + query.length),
        style: style.copyWith(
          backgroundColor: highlightColor,
          fontWeight: FontWeight.bold,
        ),
      ));
      cursor = match + query.length;
    }

    return RichText(
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(style: style, children: spans),
    );
  }
}
