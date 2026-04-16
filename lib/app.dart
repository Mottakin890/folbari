import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/core/di/dependency_injection.dart';
import 'package:folbari/presentation/core/routes/app_routes.dart';
import 'package:folbari/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:folbari/presentation/features/splash/bloc/splash_event.dart';

class FolBariApp extends StatelessWidget {
  const FolBariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SplashBloc>()..add(AppStarted()))
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.config,
      ),
    );
  }
}