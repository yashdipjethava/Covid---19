import 'package:flutter/material.dart';

import 'homepage.dart';

class Detail_screen extends StatefulWidget {
  String name,image;
  int totalcase,totaldeaths,todayRecovered,active,critical,population,test;
  Detail_screen({Key? key,
    required this.name,
    required this.image,
    required this.totalcase,
    required this.totaldeaths,
    required this.todayRecovered,
    required this.active,
    required this.critical,
    required this.population,
    required this.test,

  }) : super(key: key);

  @override
  State<Detail_screen> createState() => _Detail_screenState();
}

class _Detail_screenState extends State<Detail_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only( top: MediaQuery.of(context).size.height*0.065),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                      Resueblerow(title: 'Total Cases', value: widget.totalcase.toString(),),
                      Resueblerow(title: 'totaldeaths', value: widget.totaldeaths.toString(),),
                      Resueblerow(title: 'todayRecovered', value: widget.todayRecovered.toString(),),
                      Resueblerow(title: 'active', value: widget.active.toString(),),
                      Resueblerow(title: 'critical', value: widget.critical.toString(),),
                      Resueblerow(title: 'test', value: widget.test.toString(),),
                      Resueblerow(title: 'population', value: widget.population.toString(),),


                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
