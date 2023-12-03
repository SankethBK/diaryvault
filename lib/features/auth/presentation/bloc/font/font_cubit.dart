import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'font_state.dart';

class FontCubit extends Cubit<FontState> {
  final IKeyValueDataSource keyValueDataSource;

  final log = printer("LocaleCubit");

  FontCubit({required this.keyValueDataSource})
      : super(const FontChanged(currentFontFamily: FontFamily.roboto)) {
    // Default font family is roboto in Android
    var fontFamily = FontFamily.roboto;
    final storedFontFamily = keyValueDataSource.getValue(preferredFontFamily);

    if (storedFontFamily != null) {
      fontFamily = FontFamily.fromStringValue(storedFontFamily);
    }

    log.i("preferred font family: ${fontFamily.text}");

    emit(FontChanged(currentFontFamily: fontFamily));
  }

  setFontFamily(FontFamily fontFamily) async {
    log.i("setting font family = ${fontFamily.text}");

    await keyValueDataSource.setValue(preferredFontFamily, fontFamily.text);

    emit(FontChanged(currentFontFamily: fontFamily));
  }
}
