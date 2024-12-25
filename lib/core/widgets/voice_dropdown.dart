import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import 'package:dairy_app/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../features/auth/core/constants.dart';
import '../../features/auth/presentation/bloc/locale/locale_cubit.dart';
import '../../features/auth/presentation/bloc/user_config/user_config_cubit.dart';

class VoiceDropdown extends StatefulWidget {
  const VoiceDropdown({Key? key}) : super(key: key);

  @override
  State<VoiceDropdown> createState() => _VoiceDropdownState();
}

class _VoiceDropdownState extends State<VoiceDropdown> {
  final FlutterTts _flutterTts = FlutterTts();
  List<Map>? _voices;
  Map? selectedVoice;
  final bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      _initTts();
      // _isInitialized = true;
    }
  }

  void _initTts() {
    final userConfigCubit = context.read<UserConfigCubit>();
    final currentSelectedVoice =
        userConfigCubit.state.userConfigModel?.prefKeyVoice;

    final localeCubit = context.watch<LocaleCubit>().state;

    _flutterTts.getVoices.then((data) {
      List<Map> voices = List<Map>.from(data);

      voices = voices
          .where((voice) =>
              voice["name"].contains(localeCubit.currentLocale.toString()))
          .toList();

      setState(() {
        _voices = voices;

        selectedVoice = voices.firstWhere(
          (voice) => voice['name'] == currentSelectedVoice?['name'],
          orElse: () => voices.isNotEmpty
              ? voices.first
              : {'name': 'Default', 'locale': 'en-US'},
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return Row(
      children: [
        Text(
          S.current.selectVoice,
          style: TextStyle(
            fontSize: 16.0,
            color: mainTextColor,
          ),
        ),
        const Spacer(),
        PopupMenuButton<Map>(
          padding: const EdgeInsets.only(bottom: 0.0),
          onSelected: (value) async {
            setState(() {
              selectedVoice = value;
            });

            userConfigCubit.setUserConfig(
                UserConfigConstants.prefKeyVoice, selectedVoice);
          },
          itemBuilder: (context) =>
              _voices?.map((voice) {
                return PopupMenuItem<Map>(
                  value: voice,
                  child: Text(
                    voice['name'],
                    style: TextStyle(color: mainTextColor),
                  ),
                );
              }).toList() ??
              [],
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                selectedVoice?['name'] ?? 'Default',
                style: TextStyle(
                  color: mainTextColor,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                Icons.keyboard_arrow_down,
                color: mainTextColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
