import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/profile/presentation/bloc/profile_event.dart';
import 'package:folbari/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(status: ProfileStatus.loading));
    await Future.delayed(const Duration(seconds: 1)); // Mocking update
    emit(state.copyWith(status: ProfileStatus.success));
  }
}
