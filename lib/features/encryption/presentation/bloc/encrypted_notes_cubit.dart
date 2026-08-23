import 'dart:async';

import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encrypted_notes_repository.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encryption_session_service.dart';
import 'package:dairy_app/features/notes/data/models/notes_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

sealed class EncryptedNotesState {}

class EncryptedNotesLoading extends EncryptedNotesState {}

class EncryptedNotesLoaded extends EncryptedNotesState {
  final List<NotePreviewModel> previews;
  EncryptedNotesLoaded(this.previews);
}

/// Session locked - page should prompt for passphrase
class EncryptedNotesLocked extends EncryptedNotesState {}

class EncryptedNotesFailure extends EncryptedNotesState {
  final String message;
  EncryptedNotesFailure(this.message);
}

class EncryptedNotesCubit extends Cubit<EncryptedNotesState> {
  final IEncryptedNotesRepository encryptedNotesRepository;
  final IEncryptionSessionService sessionService;
  late final StreamSubscription _sessionSubscription;

  EncryptedNotesCubit({
    required this.encryptedNotesRepository,
    required this.sessionService,
  }) : super(sessionService.isUnlocked
            ? EncryptedNotesLoading()
            : EncryptedNotesLocked()) {
    _sessionSubscription = sessionService.state.listen((state) {
      if (state is EncryptionLocked) {
        emit(EncryptedNotesLocked());
      }
    });
  }

  Future<void> fetchNotes() async {
    if (!sessionService.isUnlocked) {
      emit(EncryptedNotesLocked());
      return;
    }
    emit(EncryptedNotesLoading());
    final result = await encryptedNotesRepository.fetchEncryptedNotePreviews();
    result.fold(
      (failure) => emit(EncryptedNotesFailure(failure.message)),
      (previews) => emit(EncryptedNotesLoaded(previews)),
    );
  }

  Future<void> deleteNote(String id) async {
    await encryptedNotesRepository.deleteEncryptedNotes([id]);
    await fetchNotes();
  }

  /// Unlocks a note protected by a different passphrase (its keychain is
  /// opened session-wide). Returns null on success, or the failure.
  Future<EncryptionFailure?> unlockNote(String id, String passphrase) async {
    final result = await encryptedNotesRepository.unlockNote(id, passphrase);
    return result.fold((failure) => failure, (_) => null);
  }

  @override
  Future<void> close() {
    _sessionSubscription.cancel();
    return super.close();
  }
}
