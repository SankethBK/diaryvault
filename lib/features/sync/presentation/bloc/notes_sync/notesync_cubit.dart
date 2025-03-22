import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/auth/presentation/bloc/user_config/user_config_cubit.dart';
import 'package:dairy_app/features/notes/presentation/bloc/notes/notes_bloc.dart';
import 'package:dairy_app/features/sync/domain/repositories/sync_repository_template.dart';
import 'package:equatable/equatable.dart';

part 'notesync_state.dart';

final log = printer("NoteSyncCubit");

class NoteSyncCubit extends Cubit<NoteSyncState> {
  final ISyncRepository syncRepository;
  final NotesBloc notesBloc;
  final UserConfigCubit userConfigCubit;
  late StreamSubscription<NotesState> noteBLocSubscription;

  NoteSyncCubit(
      {required this.syncRepository,
      required this.notesBloc,
      required this.userConfigCubit})
      : super(NoteSyncInitial()) {
    noteBLocSubscription = notesBloc.stream.listen((state) {
      if (userConfigCubit.state.userConfigModel?.isAutoSyncEnabled == true &&
          (state is NoteSavedSuccesfully || state is NoteDeletionSuccesful)) {
        startNoteSync();
      }
    });
  }

  void startNoteSync() async {
    // Don't start a new sync, if it is already going on
    if (state is NoteSyncOnGoing) {
      return;
    }
    emit(NoteSyncOnGoing());

    final startTime = DateTime.now();

    // Initialize notes sync repository
    var res = await syncRepository.initializeSyncRepository();

    // do nothing on success
    res.fold((e) async {
      log.w("Could not initialize notes sync repository");
      emit(NoteSyncFailed(e.message));

      await Future.delayed(const Duration(milliseconds: 100));
      emit(NoteSyncInitial());
    }, (_) async {
      var res2 = await syncRepository.initializeNewFolderStructure();

      res2.fold((e) async {
        log.w("App folder could not be initialized");
        emit(NoteSyncFailed(e.message));

        await Future.delayed(const Duration(milliseconds: 100));
        emit(NoteSyncInitial());
        return;
      }, (_) async {
        final duration = DateTime.now().difference(startTime).inSeconds;
        emit(NoteSyncSuccessful(duration));
        await Future.delayed(const Duration(milliseconds: 100));
        emit(NoteSyncInitial());
      });
    });
  }

  void cancelNoteSync() {}

  @override
  void onChange(Change<NoteSyncState> change) {
    super.onChange(change);
    log.i(change);
  }
}
