import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/app.dart';
import 'package:folbari/core/di/dependency_injection.dart';

void main(List<String> args) {
  _init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
    _,
  ) {
    runApp(
      const ScreenUtilInit(
        designSize: Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        child: FolBariApp(),
      ),
    );
  });
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
}
