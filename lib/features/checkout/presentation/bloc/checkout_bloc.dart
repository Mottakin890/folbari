import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/checkout/presentation/bloc/checkout_event.dart';
import 'package:folbari/features/checkout/presentation/bloc/checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutState()) {
    on<UpdateAddress>((event, emit) {
      emit(state.copyWith(address: event.address));
    });
    on<UpdatePhoneNumber>((event, emit) {
      emit(state.copyWith(phoneNumber: event.phoneNumber));
    });
    on<SubmitCheckout>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    });
  }
}
