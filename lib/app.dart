import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/core/di/dependency_injection.dart';
import 'package:folbari/core/routes/app_routes.dart';
import 'package:folbari/core/theme/app_theme.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_event.dart';
import 'package:folbari/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:folbari/features/splash/presentation/bloc/splash_event.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_bloc.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_event.dart';
import 'package:folbari/features/home/presentation/bloc/product_bloc.dart';
import 'package:folbari/features/home/presentation/bloc/product_event.dart';
import 'package:folbari/features/checkout/presentation/bloc/checkout_bloc.dart';

class FolBariApp extends StatelessWidget {
  const FolBariApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<SplashBloc>()..add(const AppStarted())),
        BlocProvider(create: (context) => sl<AuthBloc>()..add(const AuthCheckRequested())),
        BlocProvider(create: (context) => sl<ProductBloc>()..add(const LoadProducts())),
        BlocProvider(create: (context) => sl<BasketBloc>()..add(const LoadBasket())),
        BlocProvider(create: (context) => sl<CheckoutBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        routerConfig: AppRoutes.config,
      ),
    );
  }
}
