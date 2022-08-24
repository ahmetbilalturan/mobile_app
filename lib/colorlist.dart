import 'package:flutter/cupertino.dart';

class ColorList {
  static Color backgroundColor = const Color.fromARGB(255, 14, 17, 29);
  static Color drawerBackgrounColor = const Color.fromARGB(255, 18, 23, 41);
  static Color textColor = const Color.fromARGB(255, 171, 180, 211);
  static Color iconColor = const Color.fromARGB(255, 207, 107, 107);

  static List<Color> colors = [
    const Color(0xFFe699cb),
    const Color(0xFFf3ccfb),
    const Color(0xFFdce2f3),
    const Color(0xFFd4fbcc),
    const Color(0xFF73df99),
  ];

  static List<double> stops = [
    0.03,
    0.25,
    0.5,
    0.85,
    1.6,
  ];

  static List<Shadow> textShadows = [
    const Shadow(
      offset: Offset(1, 1),
      blurRadius: 3.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
    const Shadow(
      offset: Offset(3, 3),
      blurRadius: 8.0,
      color: Color.fromARGB(255, 0, 0, 0),
    ),
  ];
}
