import 'package:app01/model/session_tmdb_model.dart';
import 'package:app01/network/sesionId_tmdb.dart';
import 'package:flutter/material.dart';

class Sesion extends StatelessWidget {
  const Sesion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? sessionId = SessionManager().getSessionId();
    return Container(
      child: Text("El sesionID es: $sessionId"),
    );
  }
}