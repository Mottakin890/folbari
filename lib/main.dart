import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folbari/app.dart';
import 'package:folbari/core/di/dependency_injection.dart';
import 'package:folbari/core/utils/logger.dart';
import 'package:folbari/core/config/deployment.dart';
import 'package:folbari/core/config/endpoints.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main(List<String> args) async {
  runZonedGuarded(() async {
    await _init(Deployment.production);
    
    // Custom Error Widget for Production
    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        body: Center(
          child: Text(
            'Something went wrong. Please try again later.',
            style: TextStyle(fontSize: 18.sp, color: Colors.red),
          ),
        ),
      );
    };

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
  }, (error, stack) {
    logger.e('Uncaught Error: $error', error: error, stackTrace: stack);
  });
}

Future<void> _init(Deployment deployment) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await dotenv.load(fileName: ".env");
  await DependencyInjection.init();
  await _setDeployment(deployment);
  await _initSupabase();
}

Future<void> _setDeployment(Deployment deployment) async {
  try {
    Endpoints.supabaseServiceUrl = (deployment == Deployment.production)
        ? dotenv.env['PRODUCTION_SUPABASE_SERVICE_URL']!
        : dotenv.env['STAGING__SUPABASE_SERVICE_URL']!;
    Endpoints.supabaseServiceAnonKey = (deployment == Deployment.production)
        ? dotenv.env['PRODUCTION_SUPABASE_SERVICE_ANON_KEY']!
        : dotenv.env['STAGING__SUPABASE_SERVICE_ANON_KEY']!;
  } catch (e) {
    logger.e(e);
  }
}

Future<void> _initSupabase() async {
  try {
    await Supabase.initialize(
      url: Endpoints.supabaseServiceUrl,
      anonKey: Endpoints.supabaseServiceAnonKey,
    );
  } catch (e) {
    logger.e(e);
  }
}
