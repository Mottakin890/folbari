import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Spacing {
  static Widget vertical(double space) => space.verticalSpace;
  static Widget horizontal(double space) => space.horizontalSpace;
}

class SliverSpacing {
  static Widget vertical(double space) => SliverToBoxAdapter(child: space.verticalSpace);
  static Widget horizontal(double space) => SliverToBoxAdapter(child: space.horizontalSpace);
}
