import 'package:equatable/equatable.dart';

class CheckoutState extends Equatable {
  final String address;
  final String phoneNumber;
  final bool isSubmitting;
  final bool isSuccess;

  const CheckoutState({
    this.address = '',
    this.phoneNumber = '',
    this.isSubmitting = false,
    this.isSuccess = false,
  });

  bool get canSubmit => address.isNotEmpty && phoneNumber.isNotEmpty && !isSubmitting;

  CheckoutState copyWith({
    String? address,
    String? phoneNumber,
    bool? isSubmitting,
    bool? isSuccess,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [address, phoneNumber, isSubmitting, isSuccess];
}
