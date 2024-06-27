import 'package:flutter/material.dart';

class AppColors {
  static const Color veryDarkGrey = Color.fromARGB(255, 18, 18, 18);
  static const Color darkGrey = Color.fromARGB(255, 45, 45, 45);
  static const Color grey = Color.fromARGB(255, 139, 139, 139);
  static const Color middleGrey = Color.fromARGB(255, 171, 171, 171);
  static const Color brightGrey = Color.fromARGB(255, 228, 228, 228);
  static const Color blueGreen = Color.fromARGB(255, 0, 185, 206);
  static const Color green = Color.fromARGB(255, 132, 206, 191);
  static const Color darkGreen = Color.fromARGB(255, 101, 160, 149);
  static const Color blue = Color.fromARGB(255, 0, 125, 203);
  static const Color darkBlue = Color.fromARGB(255, 0, 70, 111);
  static const Color mediumBlue = Color.fromARGB(255, 60, 140, 180);
  static const Color darkOrange = Color.fromARGB(255, 222, 112, 48);
  static const Color faleBlue = Color.fromARGB(255, 160, 206, 222);
  static const Color brightBlue = Color.fromARGB(255, 123, 182, 212);
  static const Color salmon = Color(0xffff6666);
}

class CustomColors {
  static const Color whBlack = Color(0xff2b2b2b);
  static const Color whDarkBlack = Color(0xff1F1F1F);
  static const Color whSemiBlack = Color(0xff404040);
  static const Color whGrey = Color(0xff565656);
  static const Color whBrightGrey = Color(0xff838383);
  static const Color whWhite = Color(0xffFFFFFF);
  static const Color whSemiWhite = Color(0xffEEEEEE);
  // static const Color textCol = Color(0xffa2a2a2);
  static const Color whYellow = Color(0xffFFB800);
  static const Color whYellowBright = Color(0xfffadf92);
  static const Color whYellowDark = Color(0xff705100);
  static const Color whRed = Color(0xffA23333);
  static const Color whRedBright = Color(0xffDA3A3A);
  static const Color whUnSelectedTextColor = Color(0xffA2A2A2);
  static const Color whSelectedTextColor = Color(0xff000000);
  static const Color whPlaceholderGrey = Color(0xffC3C2C7);
  static const LinearGradient toastMessageGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xffA37E3A),
      Color(
        0xff564626,
      ),
    ],
  );
  static const LinearGradient bottomSheetGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      Color(0xff606060),
      Color(
        0xff201a1a,
      ),
    ],
  );
}

class PointColors {
  static const Color red = Color(0xffF55748);
  static const Color orange = Color(0xffe56229);
  static const Color yellow = Color(0xffe6ae1c);
  static const Color green = Color(0xff28a954);
  static const Color blue = Color(0xff2f74db);
  static const Color purple = Color.fromARGB(255, 136, 98, 253);
  static const Color pink = Color(0xffed7087);

  static const List<Color> colorList = [
    red,
    orange,
    yellow,
    green,
    blue,
    purple,
    pink,
  ];
}
