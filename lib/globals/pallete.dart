import 'package:flutter/material.dart';

class Pallete {
  //rgb(48, 44, 45)
  static const Color darkBackgroundColor = Color.fromRGBO(0, 1, 10, 1);
  //rgb(255, 252, 225)
  static const Color lightBackgroundColor = Color.fromRGBO(255, 252, 225, 1);
  static const Color whiteBackgrounColor = Colors.white;
  static const Color blackBackgroundColor = Colors.black;
  // #0369a1
  static const Color appBarColor = Color.fromRGBO(3, 105, 161, 1);
  static const Color locationColor = Color.fromRGBO(55, 138, 96, 1);
  static const Color specialsNearYouColor = Color.fromRGBO(155, 255, 226, 1);
  // rgb(122, 188, 183)
  static const Color searchBoxColor = Color.fromRGBO(117, 186, 181, 1);
  // rgb(58, 122, 102)
  static const Color searchBoxTextColor = Color.fromRGBO(58, 122, 102, 1);
  static const Color pageIndicatorColor = Color.fromRGBO(187, 254, 238, 1);
  static const Color restaurantCardGradientColor = Color.fromRGBO(2, 27, 23, 1);
  static const Color bottomNavigationBarGradientLightColor = Color.fromRGBO(16, 150, 101, 1);
  static const Color bottomNavigationBarGradientDarkColoe = Color.fromRGBO(3, 62, 36, 1);
  static const limeTextColor = Color.fromRGBO(67, 255, 165, 1);
  static const Color paragraphTextColor = Color.fromRGBO(152, 193, 188, 1);
  // rgb(254, 255, 221)
  static const Color paragraphTextColor2 = Color.fromRGBO(254, 255, 221, 1);
  // rgb(35, 52, 0)
  static const Color paragraphTextColor3 = Color.fromRGBO(35, 52, 0, 1);
  // #0369a1
  static const Color navigationButtonOff = Color.fromRGBO(3, 105, 161, 1);
  //#bae6fd
  static const Color navigationButtonOn = Color.fromRGBO(186, 230, 253, 1);
  // rgb(1, 24, 15)
  static const Color darkInformationCardColor = Color.fromRGBO(1, 24, 15, 1);
  // rgb(233, 241, 212)
  static const Color lightInformationCardColor = Color.fromRGBO(233, 241, 212, 1);
  // rgb(64, 136, 116)
  static const Color informationCardTextColor = Color.fromRGBO(64, 136, 116, 1);
  // navigationButtonOn
  static const Color informationCardTextColor2 = Color.fromRGBO(148, 255, 225, 1);
  // rgb(13, 73, 54)
  static const Color informationCardTextColor3 = Color.fromRGBO(13, 73, 54, 1);
  // rgb(28, 45, 41)
  static const Color drawerBackgroundColor = Color.fromRGBO(28, 45, 41, 0.9);
  // rgb(137, 255, 203)
  static const Color drawerSelectedButtonBackgroundColor = Color.fromRGBO(137, 255, 203, 1);
  // rgb(48, 74, 70)
  static const Color drawerButtonBackgroundColor = Color.fromRGBO(48, 74, 70, 1);
  // rgb(5, 106, 78)
  static const Color drawerTextColor = Color.fromRGBO(5, 106, 78, 1);
  // rgb(68, 192, 157)
  static const Color drawerSelectedTextColor = Color.fromRGBO(68, 192, 157, 1);

  static const Color whiteTextColor = Colors.white;
  static const Color blackTextColor = Colors.black;
  static const Color lowValueColor = Colors.green;
  // #ea580c
  static const Color moderateValueColor = Color.fromRGBO(234, 88, 12, 1);
  // #b91c1c
  static const Color highValueColor = Color.fromRGBO(185, 28, 28, 1);

  static const Color color1 = Color(0xffffffff);
  static const Color color2 = Color(0xffe1e5f2);
  static const Color color3 = Color(0xffbfdbf7);
  static const Color color4 = Color(0xff1f7a8c);
  static const Color color5 = Color(0xff022b3a);
}

// light theme

class ThemeNotifier with ChangeNotifier {
  ThemeData _themeData;
  Color _informationCardColor;
  Color _informationCardTextColor;
  Color _paragraphTextColor;

  ThemeNotifier(this._themeData, this._informationCardColor, this._informationCardTextColor, this._paragraphTextColor) {
    _informationCardColor = _informationCardColor;
    _informationCardTextColor = _informationCardTextColor;
    _paragraphTextColor = _paragraphTextColor;
  }

  getTheme() => _themeData;
  getInformationCardColor() => _informationCardColor;
  getInformationCardTextColor() => _informationCardTextColor;
  getParagraphTextColor() => _paragraphTextColor;

  setTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  setInformationCardColor(Color informationCardColor) {
    _informationCardColor = informationCardColor;
    notifyListeners();
  }

  setInformationCardTextColor(Color informationCardTextColor) {
    _informationCardTextColor = informationCardTextColor;
    notifyListeners();
  }

  setParagraphTextColor(Color paragraphTextColor) {
    _paragraphTextColor = paragraphTextColor;
    notifyListeners();
  }

  toggleTheme() {
    if (_themeData ==
        ThemeData(
          useMaterial3: true,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: Pallete.lightBackgroundColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Pallete.lightBackgroundColor,
            elevation: 0,
          ),
        )) {
      _themeData = ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Pallete.darkBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.darkBackgroundColor,
        ),
      );
      _informationCardColor = Pallete.darkInformationCardColor;
      _informationCardTextColor = Pallete.informationCardTextColor2;
      _paragraphTextColor = Pallete.paragraphTextColor2;
    } else {
      _themeData = ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Pallete.lightBackgroundColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: Pallete.lightBackgroundColor,
          elevation: 0,
        ),
      );
      _informationCardColor = Pallete.lightInformationCardColor;
      _informationCardTextColor = Pallete.informationCardTextColor3;
      _paragraphTextColor = Pallete.paragraphTextColor3;
    }
    notifyListeners();
  }
}
