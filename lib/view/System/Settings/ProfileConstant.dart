import 'package:flutter/material.dart';
import 'package:insergemobileapplication/model/user_model.dart';

// Diapositivos como Tables:
extension ContextExtension on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.shortestSide > 600;
}

class ThemesConstants {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade900,
    shadowColor: Colors.black.withOpacity(0.5),
    colorScheme: const ColorScheme.dark(
      primary: Colors.orange,
      secondary: Colors.blue,
      onError: Colors.redAccent,
    ),
    primaryColor: Colors.blueAccent,
    appBarTheme:
        const AppBarTheme(color: Colors.white, foregroundColor: Colors.white),
    focusColor: Colors.orange,
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade100,
    shadowColor: Colors.grey.withOpacity(0.5),
    colorScheme: const ColorScheme.light(
      primary: Colors.orange,
      secondary: Colors.blueAccent,
      onError: Colors.redAccent,
    ),
    canvasColor: Colors.white,
    appBarTheme:
        const AppBarTheme(color: Colors.black, foregroundColor: Colors.black),
    cardColor: Colors.white,
    primaryColor: Colors.blueAccent,
    focusColor: Colors.orange,
  );
}

//Propiedades
const OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
  borderSide: BorderSide.none,
);

//Propiedades de Widgets predeterminadas
BoxDecoration defaultBoxDecoration(Color colorBackground, Color shadowColor) {
  return BoxDecoration(
    color: colorBackground,
    borderRadius: BorderRadius.circular(defaultBorderRadius),
    boxShadow: defaultBoxShadow(shadowColor),
  );
}

List<BoxShadow> defaultBoxShadow(Color shadowColor) {
  return [
    BoxShadow(
      color: shadowColor,
      spreadRadius: 0,
      blurRadius: 1,
      offset: Offset(
        0,
        0,
      ), // changes position of shadow
    )
  ];
}

UserModel UsuarioGlobal = UserModel();

//Variables
const Color primaryHColor = Colors.indigo;
const Color primaryColor = Colors.blueAccent;
const Color secondColor = Colors.orange;
const Color bgColor = Colors.white;

const double defaultLargePadding = 20.0;
const double defaultPadding = 16.0;
const double defaultShortPadding = 8.0;
const double defaultMiniPadding = 4.0;
const double defaultBorderRadius = 12.0;
const double defaultCirculeBorderRadius = 25;
