import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/* 
This provider is responsible for maintaining the theme of the app, switching it and notifying the listeners.
 */
class ThemeProvider extends ChangeNotifier {
  Brightness _brightness = Brightness.dark;
  Brightness get brightness => _brightness;
  void switchTheme() {
    if (_brightness == Brightness.light) {
      _brightness = Brightness.dark;
    } else {
      _brightness = Brightness.light;
    }
    notifyListeners();
  }
}

ThemeData themeData(Brightness brightness) {
  ThemeData theme = ThemeData(
    highlightColor: Colors.transparent,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: brightness == Brightness.dark ? Colors.blueGrey : Colors.teal,
      brightness: brightness,
    ),
    useMaterial3: true,
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
      shape: MaterialStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    )),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    sliderTheme: SliderThemeData(
      overlayShape: SliderComponentShape.noOverlay,
      trackHeight: 40,
      inactiveTrackColor: Colors.black,
      trackShape: const RectangularSliderTrackShape(),
      thumbShape: SliderComponentShape.noThumb,
    ),
    brightness: brightness,
    fontFamily: GoogleFonts.poppins().fontFamily,
  );
  theme = theme.copyWith(
    sliderTheme: theme.sliderTheme
        .copyWith(inactiveTrackColor: theme.colorScheme.background),
  );
  return theme;
}
