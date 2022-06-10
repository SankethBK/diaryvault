part of 'notesync_cubit.dart';

abstract class NoteSyncState extends Equatable {
  const NoteSyncState();

  @override
  List<Object> get props => [];
}

class NoteSyncInitial extends NoteSyncState {}

class NoteSyncOnGoing extends NoteSyncState {}

class NoteSyncFailed extends NoteSyncState {}

class NoteSyncSuccessful extends NoteSyncState {}
