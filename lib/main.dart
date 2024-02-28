import 'package:app01/screens/dashboard_screen.dart';
import 'package:app01/screens/despensa_screen.dart';
import 'package:app01/screens/onboarding_screen.dart';
import 'package:app01/screens/signup_screen.dart';
import 'package:app01/screens/splash_screen.dart';
import 'package:app01/settings/app_valuenotifier.dart';
import 'package:app01/settings/theme.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: AppValueNotifier.banTheme,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: value ? ThemeApp.darkTheme(context) : ThemeApp.lightTheme(context),
          home: const SplashScreen(),
          routes: {
            "/dash" : (BuildContext context) => const DashboardScreen(),
            "/despensa" : (BuildContext context) => const DespensaScreen(),
            "/signup" : (BuildContext context) => const SignupScreen(),
            "/onboarding" : (BuildContext context) => const OnBoardingScreen(),
          },
        );
      }
    );
  }
}

/*class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int contador = 0;

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("asd",style: TextStyle(fontWeight:FontWeight.w100,fontSize: 30))
        ),
        drawer: Drawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            contador++;
            print(contador);
            setState(() {});
          },
          child: Icon(Icons.ads_click),
          backgroundColor: Colors.amber,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.network('https://celaya.tecnm.mx/wp-content/uploads/2021/02/cropped-FAV.png',
              height: 250,),
            ),
            Text('Valor del contador $contador'),
          ],
        ),
      ),
    );
  }
}*/



// class MyApp extends StatelessWidget {
//   MyApp({super.key});

//   int contador = 0;

//   @override
//   Widget build(BuildContext context){
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("asd",style: TextStyle(fontWeight:FontWeight.w100,fontSize: 30))
//         ),
//         drawer: Drawer(),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             contador++;
//             print(contador);
//           },
//           child: Icon(Icons.ads_click),
//           backgroundColor: Colors.amber,
//         ),
//         body: Center( 
//           child: Column(
//             children: [
//               Image.network('https://celaya.tecnm.mx/wp-content/uploads/2021/02/cropped-FAV.png',
//               height: 250,),
//               Text('Valor del contador $contador'),
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }