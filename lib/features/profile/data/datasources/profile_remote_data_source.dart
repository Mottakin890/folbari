import 'package:folbari/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:folbari/core/utils/logger.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel?> getProfile();
  Future<void> updateProfile(ProfileModel profile);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProfileRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<ProfileModel?> getProfile() async {
    try {
      final userId = supabaseClient.auth.currentUser?.id;
      if (userId == null) return null;

      logger.i('Fetching profile for user: $userId');
      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return ProfileModel.fromJson(response);
    } catch (e) {
      logger.e('Error fetching profile', error: e);
      return null;
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      logger.i('Updating profile for user: ${profile.id}');
      await supabaseClient
          .from('profiles')
          .upsert(profile.toJson());
    } catch (e) {
      logger.e('Error updating profile', error: e);
      rethrow;
    }
  }
}
