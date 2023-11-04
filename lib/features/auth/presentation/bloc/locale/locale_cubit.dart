import 'package:bloc/bloc.dart';
import 'package:dairy_app/core/logger/logger.dart';
import 'package:dairy_app/features/sync/data/datasources/temeplates/key_value_data_source_template.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final IKeyValueDataSource keyValueDataSource;

  final log = printer("LocaleCubit");

  LocaleCubit({required this.keyValueDataSource})
      : super(const LocaleChanged(locale: Locale('en'))) {
    var preferredLocale = const Locale('en');
    final languageCode = keyValueDataSource.getValue(preferredLanguageCode);

    final countryCode = keyValueDataSource.getValue(preferredCountryCode);

    log.i("preferred language code: $languageCode");

    if (languageCode != null) {
      preferredLocale = Locale(languageCode, countryCode);
    }

    log.i("preferred locale = ${preferredLocale.toLanguageTag()}");
    emit(LocaleChanged(locale: preferredLocale));
  }

  setLocale(Locale locale) async {
    log.i("setting locale = ${locale.toLanguageTag()}");

    await keyValueDataSource.setValue(
        preferredLanguageCode, locale.languageCode);

    final countryCode = locale.countryCode;

    if (countryCode != null) {
      await keyValueDataSource.setValue(preferredCountryCode, countryCode);
    }

    emit(LocaleChanged(locale: locale));
  }
}
