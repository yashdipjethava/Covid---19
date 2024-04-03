import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'homepage.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({Key? key}) : super(key: key);

  @override
  State<Splash_screen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<Splash_screen>  with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 4),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer( const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const MyHomePage();
      },));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             AnimatedBuilder(
                 animation: _controller,
                 child:  Container(
                   height: 300,
                   width: 300,
                   child: Center(
                     child: Image(
                       image: AssetImage('assets/img/virus.png'),
                     ),
                   ),
                 ),
                 builder: (BuildContext context, Widget? child) {
                   return Transform.rotate(
                       angle: _controller.value * 2.0 * math.pi,
                     child: child,
                   );

                 },),
              //SizedBox(height: MediaQuery.of(context).size.height *0.02,),
              Text("Covid - 19 \nTracker App",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            ],
          ),
        )
      ),
    );
  }
}
