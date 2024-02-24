import 'package:app01/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:splash_view/source/presentation/presentation.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SplashView(
      backgroundColor: Colors.grey[800],
      //logo: Image.network('https://celaya.tecnm.mx/wp-content/uploads/2021/02/cropped-FAV.png', height: 250),
      loadingIndicator: Image.asset('images/loading.gif'),
      done: Done(
        const LoginScreen(),
        animationDuration: const Duration(milliseconds: 2000),
      ),
    );
  }
}