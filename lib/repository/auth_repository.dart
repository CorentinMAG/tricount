import 'package:tricount/models/user.dart';
import 'package:tricount/provider/auth_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tricount/services/shared_preferences_service.dart';

class AuthenticationRepository {
  final AuthenticationProvider _auth = AuthenticationProvider();
  final SharedPrefService _prefs = SharedPrefService.instance;


  Future<void> signUpUser({required UserModel user, required String password}) async {
    await _auth.signUpUser(user: user, password: password);
  }

  Future<UserModel?> signInWithEmailAndPassword({required String email, required String password}) async {
    final response = await _auth.signInWithEmailAndPassword(email: email, password: password);
    if (response.statusCode != 200) {
      throw Exception(response.toString());
    }
    final Map<String, dynamic>? payload = response.data;
    if (payload == null) {
      return null;
    }
    final String accessToken = payload['token']!;
    final String refreshToken = payload['refresh_token']!;

    await _prefs.setValue('token', accessToken);
    await _prefs.setValue('refresh_token', refreshToken);

    final Map<String, dynamic> userJson = JwtDecoder.decode(accessToken);

    final UserModel userModel = UserModel.fromJson(userJson);
    return userModel;
  }

  Future<void> requestPasswordReset({required String email}) async {
    await _auth.requestPasswordReset(email: email);
  }
}