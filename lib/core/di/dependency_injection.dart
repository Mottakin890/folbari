import 'package:folbari/presentation/features/splash/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    //blocs
    sl.registerFactory(SplashBloc.new);
  }
}
