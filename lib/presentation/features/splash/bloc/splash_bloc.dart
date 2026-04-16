import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/presentation/features/splash/bloc/splash_event.dart';
import 'package:folbari/presentation/features/splash/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<AppStarted>(_splashLoading);
  }
  Future<void> _splashLoading(
    AppStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(status: SplashStatus.loading));
    await Future.delayed(const Duration(seconds: 2)).then((_) {
      emit(state.copyWith(status: SplashStatus.loaded));
    });
  }
}
