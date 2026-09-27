import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/core/widgets/security_backup_pane.dart';
import 'package:dairy_app/core/widgets/today_dashboard_pane.dart';
import 'package:dairy_app/core/widgets/writing_activity_pane.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';

/// Swipeable dashboard panes shown above the notes feed.
class DashboardPaneCarousel extends StatefulWidget {
  const DashboardPaneCarousel({super.key});

  @override
  State<DashboardPaneCarousel> createState() => _DashboardPaneCarouselState();
}

class _DashboardPaneCarouselState extends State<DashboardPaneCarousel> {
  static const _paneHeight = 292.0;
  static const _paneCount = 3;

  final PageController _pageController = PageController();

  void _goToPane(int paneIndex) {
    final current =
        _pageController.page?.round() ?? _pageController.initialPage;
    final base = current - (current % _paneCount) + paneIndex;
    var nearest = base;
    for (final candidate in [base - _paneCount, base + _paneCount]) {
      if ((candidate - current).abs() < (nearest - current).abs()) {
        nearest = candidate;
      }
    }
    _pageController.animateToPage(
      nearest,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }
  int _selectedPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final strings = S.of(context);
    final pageNames = [
      strings.dashboardToday,
      strings.writingActivity,
      strings.securityBackupTitle,
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: _paneHeight,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (page) =>
                setState(() => _selectedPage = page % _paneCount),
            itemBuilder: (context, index) {
              switch (index % _paneCount) {
                case 0:
                  return const TodayDashboardPane();
                case 1:
                  return const WritingActivityPane();
                default:
                  return SecurityBackupPane(isActive: _selectedPage == 2);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 4, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(pageNames.length, (index) {
              final isSelected = index == _selectedPage;
              return Semantics(
                button: true,
                selected: isSelected,
                label: pageNames[index],
                child: Tooltip(
                  message: pageNames[index],
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () => _goToPane(index),
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        width: isSelected ? 18 : 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : homeTheme.dateColor.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
