part of 'notesync_cubit.dart';

abstract class NoteSyncState extends Equatable {
  const NoteSyncState();

  @override
  List<Object> get props => [];
}

class NoteSyncInitial extends NoteSyncState {}

class NoteSyncOnGoing extends NoteSyncState {}

class NoteSyncFailed extends NoteSyncState {
  final String errorMessage;

  const NoteSyncFailed(this.errorMessage);
}

class NoteSyncSuccessful extends NoteSyncState {
  final int durationInSeconds;

  const NoteSyncSuccessful(this.durationInSeconds);

  @override
  List<Object> get props => [durationInSeconds];
}
