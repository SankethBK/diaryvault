import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A lightweight view of recent writing activity, derived from saved notes.
class WritingActivityPane extends StatelessWidget {
  const WritingActivityPane({super.key});

  @override
  Widget build(BuildContext context) {
    final notesResult = sl<INotesRepository>().fetchNotes();
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final strings = S.of(context);

    return FutureBuilder(
      future: notesResult,
      builder: (context, snapshot) {
        final result = snapshot.data;
        final stats = result == null
            ? null
            : result.fold<_WritingActivityStats?>(
                (_) => null,
                _WritingActivityStats.fromNotes,
              );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: homeTheme.notePreviewBorderColor),
              gradient: LinearGradient(
                colors: [
                  homeTheme.notePreviewUnselectedGradientStartColor,
                  homeTheme.notePreviewUnselectedGradientEndColor,
                ],
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
              ),
            ),
            child: snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),
                  )
                : snapshot.hasError || stats == null
                    ? Center(
                        child: Text(
                          S.of(context).failedToFetchNote,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: homeTheme.previewBodyColor,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  strings.writingActivity,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: homeTheme.previewTitleColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Text(
                                strings.writingActivityPeriod,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: homeTheme.dateColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: _ActivityMetric(
                                  label: strings.writingCurrentStreak,
                                  value: stats.currentStreak.toString(),
                                  unit: stats.currentStreak == 1
                                      ? strings.writingDay
                                      : strings.writingDays,
                                ),
                              ),
                              Expanded(
                                child: _ActivityMetric(
                                  label: strings.writingLongestStreak,
                                  value: stats.longestStreak.toString(),
                                  unit: stats.longestStreak == 1
                                      ? strings.writingDay
                                      : strings.writingDays,
                                ),
                              ),
                              Expanded(
                                child: _ActivityMetric(
                                  label: strings.writingTotalWords,
                                  value: NumberFormat.decimalPattern(
                                    Localizations.localeOf(context).toString(),
                                  ).format(stats.totalWords),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          _ActivityHeatmap(
                            dailyNoteCounts: stats.dailyNoteCounts,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            strings.writingActivityPrivacyNote,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: homeTheme.dateColor,
                            ),
                          ),
                        ],
                      ),
          ),
        );
      },
    );
  }
}

class _WritingActivityStats {
  const _WritingActivityStats({
    required this.dailyNoteCounts,
    required this.currentStreak,
    required this.longestStreak,
    required this.totalWords,
  });

  final Map<DateTime, int> dailyNoteCounts;
  final int currentStreak;
  final int longestStreak;
  final int totalWords;

  factory _WritingActivityStats.fromNotes(List<NoteModel> notes) {
    final dailyNoteCounts = <DateTime, int>{};
    var totalWords = 0;

    for (final note in notes) {
      final savedDate = note.lastModified;
      final date = DateTime(savedDate.year, savedDate.month, savedDate.day);
      dailyNoteCounts.update(date, (count) => count + 1, ifAbsent: () => 1);

      final plainText = note.plainText
          .replaceAll('\uFFFC', ' ')
          .trim();
      if (plainText.isNotEmpty) {
        totalWords += plainText
            .split(RegExp(r'\s+'))
            .where((word) => word.isNotEmpty)
            .length;
      }
    }

    final activeDates = dailyNoteCounts.keys.toList()..sort();
    var longestStreak = 0;
    var run = 0;
    DateTime? previousDate;
    for (final date in activeDates) {
      run = previousDate != null && date.difference(previousDate).inDays == 1
          ? run + 1
          : 1;
      if (run > longestStreak) longestStreak = run;
      previousDate = date;
    }

    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    final yesterday = todayKey.subtract(const Duration(days: 1));
    var currentDate = dailyNoteCounts.containsKey(todayKey) ? todayKey : yesterday;
    var currentStreak = 0;
    while (dailyNoteCounts.containsKey(currentDate)) {
      currentStreak++;
      currentDate = currentDate.subtract(const Duration(days: 1));
    }

    return _WritingActivityStats(
      dailyNoteCounts: dailyNoteCounts,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      totalWords: totalWords,
    );
  }
}

