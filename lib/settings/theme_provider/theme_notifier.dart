import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/config/utils/constants.dart';
import 'package:news_app/config/utils/sp_utils.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeNotifier extends StateNotifier<ThemeState> {
  ThemeNotifier()
      : super(ThemeState(
          isSwitchOn: false,
          selectedTheme: Constants.lightTheme,
        ));

  void toggleSwitch(bool isEnable) {
    SharedPref.setDarkTheme(isEnable);

    if (isEnable) {
      state = ThemeState(isSwitchOn: true, selectedTheme: Constants.darkTheme);
    } else {
      state =
          ThemeState(isSwitchOn: false, selectedTheme: Constants.lightTheme);
    }
  }

  Future<void> getThemeValueFromSharedPref() async {
    bool? storedThemeValue = await SharedPref.getDarkTheme();

    if (storedThemeValue == true) {
      state = ThemeState(isSwitchOn: true, selectedTheme: Constants.darkTheme);
    } else {
      state =
          ThemeState(isSwitchOn: false, selectedTheme: Constants.lightTheme);
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeState>((ref) {
  return ThemeNotifier();
});
