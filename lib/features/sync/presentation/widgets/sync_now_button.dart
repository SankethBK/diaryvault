import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/features/sync/presentation/bloc/notes_sync/notesync_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SyncNowButton extends StatefulWidget {
  const SyncNowButton({Key? key}) : super(key: key);

  @override
  State<SyncNowButton> createState() => _SyncNowButtonState();
}

class _SyncNowButtonState extends State<SyncNowButton>
    with TickerProviderStateMixin {
  late AnimationController _rotationAnimationController;

  @override
  void initState() {
    _rotationAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteSyncCubit = BlocProvider.of<NoteSyncCubit>(context);

    return BlocBuilder<NoteSyncCubit, NoteSyncState>(
      builder: (contextn, state) {
        if (state is NoteSyncSuccessful) {
          showToast("notes sync successful");
          _rotationAnimationController.reset();
        } else if (state is NoteSyncFailed) {
          showToast("notes sync failed");
          _rotationAnimationController.reset();
        } else if (state is NoteSyncOnGoing) {
          _rotationAnimationController.repeat();
        }

        return GestureDetector(
          onTap: () {
            noteSyncCubit.startNoteSync();
          },
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(
                color: Colors.pinkAccent,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0)
                  .animate(_rotationAnimationController),
              child: const Icon(
                Icons.sync,
                color: Colors.pinkAccent,
              ),
            ),
          ),
        );
      },
    );
  }
}
