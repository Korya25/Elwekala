import 'package:flutter/widgets.dart';

extension MediaQueryExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenHeight => screenSize.height;
  double get screenWidth => screenSize.width;
  EdgeInsets get screenPadding => MediaQuery.of(this).padding;
}
