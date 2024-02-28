import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isLoading = false;

  final txtUser = const TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      border: OutlineInputBorder()
    ),
  );

  final pwdUser = const TextField(
    keyboardType: TextInputType.text,
    obscureText: true,
    decoration:  InputDecoration(
      border: OutlineInputBorder()
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/fondo.jpg'),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 120,
              width: MediaQuery.of(context).size.width*.9,
              child: Image.asset('images/HK.png'),
            ),
            Positioned(
              top: 270,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 160,
                  width: MediaQuery.of(context).size.width*.9,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      txtUser,
                      const SizedBox(height: 10),
                      pwdUser,
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 170,
              child: Container(
                height: 140,
                width: MediaQuery.of(context).size.width*.9,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    SignInButton(
                      Buttons.Email,
                      onPressed: (){
                        setState(() {
                          isLoading = !isLoading;
                        });
                        Future.delayed(
                          new Duration(milliseconds: 5000),
                          (){
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => new DashboardScreen())
                            // );
                            Navigator.pushNamed(context, "/onboarding").then((value){
                              setState(() {
                                isLoading = !isLoading;
                              });
                            });
                          }
                        );
                      }
                    ),
                    SignInButton(
                      Buttons.Google,
                      onPressed: (){
                        setState(() {
                          isLoading = !isLoading;
                        });
                        Future.delayed(
                          new Duration(milliseconds: 2000),
                          (){
                            Navigator.pushNamed(context, "/signup").then((value){
                              setState(() {
                                isLoading = !isLoading;
                              });
                            });
                          }
                        );
                      }
                    ),
                    SignInButton(
                      Buttons.Facebook,
                      onPressed: (){}
                    ),
                    SignInButton(
                      Buttons.GitHub,
                      onPressed: (){}
                    ),
                  ],
                ),
              )
            ),
            isLoading ? const Positioned(
                top: 260,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
              : Container()
          ],
        ),
      ),
    );
  }
}