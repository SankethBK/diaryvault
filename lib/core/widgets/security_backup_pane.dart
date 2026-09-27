import 'package:dairy_app/app/themes/theme_extensions/home_page_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/settings_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/network/network_info.dart';
import 'package:dairy_app/core/pages/settings_details.dart';
import 'package:dairy_app/core/widgets/dashboard_tile.dart';
import 'package:dairy_app/features/auth/core/constants.dart';
import 'package:dairy_app/features/auth/data/models/user_config_model.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encrypted_notes_repository.dart';
import 'package:dairy_app/features/notes/domain/repositories/notes_repository.dart';
import 'package:dairy_app/features/sync/data/datasources/note_sync_receipts_local_data_source_template.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SecurityBackupPane extends StatelessWidget {
  const SecurityBackupPane({super.key, required this.isActive});

  final bool isActive;

  Future<_SecurityBackupStats> _loadStats() async {
    final encryptedCount =
        await sl<IEncryptedNotesRepository>().countEncryptedNotes();
    final userConfig = sl<UserConfigCubit>().state.userConfigModel;
    final syncTarget = _syncTarget(userConfig);
    final connected = await sl<INetworkInfo>().isConnected;
    if (!connected) {
      return _SecurityBackupStats(
        encryptedCount: encryptedCount,
        isOffline: true,
        syncTarget: syncTarget,
      );
    }

    if (syncTarget == null) {
      return _SecurityBackupStats(
        encryptedCount: encryptedCount,
        isConfigured: false,
      );
    }

    final notesResult = await sl<INotesRepository>().generateNotesIndex();
    final notes = notesResult.fold(
      (failure) => throw StateError(failure.message),
      (value) => value,
    );
    final activeNotes = notes
        .where((note) => (note['deleted'] as num?)?.toInt() != 1)
        .toList();
    final receipts = await sl<INoteSyncReceiptsLocalDataSource>()
        .fetchReceipts(syncTarget.scope);
    final snapshotMarker =
        receipts[INoteSyncReceiptsLocalDataSource.snapshotMarkerId];
    final hasVerifiedSnapshot = snapshotMarker?.startsWith('confirmed') == true;
    final sizeMatch = RegExp(r'bytes:(\d+)').firstMatch(snapshotMarker ?? '');
    final backedUpCount = activeNotes.where((note) {
      final id = note['id'] as String?;
      final hash = note['hash']?.toString();
      return id != null && hash != null && receipts[id] == hash;
    }).length;

    return _SecurityBackupStats(
      encryptedCount: encryptedCount,
      totalNotes: activeNotes.length,
      backedUpCount: backedUpCount,
      lastSync: syncTarget.lastSync,
      hasVerifiedSnapshot: hasVerifiedSnapshot,
      remoteFolderSizeBytes:
          sizeMatch == null ? null : int.tryParse(sizeMatch.group(1)!),
      syncTarget: syncTarget,
    );
  }

  @override
  Widget build(BuildContext context) {
    final syncCubit = sl<NoteSyncCubit>();
    return BlocBuilder<NoteSyncCubit, NoteSyncState>(
      bloc: syncCubit,
      buildWhen: (previous, current) =>
          current is NoteSyncSuccessful || current is NoteSyncFailed,
      builder: (context, syncState) => FutureBuilder<_SecurityBackupStats>(
        key: ValueKey(isActive),
        future: _loadStats(),
        builder: (context, snapshot) {
          final theme = Theme.of(context);
          final homeTheme = theme.extension<HomePageThemeExtensions>()!;
          final strings = S.of(context);
          final stats = snapshot.data;
          final hasBackupCounts = stats != null &&
              !stats.isOffline &&
              stats.isConfigured &&
              stats.hasVerifiedSnapshot;
          final lastSyncLabel = stats == null ||
                  stats.isOffline ||
                  !stats.isConfigured ||
                  !stats.hasVerifiedSnapshot
              ? strings.securityMetricUnavailable
              : stats.lastSync == null
                  ? strings.securityNoSuccessfulSync
                  : DateFormat.MMMd(
                      Localizations.localeOf(context).toString(),
                    ).add_jm().format(stats.lastSync!);
          final statusMessage = stats == null
              ? null
              : stats.isOffline
                  ? strings.securityBackupOffline
                  : !stats.isConfigured
                      ? null
                      : syncState is NoteSyncFailed
                          ? syncState.errorMessage
                          : !stats.hasVerifiedSnapshot
                              ? strings.securityBackupUnverified
                              : null;

          return Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
            child: snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator())
                : snapshot.hasError || stats == null
                    ? Center(
                        child: Text(
                          strings.failedToFetchNote,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: homeTheme.previewBodyColor,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
                            child: Text(
                              strings.securityBackupTitle,
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: homeTheme.previewTitleColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: DashboardTile(
                                    icon: Icons.lock_outline_rounded,
                                    label: strings.securityEncryptedNotes,
                                    subtitle: stats.encryptedCount.toString(),
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: SizedBox(
                                  height: 100,
                                  child: _SyncNowTile(
                                    cubit: syncCubit,
                                    isConfigured: stats.isConfigured,
                                    syncTarget: stats.syncTarget,
                                    subtitle: !stats.isConfigured
                                        ? strings.securityBackupSetupHint
                                        : stats.syncTarget == null
                                            ? lastSyncLabel
                                            : stats.isOffline
                                                ? stats.syncTarget!
                                                    .providerName
                                                : '${stats.syncTarget!.providerName} · $lastSyncLabel',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 88,
                            width: double.infinity,
                            child: _CloudStatsTile(
                              isConfigured: stats.isConfigured,
                              backedUpValue: hasBackupCounts
                                  ? stats.backedUpCount.toString()
                                  : strings.securityMetricUnavailable,
                              pendingValue: hasBackupCounts
                                  ? (stats.totalNotes - stats.backedUpCount)
                                      .toString()
                                  : strings.securityMetricUnavailable,
                              cloudDataValue: hasBackupCounts &&
                                      stats.remoteFolderSizeBytes != null
                                  ? _formatBytes(
                                      context,
                                      stats.remoteFolderSizeBytes!,
                                    )
                                  : strings.securityMetricUnavailable,
                            ),
                          ),
                          if (statusMessage != null) ...[
                            const SizedBox(height: 8),
                            _BackupStatusMessage(
                              icon: stats.isOffline
                                  ? Icons.cloud_off_rounded
                                  : stats.isConfigured
                                      ? Icons.info_outline_rounded
                                      : Icons.cloud_outlined,
                              message: statusMessage,
                            ),
                          ],
                        ],
                      ),
          );
        },
      ),
    );
  }

  static _SyncTarget? _syncTarget(UserConfigModel? config) {
    if (config == null) return null;
    final provider = config.preferredSyncOption ??
        (config.googleDriveUserInfo?.isNotEmpty == true
            ? SyncConstants.googleDrive
            : config.dropBoxUserInfo?.isNotEmpty == true
                ? SyncConstants.dropbox
                : null);
    String? account;
    if (provider == SyncConstants.googleDrive) {
      account = config.googleDriveUserInfo;
    } else if (provider == SyncConstants.dropbox) {
      account = config.dropBoxUserInfo;
    } else if (provider == SyncConstants.nextCloud) {
      account = config.nextCloudUserInfo;
    }
    if (provider == null || account == null || account.trim().isEmpty) {
      return null;
    }
    DateTime? lastSync;
    if (provider == SyncConstants.googleDrive) {
      lastSync = config.lastGoogleDriveSync;
    } else if (provider == SyncConstants.dropbox) {
      lastSync = config.lastDropboxSync;
    } else if (provider == SyncConstants.nextCloud) {
      lastSync = config.lastNextCloudSync;
    }
    final logoAsset = provider == SyncConstants.googleDrive
        ? 'assets/images/google_drive_icon.webp'
        : provider == SyncConstants.dropbox
            ? 'assets/images/dropbox_logo.webp'
            : provider == SyncConstants.nextCloud
                ? 'assets/images/nextcloud_logo.webp'
                : null;
    final providerName = provider == SyncConstants.googleDrive
        ? S.current.googleDrive
        : provider == SyncConstants.dropbox
            ? S.current.dropbox
            : S.current.nextCloud;
    return _SyncTarget(
      scope: '$provider|${account.trim().toLowerCase()}',
      lastSync: lastSync,
      logoAsset: logoAsset,
      providerName: providerName,
    );
  }

  static String _formatBytes(BuildContext context, int bytes) {
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    var value = bytes.toDouble();
    var unitIndex = 0;
    while (value >= 1024 && unitIndex < units.length - 1) {
      value /= 1024;
      unitIndex++;
    }
    final decimals = unitIndex == 0 || value >= 10 ? 0 : 1;
    final numberFormat = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toString(),
    )
      ..minimumFractionDigits = decimals
      ..maximumFractionDigits = decimals;
    return '${numberFormat.format(value)} ${units[unitIndex]}';
  }
}

