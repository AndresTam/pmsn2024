import 'dart:convert';
import 'package:app01/model/session_tmdb_model.dart';
import 'package:http/http.dart' as http;

class SessionID{
  final String apiKey = '45d69ee8ce7b6736b37ab4bc080fb3e2'; // Reemplaza 'TU_API_KEY' con tu API Key de TMDb
  final String username = 'AndresTam'; // Reemplaza 'TU_NOMBRE_DE_USUARIO' con tu nombre de usuario de TMDb
  final String password = 'martinez56.'; // Reemplaza 'TU_CONTRASEÑA' con tu contraseña de TMDb
  SessionManager sessionManager = SessionManager();

  String? sessionId;

  Future<void> getSessionId() async {
    final responseToken = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/authentication/token/new?api_key=$apiKey'));
    final tokenJson = json.decode(responseToken.body);
    final String requestToken = tokenJson['request_token'];

    final responseLogin = await http.post(
      Uri.parse('https://api.themoviedb.org/3/authentication/token/validate_with_login?api_key=$apiKey'),
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken,
      },
    );
    final loginJson = json.decode(responseLogin.body);
    final bool? loginSuccess = loginJson['success'];

    if (loginSuccess == true) {
      final responseSession = await http.post(
        Uri.parse('https://api.themoviedb.org/3/authentication/session/new?api_key=$apiKey'),
        body: {
          'request_token': requestToken,
        },
      );
      final sessionJson = json.decode(responseSession.body);
      sessionId = sessionJson['session_id'];
      sessionManager.setSessionId(sessionId!);
    }
  }
}