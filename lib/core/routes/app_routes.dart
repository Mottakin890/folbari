import 'package:folbari/core/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import 'package:folbari/core/exports/pages.dart';
import 'package:folbari/features/home/domain/entities/product_entity.dart';

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
      GoRoute(
        path: AppPages.welcome,
        name: AppPages.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppPages.auth,
        name: AppPages.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppPages.home,
        name: AppPages.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppPages.productDetail,
        name: AppPages.productDetail,
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return ProductDetailScreen(product: product);
        },
      ),
      GoRoute(
        path: AppPages.basket,
        name: AppPages.basket,
        builder: (context, state) => const BasketScreen(),
      ),
    ],
  );
}
