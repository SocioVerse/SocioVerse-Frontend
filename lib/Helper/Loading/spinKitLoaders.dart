import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:socioverse/Views/UI/themeColors.dart';

class SpinKit {
  static SpinKitRing ring = const SpinKitRing(
    color: ThemeColors.tertiary,
    lineWidth: 1,
    duration: Duration(seconds: 1),
  );
  static SpinKitThreeBounce threeBounce = const SpinKitThreeBounce(
    color: ThemeColors.primary,
    size: 20,
  );
}