class _SyncTarget {
  const _SyncTarget({
    required this.scope,
    required this.lastSync,
    required this.logoAsset,
    required this.providerName,
  });

  final String scope;
  final DateTime? lastSync;
  final String? logoAsset;
  final String providerName;
}

class _SecurityBackupStats {
  const _SecurityBackupStats({
    required this.encryptedCount,
    this.totalNotes = 0,
    this.backedUpCount = 0,
    this.lastSync,
    this.isOffline = false,
    this.isConfigured = true,
    this.hasVerifiedSnapshot = false,
    this.remoteFolderSizeBytes,
    this.syncTarget,
  });

  final int encryptedCount;
  final int totalNotes;
  final int backedUpCount;
  final DateTime? lastSync;
  final bool isOffline;
  final bool isConfigured;
  final bool hasVerifiedSnapshot;
  final int? remoteFolderSizeBytes;
  final _SyncTarget? syncTarget;
}

BoxDecoration _tileDecoration(HomePageThemeExtensions homeTheme) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(16),
    gradient: LinearGradient(
      colors: [
        homeTheme.notePreviewUnselectedGradientStartColor,
        homeTheme.notePreviewUnselectedGradientEndColor,
      ],
      begin: AlignmentDirectional.topStart,
      end: AlignmentDirectional.bottomEnd,
    ),
    border: Border.all(color: homeTheme.notePreviewBorderColor),
  );
}

