import 'package:folbari/core/routes/app_pages.dart';
import 'package:go_router/go_router.dart';
import 'package:folbari/core/exports/pages.dart';
import 'package:folbari/features/order/presentation/view/order_history_screen.dart';
import 'package:folbari/features/home/presentation/view/favorites_screen.dart';
import 'package:folbari/features/profile/presentation/view/settings_screen.dart';
import 'package:folbari/features/chat/presentation/view/chat_screen.dart';
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
      GoRoute(
        path: AppPages.orderSuccess,
        name: AppPages.orderSuccess,
        builder: (context, state) => const OrderSuccessScreen(),
      ),
      GoRoute(
        path: AppPages.orderHistory,
        name: AppPages.orderHistory,
        builder: (context, state) => const OrderHistoryScreen(),
      ),
      GoRoute(
        path: AppPages.favorites,
        name: AppPages.favorites,
        builder: (context, state) => const FavoritesScreen(),
      ),
      GoRoute(
        path: AppPages.settings,
        name: AppPages.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppPages.chat,
        name: AppPages.chat,
        builder: (context, state) => const ChatScreen(),
      ),
    ],
  );
}
