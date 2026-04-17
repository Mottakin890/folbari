import 'dart:math' as logger;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/app.dart';
import 'package:folbari/core/di/dependency_injection.dart';
import 'package:folbari/data/services/configs/endpoints.dart';
import 'package:folbari/data/services/configs/enums.dart';

Future<void> main(List<String> args) async{
  await _init(Deployment.production);
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

Future<void> _init(Deployment deployment) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await DependencyInjection.init();
  _setDeployment(deployment);
}

Future<void> _setDeployment(Deployment deployment) async {
  await dotenv.load(fileName: ".env");
  try {
    Endpoints.supabaseServiceUrl = (deployment == Deployment.production)
        ? dotenv.env['PRODUCTION_SUPABASE_SERVICE_URL']!
        : dotenv.env['STAGING__SUPABASE_SERVICE_URL']!;
    Endpoints.supabaseServiceUrl = (deployment == Deployment.production)
        ? dotenv.env['PRODUCTION_SUPABASE_SERVICE_ANON_KEY']!
        : dotenv.env['STAGING__SUPABASE_SERVICE_ANON_KEY']!;
  } catch (e) {
    logger.e;
  }
}
