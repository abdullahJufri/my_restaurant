import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final Color primaryColor = Color(0xFFFFFFFF);
final Color secondaryColor = Color(0xFF6B38FB);
const Color kWhiteColor = Color(0xffFFFFFF);
const Color kGrad = Color(0xffE2E5FB);
const Color kGreyColor = Color(0xffBABFC9);
const Color kLightGreyColor = Color(0xff696D74);
const Color kBlueColor = Color(0xfffd7020);
const Color kBlackPrimary = Color(0xff1B1E25);
const Color kBlackSecondary = Color(0xff252932);
const Color kYellowColor = Color(0xffFFA235);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.merriweather(
      fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.merriweather(
      fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3:
      GoogleFonts.merriweather(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.merriweather(
      fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5:
      GoogleFonts.merriweather(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.merriweather(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.merriweather(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.merriweather(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.libreFranklin(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.libreFranklin(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.libreFranklin(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.libreFranklin(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

TextStyle whiteTextStyle = GoogleFonts.nunito(
  color: kWhiteColor,
);

TextStyle greyTextStyle = GoogleFonts.nunito(
  color: kGreyColor,
);

TextStyle blackTextStyle = GoogleFonts.nunito(
  color: kBlackPrimary,
);

TextStyle blueTextSyle = GoogleFonts.nunito(
  color: kBlueColor,
);

TextStyle lightGreyTextStyle = GoogleFonts.nunito(
  color: kLightGreyColor,
);

TextStyle yellowTextStyle = GoogleFonts.nunito(
  color: kYellowColor,
);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight bold = FontWeight.bold;

ThemeData lightTheme = ThemeData(
  primaryColor: kBlueColor,
  scaffoldBackgroundColor: kWhiteColor,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    titleTextStyle: blackTextStyle.copyWith(fontWeight: bold),
    elevation: 1,
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
