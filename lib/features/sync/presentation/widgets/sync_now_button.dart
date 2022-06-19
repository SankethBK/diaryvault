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
  late AnimationController _scaleAnimationController;

  @override
  void initState() {
    _rotationAnimationController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    _scaleAnimationController = AnimationController(
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
    return BlocConsumer<NoteSyncCubit, NoteSyncState>(
      listener: (context, state) {
        if (state is NoteSyncSuccessful) {
          showToast("notes sync successful");
          _rotationAnimationController.reset();
        } else if (state is NoteSyncFailed) {
          showToast("notes sync failed");
          _rotationAnimationController.reset();
        }
      },
      builder: (contextn, state) => GestureDetector(
        onTap: () {
          final noteSyncCubit = BlocProvider.of<NoteSyncCubit>(context);
          noteSyncCubit.startNoteSync();
          if (state is NoteSyncOnGoing) {
            _rotationAnimationController.reset();
          } else {
            _rotationAnimationController.repeat();
          }
        },
        child: AnimatedSize(
          duration: const Duration(milliseconds: 100),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              border: Border.all(
                color: Colors.pink.withOpacity(0.6),
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0)
                      .animate(_rotationAnimationController),
                  child: const Icon(
                    Icons.sync,
                    color: Colors.pink,
                  ),
                ),
                (state is NoteSyncOnGoing)
                    ? Row(
                        children: const [
                          SizedBox(width: 5),
                          Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.pink,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 5),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
