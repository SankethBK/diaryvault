part of 'locale_cubit.dart';

String preferredLanguageCode = "preferred_language_code";
String preferredCountryCode = "preferred_country_code";

abstract class LocaleState extends Equatable {
  final Locale currentLocale;

  const LocaleState({required this.currentLocale});

  @override
  List<Object> get props => [currentLocale.toLanguageTag()];
}

class LocaleChanged extends LocaleState {
  const LocaleChanged({required Locale locale}) : super(currentLocale: locale);
}
