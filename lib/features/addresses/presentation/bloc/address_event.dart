import 'package:folbari/features/addresses/data/models/address_model.dart';

abstract class AddressEvent {}

class LoadAddresses extends AddressEvent {}

class AddAddress extends AddressEvent {
  final AddressModel address;
  AddAddress({required this.address});
}

class UpdateAddress extends AddressEvent {
  final AddressModel address;
  UpdateAddress({required this.address});
}

class DeleteAddress extends AddressEvent {
  final String id;
  DeleteAddress({required this.id});
}

class SetDefaultAddress extends AddressEvent {
  final String id;
  SetDefaultAddress({required this.id});
}