class _ActivityMetric extends StatelessWidget {
  const _ActivityMetric({
    required this.label,
    required this.value,
    this.unit,
  });

  final String label;
  final String value;
  final String? unit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.bodySmall?.copyWith(
            color: homeTheme.dateColor,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleLarge?.copyWith(
            color: homeTheme.previewTitleColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (unit != null)
          Text(
            unit!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: homeTheme.dateColor,
            ),
          ),
      ],
    );
  }
}

class _ActivityHeatmap extends StatelessWidget {
  const _ActivityHeatmap({required this.dailyNoteCounts});

  final Map<DateTime, int> dailyNoteCounts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final strings = S.of(context);
    final today = DateTime.now();
    final todayKey = DateTime(today.year, today.month, today.day);
    final rangeStart = todayKey.subtract(const Duration(days: 182));
    final gridStart = rangeStart.subtract(
      Duration(days: gridWeekdayIndex(rangeStart)),
    );
    final weekCount =
        (todayKey.difference(gridStart).inDays ~/ 7) + 1;
    const cellSize = 8.0;
    const cellGap = 3.0;
    final emptyColor = Color.lerp(
      homeTheme.notePreviewUnselectedGradientStartColor,
      homeTheme.notePreviewUnselectedGradientEndColor,
      0.5,
    )!;
    final dateFormat = DateFormat.yMMMd(
      Localizations.localeOf(context).toString(),
    );

    Color cellColor(DateTime date) {
      final count = dailyNoteCounts[date] ?? 0;
      final intensity = count == 0
          ? 0.0
          : count == 1
              ? 0.35
              : count == 2
                  ? 0.55
                  : count == 3
                      ? 0.75
                      : 0.95;
      return Color.lerp(emptyColor, theme.colorScheme.primary, intensity)!;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (dailyNoteCounts.isEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              strings.writingActivityEmpty,
              style: theme.textTheme.bodySmall?.copyWith(
                color: homeTheme.dateColor,
              ),
            ),
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var weekday = 0; weekday < 7; weekday++)
                Padding(
                  padding: EdgeInsets.only(
                    bottom: weekday == 6 ? 0 : cellGap,
                  ),
                  child: Row(
                    children: [
                      for (var week = 0; week < weekCount; week++)
                        Padding(
                          padding: EdgeInsets.only(
                            right: week == weekCount - 1 ? 0 : cellGap,
                          ),
                          child: Builder(
                            builder: (context) {
                              final date = gridStart.add(
                                Duration(days: week * 7 + weekday),
                              );
                              final isInRange =
                                  !date.isBefore(rangeStart) &&
                                      !date.isAfter(todayKey);
                              final count = isInRange
                                  ? dailyNoteCounts[date] ?? 0
                                  : 0;
                              return Tooltip(
                                message: dateFormat.format(date),
                                child: Container(
                                  width: cellSize,
                                  height: cellSize,
                                  decoration: BoxDecoration(
                                    color: isInRange
                                        ? cellColor(date)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                      color: isInRange
                                          ? homeTheme.notePreviewBorderColor
                                          : Colors.transparent,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Semantics(
                                    label: dateFormat.format(date),
                                    value: count.toString(),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              strings.writingActivityLess,
              style: theme.textTheme.bodySmall?.copyWith(
                color: homeTheme.dateColor,
              ),
            ),
            const SizedBox(width: 6),
            for (final intensity in [0.0, 0.35, 0.55, 0.75, 0.95]) ...[
              Container(
                width: cellSize,
                height: cellSize,
                decoration: BoxDecoration(
                  color: Color.lerp(
                    emptyColor,
                    theme.colorScheme.primary,
                    intensity,
                  ),
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(
                    color: homeTheme.notePreviewBorderColor,
                    width: 0.5,
                  ),
                ),
              ),
              const SizedBox(width: 3),
            ],
            Text(
              strings.writingActivityMore,
              style: theme.textTheme.bodySmall?.copyWith(
                color: homeTheme.dateColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  int gridWeekdayIndex(DateTime date) => date.weekday - 1;
}
