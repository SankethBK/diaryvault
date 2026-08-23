import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/core/dependency_injection/injection_container.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/cancel_button.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/domain/repositories/encrypted_notes_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Verifies the passphrase, rotates the recovery code and shows the new one.
/// The old recovery code stops working immediately.
Future<bool?> showRegenerateRecoveryDialog(BuildContext context) async {
  final result = await showCustomDialog(
    context: context,
    child: const RegenerateRecoveryDialog(),
  );
  return result is bool ? result : null;
}

class RegenerateRecoveryDialog extends StatefulWidget {
  const RegenerateRecoveryDialog({Key? key}) : super(key: key);

  @override
  State<RegenerateRecoveryDialog> createState() =>
      _RegenerateRecoveryDialogState();
}

class _RegenerateRecoveryDialogState extends State<RegenerateRecoveryDialog> {
  final _passphraseController = TextEditingController();
  bool _isLoading = false;
  String? _errorText;
  String? _newCode;
  bool _confirmed = false;

  @override
  void dispose() {
    _passphraseController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    final result = await sl<IEncryptedNotesRepository>()
        .regenerateRecoveryCode(_passphraseController.text);

    if (!mounted) return;

    result.fold(
      (failure) => setState(() {
        _isLoading = false;
        _errorText = failure.code == EncryptionFailure.WRONG_PASSPHRASE
            ? "Incorrect passphrase"
            : failure.message;
      }),
      (code) => setState(() {
        _isLoading = false;
        _newCode = code;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mainTextColor =
        Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

    return Container(
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: _newCode == null
          ? _buildPassphraseStep(mainTextColor)
          : _buildCodeStep(mainTextColor),
    );
  }

  Widget _buildPassphraseStep(Color mainTextColor) {
    final inputTextColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.textColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Regenerate recovery code",
          style: TextStyle(fontSize: 19.0, color: mainTextColor),
        ),
        const SizedBox(height: 8),
        Text(
          "This invalidates your old recovery code. Enter your passphrase to continue.",
          style: TextStyle(fontSize: 13.0, color: mainTextColor),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: _passphraseController,
          style: TextStyle(color: inputTextColor),
          cursorColor: inputTextColor,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: true,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: "Passphrase",
            labelStyle: TextStyle(color: inputTextColor),
            floatingLabelStyle: TextStyle(color: inputTextColor),
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
              buttonText: "Regenerate",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCodeStep(Color mainTextColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New recovery code",
          style: TextStyle(fontSize: 19.0, color: mainTextColor),
        ),
        const SizedBox(height: 8),
        Text(
          "Write it down and keep it safe. It will not be shown again.",
          style: TextStyle(fontSize: 13.0, color: mainTextColor),
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: mainTextColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: SelectableText(
                  _newCode!,
                  style: TextStyle(
                    fontSize: 16.0,
                    fontFamily: "monospace",
                    color: mainTextColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.copy, color: mainTextColor),
                tooltip: "Copy",
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _newCode!));
                  showToast("Recovery code copied");
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Checkbox(
              value: _confirmed,
              onChanged: (val) => setState(() => _confirmed = val ?? false),
            ),
            Flexible(
              child: Text(
                "I have written down the new code",
                style: TextStyle(fontSize: 13.0, color: mainTextColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: SubmitButton(
            isLoading: false,
            onSubmitted: () {
              if (!_confirmed) return;
              Navigator.of(context).pop(true);
            },
            buttonText: "Done",
          ),
        ),
      ],
    );
  }
}
