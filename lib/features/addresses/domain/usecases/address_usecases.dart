import 'package:folbari/features/addresses/domain/repositories/address_repository.dart';
import 'package:folbari/features/addresses/data/models/address_model.dart';

class GetAddressesUseCase {
  final AddressRepository repository;

  GetAddressesUseCase({required this.repository});

  Future<List<AddressModel>> call() async {
    return await repository.getAddresses();
  }
}

class AddAddressUseCase {
  final AddressRepository repository;

  AddAddressUseCase({required this.repository});

  Future<void> call(AddressModel address) async {
    return await repository.addAddress(address);
  }
}

class UpdateAddressUseCase {
  final AddressRepository repository;

  UpdateAddressUseCase({required this.repository});

  Future<void> call(AddressModel address) async {
    return await repository.updateAddress(address);
  }
}

class DeleteAddressUseCase {
  final AddressRepository repository;

  DeleteAddressUseCase({required this.repository});

  Future<void> call(String id) async {
    return await repository.deleteAddress(id);
  }
}

class SetDefaultAddressUseCase {
  final AddressRepository repository;

  SetDefaultAddressUseCase({required this.repository});

  Future<void> call(String id) async {
    return await repository.setDefaultAddress(id);
  }
}
