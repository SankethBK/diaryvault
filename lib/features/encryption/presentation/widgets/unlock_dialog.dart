import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encryption_cubit.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Prompts for the encryption passphrase (or recovery code) and unlocks the
/// session. Pops with `true` on success.
Future<bool?> showUnlockDialog(BuildContext context) async {
  final result = await showCustomDialog(
    context: context,
    child: const UnlockDialog(),
  );
  return result is bool ? result : null;
}

class UnlockDialog extends StatefulWidget {
  const UnlockDialog({Key? key}) : super(key: key);

  @override
  State<UnlockDialog> createState() => _UnlockDialogState();
}

class _UnlockDialogState extends State<UnlockDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _useRecoveryCode = false;
  bool _isLoading = false;
  String? _errorText;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final input = _controller.text.trim();
    if (input.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    final cubit = BlocProvider.of<EncryptionCubit>(context);
    final failure = _useRecoveryCode
        ? await cubit.unlockWithRecovery(input)
        : await cubit.unlock(input);

    if (!mounted) return;

    if (failure == null) {
      Navigator.of(context).pop(true);
      return;
    }

    setState(() {
      _isLoading = false;
      _errorText = failure.code == EncryptionFailure.WRONG_PASSPHRASE
          ? (_useRecoveryCode
              ? "Incorrect recovery code"
              : "Incorrect passphrase")
          : failure.message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainTextColor =
        Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;
    final inputTextColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.textColor;

    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.lock_outline, size: 36, color: mainTextColor),
          const SizedBox(height: 12),
          Text(
            "Unlock encrypted notes",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 19.0, color: mainTextColor),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            style: TextStyle(color: inputTextColor),
            cursorColor: inputTextColor,
            autofocus: true,
            obscureText: !_useRecoveryCode,
            autocorrect: false,
            enableSuggestions: false,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: _useRecoveryCode ? "Recovery code" : "Passphrase",
              hintText: _useRecoveryCode ? "xxxxx-xxxxx-xxxxx-xxxxx-xxxxx" : null,
              errorText: _errorText,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _useRecoveryCode = !_useRecoveryCode;
                _errorText = null;
              });
            },
            child: Text(
              _useRecoveryCode
                  ? "Use passphrase instead"
                  : "Forgot passphrase? Use recovery code",
              style: TextStyle(
                fontSize: 13.0,
                color: mainTextColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CancelButton(
                buttonText: "Cancel",
                onPressed: () => Navigator.of(context).pop(false),
              ),
              const SizedBox(width: 10),
              SubmitButton(
                isLoading: _isLoading,
                onSubmitted: _submit,
                buttonText: "Unlock",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
