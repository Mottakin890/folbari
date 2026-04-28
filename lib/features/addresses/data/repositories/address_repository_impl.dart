import 'package:folbari/features/addresses/data/datasources/address_remote_data_source.dart';
import 'package:folbari/features/addresses/data/models/address_model.dart';
import 'package:folbari/features/addresses/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AddressModel>> getAddresses() {
    return remoteDataSource.getAddresses();
  }

  @override
  Future<void> addAddress(AddressModel address) {
    return remoteDataSource.addAddress(address);
  }

  @override
  Future<void> updateAddress(AddressModel address) {
    return remoteDataSource.updateAddress(address);
  }

  @override
  Future<void> deleteAddress(String id) {
    return remoteDataSource.deleteAddress(id);
  }

  @override
  Future<void> setDefaultAddress(String id) {
    return remoteDataSource.setDefaultAddress(id);
  }
}
