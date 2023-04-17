import 'package:flutter/material.dart';

class EncoreStyles {
  //PRIMARY COLORS
  static int userId = -1;
  static Color whiteColor = Colors.white;
  static Color cardColor = const Color(0xffFFFFFF);
  static Color primaryErrorColor = const Color(0xfff04438);
  static Color primaryTextColor = const Color(0xff101828);
  static Color primaryLightColor = const Color(0xffe0f2fe);
  static MaterialColor primaryColor = MaterialColor(0xff1ecb96, color);

  static Color primaryTextColorLight = const Color(0xff98a2b3);

  static TextStyle textHeading =
      const TextStyle(color: Color(0xff000000), fontSize: 26);
  static TextStyle subTextHeading =
      const TextStyle(color: Color(0xff3d3d3d), fontSize: 17);

  static TextStyle textStyle = const TextStyle(
      color: Color(0xffAFAEAE), fontSize: 20, fontWeight: FontWeight.w500);

  static TextStyle containerTitleText = const TextStyle(
      color: Color(0xff676767), fontSize: 16, fontWeight: FontWeight.w500);
  static TextStyle lgMediumStyle = TextStyle(
      color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.w500);

  static TextStyle textFieldHint = const TextStyle(
      color: Color(0xff3d3d3d), fontSize: 14, fontWeight: FontWeight.w400);

  static TextStyle normalText =
      const TextStyle(color: Color(0xff3d3d3d), fontSize: 12);
  static TextStyle buttonText =
      const TextStyle(color: Color(0xffffffff), fontSize: 18);
  static TextStyle smNormalStyle = TextStyle(
      color: primaryTextColor, fontSize: 14, fontWeight: FontWeight.w400);
  static TextStyle mdMediumStyle = TextStyle(
      color: primaryTextColor, fontSize: 16, fontWeight: FontWeight.w500);

  static Color cardBorderColor = const Color(0xff363636);
  static Border cardBorder = Border.all(color: cardBorderColor, width: 1.0);
  static Border cardBorderWithPrimaryColr =
      Border.all(color: primaryColor, width: 1.0);

