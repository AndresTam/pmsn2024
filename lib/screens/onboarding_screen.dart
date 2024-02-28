import 'package:app01/intro_screens/intro_page1.dart';
import 'package:app01/intro_screens/intro_page2.dart';
import 'package:app01/intro_screens/intro_page3.dart';
import 'package:app01/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  //Controlador para saber en que pagina estamos
  final PageController _controller = PageController();
  //Bandera para saber si estamos en la ultima pagina o no
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Widget para la vista de pagina
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: const Alignment(0,0.80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Skip
                GestureDetector(
                  onTap: (){
                    _controller.jumpToPage(2);
                  },
                  child: const Text('skip')
                ),
                //Dot Indicator
                SmoothPageIndicator(controller: _controller, count: 3),
                //Next or done
                onLastPage 
                  ? GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context){
                              return const DashboardScreen();
                            },
                          ),
                        );
                      },
                      child: const Text('done'),
                    )
                  : GestureDetector(
                      onTap: (){
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: const Text('next'),
                    ),
              ],
            )
          ),
        ]
      ,)
    );
  }
}