import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:folbari/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:folbari/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:folbari/features/auth/domain/repositories/auth_repository.dart';
import 'package:folbari/features/auth/domain/usecases/get_current_user.dart';
import 'package:folbari/features/auth/domain/usecases/sign_in_with_google.dart';
import 'package:folbari/features/auth/domain/usecases/sign_out.dart';
import 'package:folbari/features/home/data/datasources/product_remote_data_source.dart';
import 'package:folbari/features/home/data/repositories/product_repository_impl.dart';
import 'package:folbari/features/home/domain/repositories/product_repository.dart';
import 'package:folbari/features/home/domain/usecases/get_category_products.dart';
import 'package:folbari/features/home/domain/usecases/get_recommended_products.dart';
import 'package:folbari/features/basket/data/datasources/basket_remote_data_source.dart';
import 'package:folbari/features/basket/data/repositories/basket_repository_impl.dart';
import 'package:folbari/features/basket/domain/repositories/basket_repository.dart';
import 'package:folbari/features/basket/domain/usecases/basket_usecases.dart';
import 'package:folbari/features/basket/presentation/bloc/basket_bloc.dart';
import 'package:folbari/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:folbari/features/home/presentation/bloc/product_bloc.dart';
import 'package:folbari/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:folbari/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:folbari/features/order/data/datasources/order_remote_data_source.dart';
import 'package:folbari/features/order/data/repositories/order_repository_impl.dart';
import 'package:folbari/features/order/domain/repositories/order_repository.dart';
import 'package:folbari/features/order/domain/usecases/get_orders.dart';
import 'package:folbari/features/order/presentation/bloc/order_bloc.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:folbari/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final GetIt sl = GetIt.instance;

class DependencyInjection {
  DependencyInjection._();

  static Future<void> init() async {
    await _initExternal();
    _initDataSources();
    _initRepositories();
    _initUseCases();
    _initBlocs();
  }

  static Future<void> _initExternal() async {
    sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
    
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(
      clientId: (Platform.isAndroid)
          ? dotenv.env['ANDROID_CLIENT_ID']
          : dotenv.env['IOS_CLIENT_ID'],
      serverClientId: dotenv.env['WEB_CLIENT_ID'],
    );
    sl.registerLazySingleton<GoogleSignIn>(() => googleSignIn);
  }

  static void _initDataSources() {
    sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: sl(),
        googleSignIn: sl(),
      ),
    );
    sl.registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(supabaseClient: sl()),
    );
    sl.registerLazySingleton<BasketRemoteDataSource>(
      () => BasketRemoteDataSourceImpl(supabaseClient: sl()),
    );
    sl.registerLazySingleton<OrderRemoteDataSource>(
      () => OrderRemoteDataSourceImpl(),
    );
  }

  static void _initRepositories() {
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<BasketRepository>(
      () => BasketRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(remoteDataSource: sl()),
    );
  }

  static void _initUseCases() {
    sl.registerLazySingleton<SignInWithGoogle>(() => SignInWithGoogle(sl()));
    sl.registerLazySingleton<GetCurrentUser>(() => GetCurrentUser(sl()));
    sl.registerLazySingleton<SignOut>(() => SignOut(sl()));
    sl.registerLazySingleton<GetRecommendedProducts>(() => GetRecommendedProducts(sl()));
    sl.registerLazySingleton<GetCategoryProducts>(() => GetCategoryProducts(sl()));
    
    sl.registerLazySingleton<GetBasketItems>(() => GetBasketItems(sl()));
    sl.registerLazySingleton<AddToBasket>(() => AddToBasket(sl()));
    sl.registerLazySingleton<RemoveFromBasket>(() => RemoveFromBasket(sl()));
    sl.registerLazySingleton<UpdateBasketQuantity>(() => UpdateBasketQuantity(sl()));
    sl.registerLazySingleton<GetOrders>(() => GetOrders(sl()));
  }

  static void _initBlocs() {
    sl.registerFactory(() => SplashBloc(getCurrentUser: sl()));
    sl.registerFactory(
      () => AuthBloc(
        signInWithGoogleUseCase: sl(),
        getCurrentUserUseCase: sl(),
        signOutUseCase: sl(),
      ),
    );
    sl.registerFactory(
      () => ProductBloc(
        getRecommendedProducts: sl(),
        getCategoryProducts: sl(),
      ),
    );
    sl.registerFactory(
      () => BasketBloc(
        getBasketItems: sl(),
        addToBasket: sl(),
        removeFromBasket: sl(),
        updateBasketQuantity: sl(),
      ),
    );
    sl.registerFactory(() => CheckoutBloc());
    sl.registerFactory(() => OrderBloc(getOrders: sl()));
    sl.registerFactory(() => ChatBloc());
    sl.registerFactory(() => ProfileBloc());
  }
}
