import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

abstract class ThemeText {
  static const TextStyle captionBoldEight = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 8,
      height: 1,
      fontWeight: FontWeight.w700);

  static const TextStyle captionBoldTen = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 10,
      height: 1,
      fontWeight: FontWeight.w700);

  static const TextStyle captionRegularEleven = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 11,
      height: 1,
      fontWeight: FontWeight.w400);

  static const TextStyle regularTwelve = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 12,
      height: 1,
      fontWeight: FontWeight.w400);

  static const TextStyle regularTwelveBold = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 12,
      height: 1,
      fontWeight: FontWeight.w700);

  static const TextStyle regularFifteen = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 15,
      height: 1,
      fontWeight: FontWeight.w400);

  static const TextStyle eighteenBold = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 18,
      height: 1,
      fontWeight: FontWeight.w700);

  static const TextStyle twentyBold = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 20,
      height: 1,
      fontWeight: FontWeight.w700);

  static const TextStyle twentyEightBold = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 28,
      height: 1,
      fontWeight: FontWeight.w700);

  static const TextStyle fortyEightBold = TextStyle(
      fontFamily: 'Neue Haas',
      color: Colors.white,
      fontSize: 48,
      height: 1,
      fontWeight: FontWeight.w700);
}

//
// Example of use:
// textTheme: const textTheme(
//  headline: ThemeText.fortyEightBold,
//  bodyText: ThemeText.regularFifteen,
// ),
//

abstract class ThemeColors {
  //Background colors (website and buttons)
  static final colorBlack = HexColor("#000000");
  static final colorDarkGrey = HexColor("#282828");
  static final colorWhite = HexColor("#FFFFFF");
  static final colorLightGrey = HexColor("#AEB5C7");
  static final colorYellowBrand = HexColor("#FFED3D");

  //Button Primary
  static final colorYellowButtonBackground = colorYellowBrand;
  static final colorYellowButtonHover = HexColor("#FFFE54");
  static final colorYellowButtonPressed = HexColor("#DFB10E");
  static final colorYellowButtonBorder = HexColor("#222222"); //3px solid

  //Button Secondary - border is 1px solid
  static final colorBlackButtonBackground = Color.fromRGBO(0, 0, 0, 0.5);
  static final colorBlackButtonBorderNormal = HexColor("#B3B3B3");
  static final colorBlackButtonBorderHover = HexColor("#FFFFFF");
  static final colorBlackButtonBorderPressed = HexColor("#535353");
  static final colorBlackButtonBorderFocus =
      colorYellowBrand; //box-shadow color

  //Button text colors
  static final colorYellowButtonTextNormal = colorBlack;
  static final colorBlackButtonTextNormal = colorWhite;
  static final colorBlackButtonTextActive = colorYellowBrand;
}
