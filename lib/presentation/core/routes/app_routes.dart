import 'package:folbari/presentation/core/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import 'package:folbari/presentation/core/exports/pages.dart';

class AppRoutes {
  const AppRoutes._();

  static final GoRouter config = GoRouter(
    initialLocation: AppPages.splash,
    routes: [
      GoRoute(
        path: AppPages.splash,
        name: AppPages.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(path: AppPages.welcome, name: AppPages.welcome, builder: (context, state) => const WelcomeScreen(),)
    ],
  );
}
