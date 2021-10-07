import 'package:flutter/material.dart';

enum DeviceType {
  Mobile,
  Tablet,
  Desktop,
}

DeviceType getDeviceType(context, MediaQuery mediaQuery) {
  Orientation orientation = MediaQuery.of(context).orientation;
  double width = 0;
  if (orientation == Orientation.landscape) {
    width = MediaQuery.of(context).size.height;
  } else {
    width = MediaQuery.of(context).size.width;
  }
  if (width >= 950) {
    return DeviceType.Desktop;
  }
  if (width >= 600) {
    return DeviceType.Tablet;
  }
  return DeviceType.Mobile;
}
