import 'package:flutter/material.dart';

class CustomColors {
  static const Color whWhite = Color(0xFFFEFEFE);
  static const Color whBalck = Color(0xFF040404);

  static const Color whGrey100 = Color(0xFF111111);
  static const Color whGrey200 = Color(0xFF2B2B2B);
  static const Color whGrey300 = Color(0xFF404040);
  static const Color whGrey400 = Color(0xFF555555);
  static const Color whGrey500 = Color(0xFF777777);
  static const Color whGrey600 = Color(0xFFA2A2A2);
  static const Color whGrey700 = Color(0xFFC2C2C2);
  static const Color whGrey800 = Color(0xFFE2E2E2);
  static const Color whGrey900 = Color(0xFFF2F2F2);

  static const Color whRed300 = Color(0xFFC11E1E);
  static const Color whRed500 = Color(0xFFF55748);
  static const Color whRed700 = Color(0xFFFF8F84);
  static const Color whYellow100 = Color(0xFF564626);
  static const Color whYellow200 = Color(0xFF8C6500);
  static const Color whYellow300 = Color(0xFFB18000);
  static const Color whYellow500 = Color(0xFFFFB700);
  static const Color whYellow700 = Color(0xFFFFDC85);

  // legacy
  static const Color whBlack = Color(0xff2b2b2b);
  static const Color whDarkBlack = Color(0xff1F1F1F);
  static const Color whSemiBlack = Color(0xff404040);
  static const Color whGrey = Color(0xff404040);
  static const Color whBrightGrey = Color(0xff838383);
  // static const Color whWhite = Color(0xffFFFFFF);
  static const Color whSemiWhite = Color(0xffEEEEEE);
  // static const Color textCol = Color(0xffa2a2a2);
  static const Color whYellow = Color(0xffFFB800);
  static const Color whYellowBright = Color(0xfffadf92);
  static const Color whYellowDark = Color(0xff705100);
  static const Color whRed = Color(0xffF55748);

  static const Color whUnSelectedTextColor = Color(0xffA2A2A2);
  static const Color whSelectedTextColor = Color(0xff000000);
  static const Color whPlaceholderGrey = Color(0xffC3C2C7);

  // Gradients
  static const LinearGradient toastMessageGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      whYellow100,
      whYellow300,
    ],
  );
  static const LinearGradient bottomSheetGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
      whGrey200,
      whGrey400,
    ],
  );

  static const Color pointRed = Color(0xFFF74F3F);
  static const Color pointOrange = Color(0xFFE56229);
  static const Color pointYellow = Color(0xFFE6AE1C);
  static const Color pointGreen = Color(0xFF28A954);
  static const Color pointBlue = Color(0xFF2F74DB);
  static const Color pointPurple = Color(0xFF8861FD);
  static const Color pointPink = Color(0xFFED7087);

  static const List<Color> pointColorList = [
    pointRed,
    pointOrange,
    pointYellow,
    pointGreen,
    pointBlue,
    pointPurple,
    pointPink,
  ];
}
