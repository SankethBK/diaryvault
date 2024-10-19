import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:dairy_app/app/themes/theme_extensions/note_create_page_theme_extensions.dart';
import '../../features/auth/presentation/bloc/user_config/user_config_cubit.dart';

class VoiceDropDown extends StatefulWidget {
  const VoiceDropDown({Key? key}) : super(key: key);

  @override
  State<VoiceDropDown> createState() => _VoiceDropDownState();
}

class _VoiceDropDownState extends State<VoiceDropDown> {
  FlutterTts _flutterTts = FlutterTts();
  List<Map>? _voices;
  Map? _selectedVoice;

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() {
    final userConfigCubit = context.read<UserConfigCubit>(); // Access Cubit
    final currentSelectedVoice = userConfigCubit.state.selectedVoice; // Get current voice

    _flutterTts.getVoices.then((data) {
      try {
        List<Map> voices = List<Map>.from(data);
        voices = voices.where((voice) => voice["name"].contains("en")).toList();
        setState(() {
          _voices = voices;
          // Set _selectedVoice based on currentSelectedVoice
          _selectedVoice = voices.firstWhere(
                (voice) => voice['name'] == currentSelectedVoice?['name'],
            orElse: () => voices.isNotEmpty ? voices.first : {'name': 'Default', 'locale': 'en-US'},
          );
        });
      } catch (e) {
        // Handle error
      }
    });
  }
  //void setVoice ()

  @override
  Widget build(BuildContext context) {
    final userConfigCubit = BlocProvider.of<UserConfigCubit>(context);
    final mainTextColor = Theme.of(context)
        .extension<NoteCreatePageThemeExtensions>()!
        .mainTextColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Select Voice',
              style: TextStyle(
                fontSize: 16.0,
                color: mainTextColor,
              ),
            ),
          ),
          DropdownButton<Map>(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            value: _selectedVoice,
            hint: Text(
              'Default',
              style: TextStyle(color: mainTextColor),
            ),
            items: _voices?.map((voice) {
              return DropdownMenuItem<Map>(
                value: voice,
                child: Text(
                  voice['name'],
                  style: TextStyle(color: mainTextColor),
                ),
              );
            }).toList(),
            onChanged: (value) async {
              setState(() {
                _selectedVoice = value;
              });
              if (value != null) {
                // Ensure to extract the necessary fields before saving
                final voiceToSave = {
                  'name': value['name'],
                  'locale': value['locale'],
                };
                userConfigCubit.setVoice(voiceToSave); // Save to UserConfigCubit
              }
            },
          ),
        ],
      ),
    );
  }
}
