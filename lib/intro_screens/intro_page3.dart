import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 130, 84, 183),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.network(
              'https://lottie.host/4e582cd7-c1d0-4246-b061-17f045d3a787/fnzoMDt4hQ.json',
              height: 300,
              reverse: true,
              repeat: true,
            ),
            const Text(
              'Recuerdos',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Retrata tus mejores momentos para revivirlos cuando quieras',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}