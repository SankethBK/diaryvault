import 'package:dairy_app/app/themes/theme_extensions/popup_theme_extensions.dart';
import 'package:dairy_app/app/themes/theme_extensions/auth_page_theme_extensions.dart';
import 'package:dairy_app/core/utils/utils.dart';
import 'package:dairy_app/core/widgets/glass_dialog.dart';
import 'package:dairy_app/core/widgets/submit_button.dart';
import 'package:dairy_app/features/encryption/core/failures/encryption_failure.dart';
import 'package:dairy_app/features/encryption/presentation/bloc/encryption_cubit.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// First-time encryption onboarding: explainer -> set passphrase -> show
/// recovery code. Both confirmation checkboxes are required; pops with
/// `true` only when setup fully completes.
Future<bool?> showEncryptionSetupDialog(BuildContext context) async {
  final result = await showCustomDialog(
    context: context,
    child: const EncryptionSetupDialog(),
  );
  return result is bool ? result : null;
}

class EncryptionSetupDialog extends StatefulWidget {
  const EncryptionSetupDialog({Key? key}) : super(key: key);

  @override
  State<EncryptionSetupDialog> createState() => _EncryptionSetupDialogState();
}

class _EncryptionSetupDialogState extends State<EncryptionSetupDialog> {
  static const int minPassphraseLength = 8;

  int _step = 0;
  bool _isLoading = false;
  String? _errorText;
  bool _lossRiskConfirmed = false;
  bool _recoveryConfirmed = false;

  final _passphraseController = TextEditingController();
  final _confirmController = TextEditingController();
  String? _recoveryCode;

  @override
  void dispose() {
    _passphraseController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submitPassphrase() async {
    final passphrase = _passphraseController.text;
    if (passphrase.length < minPassphraseLength) {
      setState(() => _errorText =
          S.current.passphraseMinLength(minPassphraseLength));
      return;
    }
    if (passphrase != _confirmController.text) {
      setState(() => _errorText = S.current.passphrasesDoNotMatch);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    final cubit = BlocProvider.of<EncryptionCubit>(context);
    final result = await cubit.enable(passphrase);

    if (!mounted) return;

    if (result is EncryptionFailure) {
      setState(() {
        _isLoading = false;
        _errorText = result.message;
      });
      return;
    }

    setState(() {
      _isLoading = false;
      _recoveryCode = result as String;
      _step = 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mainTextColor =
        Theme.of(context).extension<PopupThemeExtensions>()!.mainTextColor;

    return Container(
      width: 320,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: switch (_step) {
        0 => _buildExplainer(mainTextColor),
        1 => _buildPassphraseForm(mainTextColor),
        _ => _buildRecoveryCode(mainTextColor),
      },
    );
  }

  Widget _buildExplainer(Color mainTextColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.enhanced_encryption, color: mainTextColor),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                S.current.encryptYourNotesTitle,
                style: TextStyle(fontSize: 19.0, color: mainTextColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(
          S.current.encryptYourNotesDescription,
          style: TextStyle(fontSize: 14.0, color: mainTextColor),
        ),
        const SizedBox(height: 12),
        Text(
          S.current.encryptionLossWarning,
          style: TextStyle(
              fontSize: 14.0,
              color: mainTextColor,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Text(
          S.current.encryptionSeparateViewDescription,
          style: TextStyle(fontSize: 13.0, color: mainTextColor),
        ),
        const SizedBox(height: 18),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(S.current.notNow, style: TextStyle(color: mainTextColor)),
            ),
            const SizedBox(width: 8),
            SubmitButton(
              isLoading: false,
              onSubmitted: () => setState(() => _step = 1),
              buttonText: S.current.continueButton,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPassphraseForm(Color mainTextColor) {
    final inputTextColor =
        Theme.of(context).extension<AuthPageThemeExtensions>()!.textColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.choosePassphraseTitle,
          style: TextStyle(fontSize: 19.0, color: mainTextColor),
        ),
        const SizedBox(height: 6),
        Text(
          S.current.choosePassphraseHint,
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
          decoration: InputDecoration(
            labelText: S.current.passphraseLabel,
            labelStyle: TextStyle(color: inputTextColor),
            floatingLabelStyle: TextStyle(color: inputTextColor),
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _confirmController,
          style: TextStyle(color: inputTextColor),
          cursorColor: inputTextColor,
          obscureText: true,
          autocorrect: false,
          enableSuggestions: false,
          onSubmitted: (_) => _trySubmit(),
          decoration: InputDecoration(
            labelText: S.current.confirmPassphraseLabel,
            labelStyle: TextStyle(color: inputTextColor),
            floatingLabelStyle: TextStyle(color: inputTextColor),
            errorText: _errorText,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _lossRiskConfirmed,
              onChanged: (val) =>
                  setState(() => _lossRiskConfirmed = val ?? false),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  S.current.encryptionLossAcknowledgement,
                  style: TextStyle(fontSize: 13.0, color: mainTextColor),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => setState(() {
                _step = 0;
                _errorText = null;
              }),
              child: Text(S.current.backAction, style: TextStyle(color: mainTextColor)),
            ),
            const SizedBox(width: 8),
            SubmitButton(
              isLoading: _isLoading,
              onSubmitted: _trySubmit,
              buttonText: S.current.setPassphrase,
            ),
          ],
        ),
      ],
    );
  }

  void _trySubmit() {
    if (!_lossRiskConfirmed) return;
    _submitPassphrase();
  }

  Widget _buildRecoveryCode(Color mainTextColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.current.yourRecoveryCodeTitle,
          style: TextStyle(fontSize: 19.0, color: mainTextColor),
        ),
        const SizedBox(height: 8),
        Text(
          S.current.recoveryCodeDescription,
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
                  _recoveryCode ?? "",
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
                tooltip: S.current.copyButtonTooltip,
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _recoveryCode ?? ""));
                  showToast(S.current.recoveryCodeCopiedToast, context: context);
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              value: _recoveryConfirmed,
              onChanged: (val) =>
                  setState(() => _recoveryConfirmed = val ?? false),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  S.current.recoveryCodeAcknowledgement,
                  style: TextStyle(fontSize: 13.0, color: mainTextColor),
                ),
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
              if (!_recoveryConfirmed) return;
              Navigator.of(context).pop(true);
            },
            buttonText: S.current.done,
          ),
        ),
      ],
    );
  }
}
