import 'package:dev_utils/utils/device_screen_type.dart' show DeviceScreenType;
import 'package:flutter/material.dart';
import 'package:dev_utils/utils/responsive_breakpoints.dart'; 



class ScreenTypeLayout extends StatelessWidget {
  final Widget Function(BuildContext)? watch;
  final Widget Function(BuildContext)? mobile;
  final Widget Function(BuildContext)? tablet;
  final Widget Function(BuildContext)? desktop;

  const ScreenTypeLayout.builder({
    super.key,
    this.watch,
    this.mobile,
    this.tablet,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    final deviceType = ResponsiveBreakpoints.getDeviceType(
      MediaQuery.sizeOf(context),
      ResponsiveSizingConfig.instance.breakpoints,
    );

    const Widget forNull = SizedBox();

    switch (deviceType) {
      case DeviceScreenType.watch:
        return watch != null ? watch!(context) : forNull;
      case DeviceScreenType.mobile:
        return mobile != null ? mobile!(context) : forNull;
      case DeviceScreenType.tablet:
        return tablet != null ? tablet!(context) : forNull;
      case DeviceScreenType.desktop:
        return desktop != null ? desktop!(context) : forNull;
    }

  }
}
