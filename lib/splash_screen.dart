import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';

import 'homePage.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});
  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  Future<void> delay() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }


  @override
  void initState() {
    delay();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
    _animation = Tween(begin: 0.0, end: 2 * 3.14).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RotationTransition(turns: _animation,
                  child: Image.asset("images/virus.png",height: 120,),
                ),
                const SizedBox(height: 30,),
                const TypeWriterText(text: Text(
                  textAlign: TextAlign.center,
                  "Pandemic Pulse",
                  style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                      fontSize: 50),
                ), duration: Duration(milliseconds: 50)),
                const SizedBox(height: 10,),
                const TypeWriterText(text: Text(
                  "Your go to for COVID-19 updates and resources.",
                  style: TextStyle(color: Colors.white70),
                ), duration: Duration(milliseconds: 15)),
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


