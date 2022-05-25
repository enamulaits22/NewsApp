import 'package:bloc/bloc.dart';
import 'package:news_app/config/utils/constants.dart';
import 'package:news_app/config/utils/sp_utils.dart';
import 'package:flutter/material.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(isSwitchOn: false, selectedTheme: Constants.lightTheme));

  void toggleSwitch(bool isEnable) {
    SharedPref.setDarkTheme(isEnable);

    if (isEnable) {
      emit(ThemeState(isSwitchOn: true, selectedTheme: Constants.darkTheme));
    } else {
      emit(ThemeState(isSwitchOn: false, selectedTheme: Constants.lightTheme));
    }
  }

  Future<void> getThemeValueFromSharedPref () async {
    bool? storedThemeValue = await SharedPref.getDarkTheme();
    
    if (storedThemeValue == true) {
      emit(ThemeState(isSwitchOn: true, selectedTheme: Constants.darkTheme));
    } else {
      emit(ThemeState(isSwitchOn: false, selectedTheme: Constants.lightTheme));
    }
  }
}