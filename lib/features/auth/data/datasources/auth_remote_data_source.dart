import 'package:folbari/core/utils/logger.dart';
import 'package:folbari/features/auth/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel?> signInWithGoogle();
  Future<void> signOut();
  UserModel? getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  final GoogleSignIn googleSignIn;

  AuthRemoteDataSourceImpl({
    required this.supabaseClient,
    required this.googleSignIn,
  });

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      logger.i('Attempting Google Sign-In...');
      final googleUser = await googleSignIn.authenticate();

      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;
      
      final googleAuthorization = await googleUser.authorizationClient.authorizeScopes([
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ]);
      final accessToken = googleAuthorization.accessToken;

      if (idToken == null) {
        logger.e('Missing Google ID Token');
        throw Exception('Missing Google ID Token');
      }

      final AuthResponse res = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      if (res.user == null) {
        logger.w('Supabase Sign-In successful but user is null');
        return null;
      }
      
      logger.i('Successfully signed in with Google: ${res.user!.email}');
      return UserModel.fromSupabase(res.user!);
    } catch (e) {
      logger.e('Error during Google Sign-In', error: e);
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      logger.i('Attempting Sign-Out...');
      await googleSignIn.signOut();
      await supabaseClient.auth.signOut();
      logger.i('Successfully signed out');
    } catch (e) {
      logger.e('Error during Sign-Out', error: e);
      rethrow;
    }
  }

  @override
  UserModel? getCurrentUser() {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      logger.d('No current user session found');
      return null;
    }
    logger.d('Current user session found: ${user.email}');
    return UserModel.fromSupabase(user);
  }
}
