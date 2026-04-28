import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folbari/features/addresses/domain/usecases/address_usecases.dart';
import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final GetAddressesUseCase getAddresses;
  final AddAddressUseCase addAddress;
  final UpdateAddressUseCase updateAddress;
  final DeleteAddressUseCase deleteAddress;
  final SetDefaultAddressUseCase setDefaultAddress;

  AddressBloc({
    required this.getAddresses,
    required this.addAddress,
    required this.updateAddress,
    required this.deleteAddress,
    required this.setDefaultAddress,
  }) : super(const AddressState()) {
    on<LoadAddresses>(_onLoadAddresses);
    on<AddAddress>(_onAddAddress);
    on<UpdateAddress>(_onUpdateAddress);
    on<DeleteAddress>(_onDeleteAddress);
    on<SetDefaultAddress>(_onSetDefaultAddress);
  }

  void _onLoadAddresses(LoadAddresses event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AddressStatus.loading));

    try {
      final addresses = await getAddresses();
      emit(state.copyWith(status: AddressStatus.loaded, addresses: addresses));
    } catch (e) {
      emit(
        state.copyWith(status: AddressStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void _onAddAddress(AddAddress event, Emitter<AddressState> emit) async {
    try {
      await addAddress(event.address);
      add(LoadAddresses());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onUpdateAddress(UpdateAddress event, Emitter<AddressState> emit) async {
    try {
      await updateAddress(event.address);
      add(LoadAddresses());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onDeleteAddress(DeleteAddress event, Emitter<AddressState> emit) async {
    try {
      await deleteAddress(event.id);
      add(LoadAddresses());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void _onSetDefaultAddress(
    SetDefaultAddress event,
    Emitter<AddressState> emit,
  ) async {
    try {
      await setDefaultAddress(event.id);
      add(LoadAddresses());
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
