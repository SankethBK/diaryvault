part of 'font_cubit.dart';

String preferredFontFamily = "preferred_font_family";

enum FontFamily {
  roboto("Roboto"),
  ubuntu("Ubuntu"),
  lato("Lato"),
  robotoMono("Roboto Mono"),
  ibmPlexMono("IBM Plex Mono"),
  permanentMarker("Permanent Marker"),
  oswald("Oswald"),
  satisfy("Satisfy"),
  lobster("Lobster"),
  montserrat("Montserrat");

  final String text;

  const FontFamily(this.text);

  factory FontFamily.fromStringValue(String stringValue) {
    switch (stringValue) {
      case 'Roboto':
        return FontFamily.roboto;
      case 'Ubuntu':
        return FontFamily.ubuntu;
      case "Lato":
        return FontFamily.lato;
      case 'Roboto Mono':
        return FontFamily.robotoMono;
      case 'IBM Plex Mono':
        return FontFamily.ibmPlexMono;
      case 'Permanent Marker':
        return FontFamily.permanentMarker;
      case 'Oswald':
        return FontFamily.oswald;
      case "Lobster":
        return FontFamily.lobster;
      case "Montserrat":
        return FontFamily.montserrat;
      case "Satisfy":
        return FontFamily.satisfy;
      default:
        throw Exception('Invalid font family value: $stringValue');
    }
  }
}

extension FontFamilyExtension on FontFamily {
  TextTheme getGoogleFontTextTheme() {
    switch (this) {
      case FontFamily.roboto:
        return GoogleFonts.robotoTextTheme();
      case FontFamily.ubuntu:
        return GoogleFonts.ubuntuTextTheme();
      case FontFamily.lato:
        return GoogleFonts.latoTextTheme();
      case FontFamily.robotoMono:
        return GoogleFonts.robotoMonoTextTheme();
      case FontFamily.ibmPlexMono:
        return GoogleFonts.ibmPlexMonoTextTheme();
      case FontFamily.permanentMarker:
        return GoogleFonts.permanentMarkerTextTheme();
      case FontFamily.oswald:
        return GoogleFonts.oswaldTextTheme();
      case FontFamily.montserrat:
        return GoogleFonts.montserratTextTheme();
      case FontFamily.lobster:
        return GoogleFonts.lobsterTextTheme();
      case FontFamily.satisfy:
        return GoogleFonts.satisfyTextTheme();
    }
  }

  TextStyle getGoogleFontFamilyTextStyle(Color mainTextColor) {
    switch (this) {
      case FontFamily.roboto:
        return GoogleFonts.roboto(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.ubuntu:
        return GoogleFonts.ubuntu(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.lato:
        return GoogleFonts.lato(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.robotoMono:
        return GoogleFonts.robotoMono(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.ibmPlexMono:
        return GoogleFonts.ibmPlexMono(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.permanentMarker:
        return GoogleFonts.permanentMarker(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.oswald:
        return GoogleFonts.oswald(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.montserrat:
        return GoogleFonts.montserrat(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.lobster:
        return GoogleFonts.lobster(
          textStyle: TextStyle(color: mainTextColor),
        );
      case FontFamily.satisfy:
        return GoogleFonts.satisfy(
          textStyle: TextStyle(color: mainTextColor),
        );
    }
  }
}

abstract class FontState extends Equatable {
  final FontFamily currentFontFamily;

  const FontState({required this.currentFontFamily});

  @override
  List<Object> get props => [currentFontFamily];
}

class FontChanged extends FontState {
  const FontChanged({required FontFamily currentFontFamily})
      : super(currentFontFamily: currentFontFamily);
}
