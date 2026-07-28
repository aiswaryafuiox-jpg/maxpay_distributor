import 'package:flutter/material.dart';

class AppColors {
  static const Color clrSecondary = Color(0xff011C5B);
  static const Color clrPrimary = Color(0xff17A2B8);
  static const Color clrBg = Color(0xffFFFEFE);
  static const Color borderc1 = Color(0xECF2F6CC);
  static const Color clrTextblack = Color(0xff000000);
  static const Color clrTextgrey = Color(0xff636363);
  static const Color clrplceholder = Color(0xffF4F4F4);
  static const Color blueColor = Color(0xff314CFF);
  static const Color darkBlue = Color.fromRGBO(73, 91, 255, 0.4);
  static const Color redClr = Color(0xffFF0000);
  static const Color textclr = Color(0xffC1C2C8);
  static const Color darktextclr = Color(0xff636363);
  static const Color background = Color(0xFFF6F7FF);
  static const Color darkbgBlack = Color(0xff25293C);
  static const Color darkplceholder = Color(0xff2F3349);
  static const Color darkFilterBorder = Color(0xFF3A4058);
  static const Color box1 = Color(0xffC0FFDF);
  static const Color box2 = Color(0xffFFCCD3);
  static const Color box3 = Color(0xffC6E5FF);
  static const Color box4 = Color(0xffFFE1B4);
  static const Color border = Color(0xFFF8F9FA);
  static const Color totalborder = Color(0xFFB5D4F4);
  static const Color sim1 = Color(0xFFDCFAFF);
  static const Color totalborde2 = Color(0xffCFCFCF);
  static const Color totalborder1 = Color.fromARGB(255, 122, 122, 122);
  static const Color sim2 = Color(0xFF36F097);
  static const Color lightbg = Color(0xFF002D90);
  static const Color lightbg2 = Color(0xFFF8F9FA);
  static const Color lightbg3 = Color(0xFFF8F9FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color card1 = Color(0xFFDCFFEE);
  static const Color card2 = Color(0xFFFFF0D8);
  static const Color card3 = Color.fromRGBO(255, 204, 211, 1);
  static const Color card4 = Color(0x66495BFF);
  static const Color fav = Color.fromARGB(255, 225, 168, 145);
  static const Color fav2 = Color(0xFF0DB561);
  static const Color fav3 = Color(0xFF00A954);
  static const Color fav4 = Color(0xFF36F097);
  static const Color fav5 = Color(0xFF011C5B);
  static const Color create = Color(0xFF00BC62);
  static const Color view = Color(0xFFD98200);
  static const Color pendingColor = Color(0xFFEFAD1B);

  static const Color pendingBg = Color(0xFFFFF4DA);
  static const Color activeColor = Color(0xFF00BC62);
  static const Color activeBg = Color(0xFFE6F8EF);
  static const Color completedColor = Color(0xFF00BC62);

  static const Color completedBg = Color(0xFFE6F8EF);
  static const Color successColor = Color(0xFF00BC62);
  static const Color successBg = Color(0xFFE6F8EF);
  static const Color retailerColor = Color(0xFF17A2B8);
  static const Color active1Bg = Color(0xFF00BC62);
  static const Color inactiveBg = Color(0xFFE53935);
  //commision settings colors
  /// Package Badge
  static const basicBg = Color(0xffB9F4E7);
  static const basicText = Color(0xff007A63);

  static const silverBg = Color(0xffE6E6E6);
  static const silverText = Color(0xff666666);

  static const silverPlusBg = Color(0xffD9D9D9);
  static const silverPlusText = Color(0xff333333);

  static const goldBg = Color(0xffFFD979);
  static const goldText = Color(0xff9B5A00);

  static const goldPlusBg = Color(0xffF8D04F);
  static const goldPlusText = Color(0xff8C5A00);

  /// Bottom Buttons
  static const activeBtn = Color(0xff00BC62);
  static const inactiveBtn = Color(0xffF40C29);
  static const pendingBtn = Color(0xffFF9800);
  static const resetBtn = Color(0xff17A2B8);
  static const Color profileBlue = Color(0xFF011C5B);
  //silver gradient
  static const Color silverDark = Color(0xFF7A96AC);
  static const Color silverLight = Color(0xFFEAEFF3);
  static const Color silverBlue = Color(0xFFC2D4E1);
  static const Color silverWhite = Color(0xFFFFFFFF);
  static const Color silverGrey = Color(0xFFD4DEE5);
  static const Color silverMid = Color(0xFFABBDC8);
  static const Color silverEnd = Color(0xFFBCCAD7);
  static const Color pinText = Color(0xFF0F1010);
  static const Color graph = Color(0xffEAEBF1);
  static const Color chart = Color(0xff615E83);
  static const Color chart1 = Color(0xff6D4E3F);
  static const Color chart2 = Color(0xffFFDDBE);
  static const LinearGradient silverGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7A96AC),
      Color(0xFFEAEFF3),
      Color(0xFFC2D4E1),
      Color(0xFFFFFFFF),
      Color(0xFFD4DEE5),
      Color(0xFFABBDC8),
      Color(0xFFBCCAD7),
    ],
    stops: [0.00, 0.18, 0.31, 0.49, 0.62, 0.79, 0.95],
  );
  static const basicGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFDFFFE),
      Color(0xFF7ABBAC),
      Color(0xFFB1FFEF),
      Color(0xFF8AD2C3),
      Color(0xFFCFFEF4),
      Color(0xFF6CA196),
      Color(0xFF35544E),
    ],
    stops: [0.0, 0.28, 0.39, 0.54, 0.75, 0.85, 1.0],
  );
  static const LinearGradient silverPlusGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA8A8A6),
      Color(0xFF696969),
      Color(0xFFF9F8F6),
      Color(0xFFA8A8A6),
      Color(0xFF7F7F7F),
      Color(0xFFD4D4D4),
    ],
    stops: [0.00, 0.25, 0.53, 0.72, 0.92, 1.00],
  );
  static const LinearGradient goldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFA3652A),
      Color(0xFFFEFBF2),
      Color(0xFFEFB06E),
      Color(0xFFF9C176),
      Color(0xFFE77B33),
      Color(0xFFDC702A),
      Color(0xFF733D19),
    ],
    stops: [0.00, 0.00, 0.21, 0.46, 0.68, 0.84, 1.00],
  );
  static const LinearGradient goldPlusGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8C421D),
      Color(0xFFFCFBE7),
      Color(0xFFD4A041),
      Color(0xFFFBE67B),
      Color(0xFFF7D14E),
      Color(0xFFD4A041),
    ],
    stops: [0.00, 0.00, 0.15, 0.38, 0.77, 1.00],
  );
}
