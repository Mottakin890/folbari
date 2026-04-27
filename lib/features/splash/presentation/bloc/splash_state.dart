import 'package:equatable/equatable.dart';

enum SplashStatus { loading, loaded, authenticated, failure }

final class SplashState extends Equatable {
  final SplashStatus status;
  const SplashState({this.status = SplashStatus.loading});

  bool get isLoading => status == SplashStatus.loading;
  bool get isLoaded => status == SplashStatus.loaded;
  bool get isAuthenticated => status == SplashStatus.authenticated;
  bool get isFailure => status == SplashStatus.failure;

  SplashState copyWith({SplashStatus? status}) {
    return SplashState(status: status ?? this.status);
  }

  @override
  List<Object?> get props => [status];
}
