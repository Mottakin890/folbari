import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/core/di/dependency_injection.dart';
import 'package:folbari/core/routes/app_routes.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:folbari/features/splash/presentation/bloc/splash_event.dart';
import 'package:folbari/features/home/presentation/bloc/product_bloc.dart';
import 'package:folbari/features/home/presentation/bloc/product_event.dart';

class FolBariApp extends StatelessWidget {
  const FolBariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SplashBloc>()..add(AppStarted())),
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<ProductBloc>()..add(LoadProducts())),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.config,
      ),
    );
  }
}
