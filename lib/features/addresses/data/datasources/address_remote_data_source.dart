import 'package:folbari/features/addresses/data/models/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:folbari/core/utils/logger.dart';

abstract class AddressRemoteDataSource {
  Future<List<AddressModel>> getAddresses();
  Future<void> addAddress(AddressModel address);
  Future<void> updateAddress(AddressModel address);
  Future<void> deleteAddress(String id);
  Future<void> setDefaultAddress(String id);
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final SupabaseClient supabaseClient;

  AddressRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return [];

      logger.i('Fetching addresses for user: $userId');
      final response = await supabaseClient
          .from('addresses')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      final addresses = (response as List)
          .map((data) => AddressModel.fromJson(data))
          .toList();

      logger.d('Fetched ${addresses.length} addresses');
      return addresses;
    } catch (e) {
      logger.e('Error fetching addresses', error: e);
      return [];
    }
  }

  @override
  Future<void> addAddress(AddressModel address) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Adding address: ${address.label}');
      await supabaseClient.from('addresses').insert({
        'user_id': userId,
        'label': address.label,
        'full_address': address.fullAddress,
        'city': address.city,
        'postal_code': address.postalCode,
        'is_default': address.isDefault,
      });
    } catch (e) {
      logger.e('Error adding address', error: e);
    }
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    try {
      logger.i('Updating address: ${address.id}');
      await supabaseClient
          .from('addresses')
          .update({
            'label': address.label,
            'full_address': address.fullAddress,
            'city': address.city,
            'postal_code': address.postalCode,
            'is_default': address.isDefault,
          })
          .eq('id', address.id);
    } catch (e) {
      logger.e('Error updating address', error: e);
    }
  }

  @override
  Future<void> deleteAddress(String id) async {
    try {
      logger.i('Deleting address: $id');
      await supabaseClient.from('addresses').delete().eq('id', id);
    } catch (e) {
      logger.e('Error deleting address', error: e);
    }
  }

  @override
  Future<void> setDefaultAddress(String id) async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return;

      logger.i('Setting default address: $id');

      // First, set all addresses to non-default
      await supabaseClient
          .from('addresses')
          .update({'is_default': false})
          .eq('user_id', userId);

      // Then set the selected address as default
      await supabaseClient
          .from('addresses')
          .update({'is_default': true})
          .eq('id', id);
    } catch (e) {
      logger.e('Error setting default address', error: e);
    }
  }
}
