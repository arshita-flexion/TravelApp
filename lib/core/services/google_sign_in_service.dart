import 'package:codefest_travel_app/core/flavor_config/flavor_config.dart';
import 'package:codefest_travel_app/core/utils/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final GoogleSignInService _instance = GoogleSignInService._internal();
  factory GoogleSignInService() => _instance;
  late final GoogleSignIn _googleSignIn;

  GoogleSignInService._internal() {
    _googleSignIn = GoogleSignIn(
      scopes: ['email', 'profile'],
      serverClientId: FlavorConfig.instance.env.googleServerClientId,
    );
  }

  Future<GoogleSignInResultModel?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        Logger.lOG('Google Sign-In cancelled by user');
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final String email = googleUser.email;
      final String? displayName = googleUser.displayName;
      final String? photoUrl = googleUser.photoUrl;
      final String? idToken = googleAuth.idToken;
      final String? accessToken = googleAuth.accessToken;

      if (accessToken == null) {
        Logger.lOG('Failed to get access token from Google Sign-In');
        return null;
      }

      Logger.lOG('Google Sign-In successful for: $email');

      return GoogleSignInResultModel(
        email: email,
        displayName: displayName ?? '',
        photoUrl: photoUrl,
        idToken: idToken,
        accessToken: accessToken,
      );
    } catch (error) {
      Logger.lOG('Error during Google Sign-In: $error');
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      Logger.lOG('Google Sign-Out successful');
    } catch (error) {
      Logger.lOG('Error during Google Sign-Out: $error');
      rethrow;
    }
  }

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  Future<void> disconnect() async {
    try {
      await _googleSignIn.disconnect();
      Logger.lOG('Google account disconnected');
    } catch (error) {
      Logger.lOG('Error disconnecting Google account: $error');
      rethrow;
    }
  }
}

class GoogleSignInResultModel {
  final String email;
  final String displayName;
  final String? photoUrl;
  final String? idToken;
  final String accessToken;

  GoogleSignInResultModel({
    required this.email,
    required this.displayName,
    this.photoUrl,
    this.idToken,
    required this.accessToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'displayName': displayName,
      'photoUrl': photoUrl,
      'idToken': idToken,
      'accessToken': accessToken,
    };
  }

  @override
  String toString() =>
      'GoogleSignInResultModel(email: $email, displayName: $displayName, accessToken: ${accessToken.substring(0, 5)}...)';
}
