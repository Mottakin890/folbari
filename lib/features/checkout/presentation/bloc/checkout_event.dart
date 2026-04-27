import 'package:equatable/equatable.dart';

abstract class CheckoutEvent extends Equatable {
  const CheckoutEvent();

  @override
  List<Object?> get props => [];
}

class UpdateAddress extends CheckoutEvent {
  final String address;
  const UpdateAddress(this.address);

  @override
  List<Object?> get props => [address];
}

class UpdatePhoneNumber extends CheckoutEvent {
  final String phoneNumber;
  const UpdatePhoneNumber(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class SubmitCheckout extends CheckoutEvent {
  final String method;
  const SubmitCheckout(this.method);

  @override
  List<Object?> get props => [method];
}
