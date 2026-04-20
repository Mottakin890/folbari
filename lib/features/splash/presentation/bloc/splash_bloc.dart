import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/auth/domain/usecases/get_current_user.dart';
import 'package:folbari/features/splash/presentation/bloc/splash_event.dart';
import 'package:folbari/features/splash/presentation/bloc/splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetCurrentUser getCurrentUser;

  SplashBloc({required this.getCurrentUser}) : super(const SplashState()) {
    on<AppStarted>(_onAppStarted);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(state.copyWith(status: SplashStatus.loading));
    
    // Minimum splash time
    await Future.delayed(const Duration(seconds: 2));

    final user = await getCurrentUser();
    
    if (user != null) {
      emit(state.copyWith(status: SplashStatus.authenticated));
    } else {
      emit(state.copyWith(status: SplashStatus.loaded));
    }
  }
}
