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
import 'package:folbari/features/chat/domain/repositories/chat_repository.dart';
import 'package:folbari/features/chat/domain/usecases/chat_usecases.dart';
import 'package:folbari/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:folbari/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:folbari/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:folbari/features/profile/domain/repositories/profile_repository.dart';
import 'package:folbari/features/profile/domain/usecases/profile_usecases.dart';
import 'package:folbari/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:folbari/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:folbari/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:folbari/features/addresses/data/datasources/address_remote_data_source.dart';
import 'package:folbari/features/addresses/data/repositories/address_repository_impl.dart';
import 'package:folbari/features/addresses/domain/repositories/address_repository.dart';
import 'package:folbari/features/addresses/domain/usecases/address_usecases.dart';
import 'package:folbari/features/favorites/data/datasources/favorite_remote_data_source.dart';
import 'package:folbari/features/favorites/data/repositories/favorite_repository_impl.dart';
import 'package:folbari/features/favorites/domain/repositories/favorite_repository.dart';
import 'package:folbari/features/favorites/domain/usecases/favorite_usecases.dart';
import 'package:folbari/features/search_history/data/datasources/search_history_remote_data_source.dart';
import 'package:folbari/features/search_history/data/repositories/search_history_repository_impl.dart';
import 'package:folbari/features/search_history/domain/repositories/search_history_repository.dart';
import 'package:folbari/features/search_history/domain/usecases/search_history_usecases.dart';
import 'package:folbari/features/addresses/presentation/bloc/address_bloc.dart';
import 'package:folbari/features/favorites/presentation/bloc/favorite_bloc.dart';
import 'package:folbari/features/search_history/presentation/bloc/search_history_bloc.dart';
import 'package:folbari/features/admin/data/datasources/admin_remote_data_source.dart';
import 'package:folbari/features/admin/data/repositories/admin_repository_impl.dart';
import 'package:folbari/features/admin/domain/repositories/admin_repository.dart';
import 'package:folbari/features/admin/domain/usecases/admin_usecases.dart';
import 'package:folbari/features/admin/presentation/bloc/admin_bloc.dart';
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
      () => OrderRemoteDataSourceImpl(supabaseClient: sl()),
    );
    sl.registerLazySingleton<AddressRemoteDataSource>(
      () => AddressRemoteDataSourceImpl(supabaseClient: sl()),
    );
    sl.registerLazySingleton<FavoriteRemoteDataSource>(
      () => FavoriteRemoteDataSourceImpl(supabaseClient: sl()),
    );
    sl.registerLazySingleton<SearchHistoryRemoteDataSource>(
      () => SearchHistoryRemoteDataSourceImpl(supabaseClient: sl()),
    );
    sl.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(supabaseClient: sl()),
    );
    sl.registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(supabaseClient: sl()),
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
    sl.registerLazySingleton<AddressRepository>(
      () => AddressRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<FavoriteRepository>(
      () => FavoriteRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<SearchHistoryRepository>(
      () => SearchHistoryRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImpl(remoteDataSource: sl()),
    );
    sl.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(remoteDataSource: sl()),
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
    
    // Address
    sl.registerLazySingleton<GetAddressesUseCase>(() => GetAddressesUseCase(repository: sl()));
    sl.registerLazySingleton<AddAddressUseCase>(() => AddAddressUseCase(repository: sl()));
    sl.registerLazySingleton<UpdateAddressUseCase>(() => UpdateAddressUseCase(repository: sl()));
    sl.registerLazySingleton<DeleteAddressUseCase>(() => DeleteAddressUseCase(repository: sl()));
    sl.registerLazySingleton<SetDefaultAddressUseCase>(() => SetDefaultAddressUseCase(repository: sl()));

    // Favorites
    sl.registerLazySingleton<GetFavoritesUseCase>(() => GetFavoritesUseCase(repository: sl()));
    sl.registerLazySingleton<AddFavoriteUseCase>(() => AddFavoriteUseCase(repository: sl()));
    sl.registerLazySingleton<RemoveFavoriteUseCase>(() => RemoveFavoriteUseCase(repository: sl()));
    sl.registerLazySingleton<CheckIsFavoriteUseCase>(() => CheckIsFavoriteUseCase(repository: sl()));

    // Search History
    sl.registerLazySingleton<GetSearchHistoryUseCase>(() => GetSearchHistoryUseCase(repository: sl()));
    sl.registerLazySingleton<AddSearchQueryUseCase>(() => AddSearchQueryUseCase(repository: sl()));
    sl.registerLazySingleton<DeleteSearchQueryUseCase>(() => DeleteSearchQueryUseCase(repository: sl()));
    sl.registerLazySingleton<ClearSearchHistoryUseCase>(() => ClearSearchHistoryUseCase(repository: sl()));

    // Profile
    sl.registerLazySingleton<GetProfile>(() => GetProfile(sl()));
    sl.registerLazySingleton<UpdateProfile>(() => UpdateProfile(sl()));

    // Chat
    sl.registerLazySingleton<GetChatMessages>(() => GetChatMessages(sl()));
    sl.registerLazySingleton<SendChatMessage>(() => SendChatMessage(sl()));
    sl.registerLazySingleton<GetChatStream>(() => GetChatStream(sl()));

    // Admin
    sl.registerLazySingleton<AdminRemoteDataSource>(() => AdminRemoteDataSourceImpl(supabaseClient: sl()));
    sl.registerLazySingleton<AdminRepository>(() => AdminRepositoryImpl(remoteDataSource: sl()));
    sl.registerLazySingleton<GetAllUsers>(() => GetAllUsers(sl()));
    sl.registerLazySingleton<DeleteUser>(() => DeleteUser(sl()));
    sl.registerLazySingleton<UpdateUserRole>(() => UpdateUserRole(sl()));
    sl.registerLazySingleton<AddProduct>(() => AddProduct(sl()));
    sl.registerLazySingleton<UpdateProduct>(() => UpdateProduct(sl()));
    sl.registerLazySingleton<DeleteProduct>(() => DeleteProduct(sl()));
    sl.registerLazySingleton<GetAnalytics>(() => GetAnalytics(sl()));
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
    sl.registerFactory(
      () => ChatBloc(
        getChatMessages: sl(),
        sendChatMessage: sl(),
        getChatStream: sl(),
      ),
    );
    sl.registerFactory(
      () => ProfileBloc(
        getProfile: sl(),
        updateProfile: sl(),
      ),
    );
    sl.registerFactory(
      () => AddressBloc(
        getAddresses: sl(),
        addAddress: sl(),
        updateAddress: sl(),
        deleteAddress: sl(),
        setDefaultAddress: sl(),
      ),
    );
    sl.registerFactory(
      () => FavoriteBloc(
        getFavorites: sl(),
        addFavorite: sl(),
        removeFavorite: sl(),
        checkIsFavorite: sl(),
      ),
    );
    sl.registerFactory(
      () => SearchHistoryBloc(
        getSearchHistory: sl(),
        addSearchQuery: sl(),
        deleteSearchQuery: sl(),
        clearSearchHistory: sl(),
      ),
    );
    sl.registerFactory(
      () => AdminBloc(
        getAnalytics: sl(),
        getAllUsers: sl(),
        deleteUser: sl(),
        updateUserRole: sl(),
        addProduct: sl(),
        updateProduct: sl(),
        deleteProduct: sl(),
      ),
    );
  }
}
