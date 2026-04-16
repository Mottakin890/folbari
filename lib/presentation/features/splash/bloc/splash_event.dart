import 'package:equatable/equatable.dart';

sealed class SplashEvent extends Equatable {
  const SplashEvent();
}

final class AppStarted extends SplashEvent {
  const AppStarted();
  @override
  List<Object?> get props => [];
}
