import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/domain/repositories/key_manager.dart';
import 'package:flutter/material.dart';

/// Changes the encryption passphrase. Only the passphrase key slot is
/// re-wrapped; note content and the recovery code stay untouched.
Future<bool?> showChangePassphraseDialog(BuildContext context) async {
  final result = await showCustomDialog(
    context: context,
    child: const ChangePassphraseDialog(),
  );
  return result is bool ? result : null;
}

class ChangePassphraseDialog extends StatefulWidget {
  const ChangePassphraseDialog({Key? key}) : super(key: key);

  @override
  State<ChangePassphraseDialog> createState() => _ChangePassphraseDialogState();
}

class _ChangePassphraseDialogState extends State<ChangePassphraseDialog> {
  static const int minPassphraseLength = 8;

  final _oldController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;

  @override
  void dispose() {
    _oldController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final newPassphrase = _newController.text;
    if (newPassphrase.length < minPassphraseLength) {
      setState(() =>
          _errorText = "Passphrase must be at least $minPassphraseLength characters");
      return;
    }
    if (newPassphrase != _confirmController.text) {
      setState(() => _errorText = "New passphrases do not match");
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    final result = await sl<IKeyManager>()
        .changePassphrase(_oldController.text, newPassphrase);

    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _isLoading = false;
        _errorText = failure.code == EncryptionFailure.WRONG_PASSPHRASE
            ? "Current passphrase is incorrect"
            : failure.message;
      }),
      (_) => Navigator.of(context).pop(true),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainTextColor =
        Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Change passphrase",
            style: TextStyle(fontSize: 19.0, color: mainTextColor),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _oldController,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            autofocus: true,
            decoration: const InputDecoration(
              labelText: "Current passphrase",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _newController,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            decoration: const InputDecoration(
              labelText: "New passphrase",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _confirmController,
            obscureText: true,
            autocorrect: false,
            enableSuggestions: false,
            onSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: "Confirm new passphrase",
              errorText: _errorText,
              border: const OutlineInputBorder(),
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
                buttonText: "Change",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