  static List<BoxShadow> cardShadow = [
    BoxShadow(
      offset: const Offset(0, 0),
      blurRadius: 31,
      spreadRadius: -10,
      color: const Color(0xff000000).withOpacity(0.06),
    ),
    BoxShadow(
      offset: const Offset(0, 0),
      blurRadius: 31,
      spreadRadius: -10,
      color: const Color(0xff000000).withOpacity(0.06),
    ),
  ];

//GREY COLORS
//   static Color cardBorderColor = const Color(0xfff2f4f7);
//   static Color primaryTextColorLight = const Color(0xff98a2b3);
// // Color primaryTextColor = const Color(0xff1d2939);
//   static Color primaryTextColor = const Color(0xff101828);

// //ERROR COLORS
//   static Color lightErrorColor = const Color(0xfffee4e2);
//   static Color primaryErrorColor = const Color(0xfff04438);
//   static Color darkErrorTextColor = const Color(0xff912018);
//   static Color whiteColor = Colors.white;
//   static Color appBgColor = const Color(0xfffcfcfd);
//   static Color chatBubbleTextClr = const Color(0xff667085); // using for custom_Subscription_vu...
//   static Color cardColor = const Color(0xffFFFFFF);
//   static Color checkboxTextColor = Colors.black;
//   static Color scaffoldLBackgroundColor = const Color(0xffFCFCFD);
//   static Color scaffoldDBackgroundColor = const Color(0xff121212);

// //SUCCESS COLORS
//   static Color darkSuccessColor = const Color(0xff05603A);
//   static Color primarySuccessColor = const Color(0xff12B76A);
//   static Color lightSuccessColor = const Color(0xffD1FADF);

// //TEXT STYLES

// // BORDERS
//   static OutlineInputBorder chiOutlineBorder = OutlineInputBorder(borderSide: BorderSide(color: primaryTextColorLight));
//   static Border cardBorder = Border.all(color: cardBorderColor, width: 1.0);
//   static BorderRadius cardRadius = BorderRadius.circular(16);

// // Shadow
//   static List<BoxShadow> cardShadow = [
//     BoxShadow(
//       offset: const Offset(0, 0),
//       blurRadius: 31,
//       spreadRadius: -10,
//       color: const Color(0xff000000).withOpacity(0.06),
//     ),
//     BoxShadow(
//       offset: const Offset(0, 0),
//       blurRadius: 31,
//       spreadRadius: -10,
//       color: const Color(0xff000000).withOpacity(0.06),
//     ),
//   ];

//   static List<BoxShadow> halfCardShadow = [
//     BoxShadow(
//       offset: const Offset(0, 0),
//       color: const Color(0xff000000).withOpacity(0.06),
//       blurRadius: 31,
//       spreadRadius: 10,
//     )
//   ];
//   static TextStyle displayXsBoldStyle = TextStyle(color: primaryTextColor, fontSize: 24, fontWeight: FontWeight.w700);
//   static TextStyle displayXsSemiBoldStyle =
//       TextStyle(color: primaryTextColor, fontSize: 24, fontWeight: FontWeight.w600);
//   static TextStyle displayXsMediumStyle = TextStyle(color: primaryTextColor, fontSize: 24, fontWeight: FontWeight.w500);
//   static TextStyle displayXsNormalStyle = TextStyle(color: primaryTextColor, fontSize: 24, fontWeight: FontWeight.w400);
//   static TextStyle xlBoldStyle = TextStyle(color: primaryTextColor, fontSize: 20, fontWeight: FontWeight.w700);
//   static TextStyle xlSemiBoldStyle = TextStyle(color: primaryTextColor, fontSize: 20, fontWeight: FontWeight.w600);
//   static TextStyle xlMediumStyle = TextStyle(color: primaryTextColor, fontSize: 20, fontWeight: FontWeight.w500);
//   static TextStyle xlNormalStyle = TextStyle(color: primaryTextColor, fontSize: 20, fontWeight: FontWeight.w400);
//   static TextStyle lgBoldStyle = TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.w700);
//   static TextStyle lgSemiBoldStyle = TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.w600);
//   static TextStyle lgMediumStyle = TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.w500);
//   static TextStyle lgNormalStyle = TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.w400);
//   static TextStyle mdBoldStyle = TextStyle(color: primaryTextColor, fontSize: 16, fontWeight: FontWeight.w700);
//   static TextStyle mdSemiBoldStyle = TextStyle(color: primaryTextColor, fontSize: 16, fontWeight: FontWeight.w600);
//   static TextStyle mdMediumStyle = TextStyle(color: primaryTextColor, fontSize: 16, fontWeight: FontWeight.w500);
//   static TextStyle mdNormalStyle = TextStyle(color: primaryTextColor, fontSize: 16, fontWeight: FontWeight.w400);
//   static TextStyle smBoldStyle = TextStyle(color: primaryTextColor, fontSize: 14, fontWeight: FontWeight.w700);
//   static TextStyle smSemiBoldStyle = TextStyle(color: primaryTextColor, fontSize: 14, fontWeight: FontWeight.w600);
//   static TextStyle smMediumStyle = TextStyle(color: primaryTextColor, fontSize: 14, fontWeight: FontWeight.w500);
//   static TextStyle smNormalStyle = TextStyle(color: primaryTextColor, fontSize: 14, fontWeight: FontWeight.w400);
//   static TextStyle xsBoldStyle = TextStyle(color: primaryTextColor, fontSize: 12, fontWeight: FontWeight.w700);
//   static TextStyle xsSemiBoldStyle = TextStyle(color: primaryTextColor, fontSize: 12, fontWeight: FontWeight.w600);
//   static TextStyle xsMediumStyle = TextStyle(color: primaryTextColor, fontSize: 12, fontWeight: FontWeight.w500);
//   static TextStyle xsNormalStyle = TextStyle(color: primaryTextColor, fontSize: 12, fontWeight: FontWeight.w400);
//   static TextStyle titleTextStyle = TextStyle(color: primaryTextColor, fontSize: 20, fontWeight: FontWeight.w700);
//   static TextStyle mediumTitleStyle = TextStyle(color: primaryTextColor, fontSize: 20, fontWeight: FontWeight.w500);
//   static TextStyle titleTextTwoStyle = TextStyle(color: primaryTextColor, fontSize: 18, fontWeight: FontWeight.w500);

//   static TextStyle subTitleTextStyle =
//       TextStyle(color: primaryTextColorLight, fontSize: 16, fontWeight: FontWeight.w400);
//   static TextStyle btnTextStyle = TextStyle(color: whiteColor, fontSize: 16, fontWeight: FontWeight.w500);
//   static TextStyle mediumTextStyle = TextStyle(color: primaryTextColorLight, fontSize: 14, fontWeight: FontWeight.w400);
//   static TextStyle smallTextStyle = TextStyle(color: primaryTextColorLight, fontSize: 12, fontWeight: FontWeight.w400);
//   static TextStyle smallTwoTextStyle = TextStyle(color: primaryTextColor, fontSize: 12, fontWeight: FontWeight.w500);
//   static TextStyle prefixStyle = TextStyle(color: primaryTextColor, fontSize: 16, fontWeight: FontWeight.w400);
//   static TextStyle bluelightStyle = TextStyle(color: primaryColor, fontSize: 16, fontWeight: FontWeight.w400);
}

Map<int, Color> color = {
  50: const Color.fromRGBO(136, 14, 79, .1),
  100: const Color.fromRGBO(136, 14, 79, .2),
  200: const Color.fromRGBO(136, 14, 79, .3),
  300: const Color.fromRGBO(136, 14, 79, .4),
  400: const Color.fromRGBO(136, 14, 79, .5),
  500: const Color.fromRGBO(136, 14, 79, .6),
  600: const Color.fromRGBO(136, 14, 79, .7),
  700: const Color.fromRGBO(136, 14, 79, .8),
  800: const Color.fromRGBO(136, 14, 79, .9),
  900: const Color.fromRGBO(136, 14, 79, 1),
};