class _SyncNowTile extends StatefulWidget {
  const _SyncNowTile({
    required this.cubit,
    required this.isConfigured,
    required this.subtitle,
    this.syncTarget,
  });

  final NoteSyncCubit cubit;
  final bool isConfigured;
  final String subtitle;
  final _SyncTarget? syncTarget;

  @override
  State<_SyncNowTile> createState() => _SyncNowTileState();
}

class _SyncNowTileState extends State<_SyncNowTile>
    with TickerProviderStateMixin {
  late final AnimationController _rotationController = AnimationController(
    duration: const Duration(milliseconds: 3000),
    vsync: this,
  );

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final settingsTheme = theme.extension<SettingsPageThemeExtensions>()!;
    final strings = S.of(context);

    return BlocBuilder<NoteSyncCubit, NoteSyncState>(
      bloc: widget.cubit,
      builder: (context, state) {
        final isSyncing = state is NoteSyncOnGoing;
        if (isSyncing) {
          if (!_rotationController.isAnimating) _rotationController.repeat();
        } else if (_rotationController.isAnimating) {
          _rotationController.reset();
        }

        return Tooltip(
          message: strings.syncNow,
          child: Semantics(
            button: true,
            label: strings.syncNow,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () {
                  if (widget.isConfigured) {
                    widget.cubit.startNoteSync();
                  } else {
                    Navigator.of(context).pushNamed(
                      SettingsDetailPage.route,
                      arguments: SettingCategoriesConstants.cloudBackup,
                    );
                  }
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                  decoration: _tileDecoration(homeTheme),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 26,
                            height: 26,
                            child: Center(
                              child: RotationTransition(
                                turns: Tween(begin: 1.0, end: 0.0)
                                    .animate(_rotationController),
                                child: Icon(
                                  widget.isConfigured
                                      ? Icons.sync
                                      : Icons.cloud_upload_outlined,
                                  size: isSyncing ? 18 : 26,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          if (widget.syncTarget?.logoAsset != null)
                            Image.asset(
                              widget.syncTarget!.logoAsset!,
                              width: 22,
                              height: 22,
                              fit: BoxFit.contain,
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.isConfigured
                            ? strings.syncNow
                            : strings.securityBackupSetupTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: homeTheme.previewTitleColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (isSyncing) ...[
                        const SizedBox(height: 9),
                        LinearProgressIndicator(
                          value: state.progress,
                          minHeight: 3,
                          backgroundColor: settingsTheme.inactiveTrackColor,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            settingsTheme.activeColor ??
                                theme.colorScheme.primary,
                          ),
                        ),
                      ] else
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            widget.subtitle,
                            maxLines: 1,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: homeTheme.previewBodyColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CloudStatsTile extends StatelessWidget {
  const _CloudStatsTile({
    required this.isConfigured,
    required this.backedUpValue,
    required this.pendingValue,
    required this.cloudDataValue,
  });

  final bool isConfigured;
  final String backedUpValue;
  final String pendingValue;
  final String cloudDataValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    final strings = S.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
      decoration: _tileDecoration(homeTheme),
      child: isConfigured
          ? Row(
              children: [
                Expanded(
                  child: _StatMetric(
                    label: strings.securityBackedUpNotes,
                    value: backedUpValue,
                  ),
                ),
                Expanded(
                  child: _StatMetric(
                    label: strings.securityPendingBackup,
                    value: pendingValue,
                  ),
                ),
                Expanded(
                  child: _StatMetric(
                    label: strings.securitySyncedData,
                    value: cloudDataValue,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cloud_off_rounded,
                  size: 23,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    strings.securityStatsNotConfigured,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: homeTheme.previewTitleColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _StatMetric extends StatelessWidget {
  const _StatMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
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
      ],
    );
  }
}

class _BackupStatusMessage extends StatelessWidget {
  const _BackupStatusMessage({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final homeTheme = theme.extension<HomePageThemeExtensions>()!;
    return Row(
      children: [
        Icon(icon, size: 18, color: homeTheme.dateColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            message,
            style: theme.textTheme.bodySmall?.copyWith(
              color: homeTheme.dateColor,
            ),
          ),
        ),
      ],
    );
  }
}
