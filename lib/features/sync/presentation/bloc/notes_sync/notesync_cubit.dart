import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/sync/domain/repositories/oauth_repository_template.dart';
import 'package:equatable/equatable.dart';

part 'notesync_state.dart';

final log = printer("NoteSyncCubit");

class NoteSyncCubit extends Cubit<NoteSyncState> {
  final IOAuthRepository oAuthRepository;

  NoteSyncCubit({required this.oAuthRepository}) : super(NoteSyncInitial());

  void startNoteSync() async {
    emit(NoteSyncOnGoing());

    // Initialize notes sync repository
    bool isNotesSyncRepoInitialized =
        await oAuthRepository.initializeOAuthRepository();
    if (!isNotesSyncRepoInitialized) {
      log.w("Could not initialize notes sync repository");
      emit(NoteSyncFailed());
      return;
    }

    bool isAppFolderInitialized =
        await oAuthRepository.initializeNewFolderStructure();
    if (!isAppFolderInitialized) {
      log.w("App folder could not be initialized");
      emit(NoteSyncFailed());
      return;
    }

    emit(NoteSyncSuccessful());
  }

  void cancelNoteSync() {}

  @override
  void onChange(Change<NoteSyncState> change) {
    super.onChange(change);
    log.i(change);
  }
}
