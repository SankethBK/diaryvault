part of 'notesync_cubit.dart';

abstract class NoteSyncState extends Equatable {
  const NoteSyncState();

  @override
  List<Object> get props => [];
}

class NoteSyncInitial extends NoteSyncState {}

class NoteSyncOnGoing extends NoteSyncState {
  final double progress;

  const NoteSyncOnGoing({this.progress = 0.0});

  @override
  List<Object> get props => [progress];
}

class NoteSyncFailed extends NoteSyncState {
  final String errorMessage;

  const NoteSyncFailed(this.errorMessage);
}

class NoteSyncSuccessful extends NoteSyncState {
  final Duration elapsed;

  const NoteSyncSuccessful({required this.elapsed});

  @override
  List<Object> get props => [elapsed];
}
