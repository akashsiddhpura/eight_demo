import 'package:flutter/material.dart';

extension ResponsiveSizeExtention on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;

  Orientation get orientation => MediaQuery.of(this).orientation;

  double get heightBox => Size(width, height).height;
  double get widthBox => Size(width, height).width;
}

extension ResponsiveTextExtension on num {
  double get sp {
    final textScaleFactor = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).textScaler;
    return (textScaleFactor.scale(toDouble()));
  }

  double get dp {
    final displayScale = MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).devicePixelRatio;
    return toDouble() / displayScale;
  }

  double get h {
    return MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size.height * (this / 100);
  }

  double get w {
    return MediaQueryData.fromView(WidgetsBinding.instance.platformDispatcher.views.first).size.width * (this / 100);
  }
}

extension SizeBoxExtention on num {
  SizedBox get space => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );
}
