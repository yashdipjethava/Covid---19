
import 'package:covid_19/Model/WorldstateModel.dart';
import 'package:covid_19/Screen/track_country.dart';
import 'package:covid_19/Services/states_services.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color> [
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),

  ];
  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Covid App "),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height *0.01),
            FutureBuilder(
                future: statesServices.fetchworldstateRecord(),
                builder: (context, AsyncSnapshot<worldstateModel> snapshot) {
                  if(!snapshot.hasData){
                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(
                            color: Colors.black,
                            controller: _controller,
                            size: 50,
                          ));
                  }else{
                        return Column(
                           children: [
                             PieChart(
                               dataMap: {
                                 "title" : double.parse(snapshot.data!.cases.toString()),
                                 "recoverd":double.parse(snapshot.data!.recovered.toString()),
                                 "deaths" :double.parse(snapshot.data!.deaths.toString()),
                               },
                               chartValuesOptions: const ChartValuesOptions(
                                 showChartValuesInPercentage: true
                               ),
                               chartRadius: MediaQuery.of(context).size.width * 0.45 ,
                               legendOptions: const  LegendOptions(
                                   legendPosition: LegendPosition.left
                               ),
                               animationDuration:const  Duration(milliseconds: 1200),
                               chartType: ChartType.ring,
                               colorList: colorlist,
                             ),
                             SizedBox(height: MediaQuery.of(context).size.height *0.01),
                             Padding(
                               padding: const EdgeInsets.all(15.0),
                               child: Container(
                                 child: Column(
                                   children: [
                                     Resueblerow(title: "Total cases", value: snapshot.data!.cases.toString()),
                                     Resueblerow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                                     Resueblerow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                                     Resueblerow(title: "TodayCases", value: snapshot.data!.todayCases.toString()),
                                     Resueblerow(title: "TodayDeaths", value: snapshot.data!.todayDeaths.toString()),
                                     Resueblerow(title: "Population", value: snapshot.data!.population.toString()),
                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(height: MediaQuery.of(context).size.height *.01),
                             GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) {
                                   return Track_countries();
                                 },));
                               },
                               child: Container(
                                 height: 50,
                                 width: MediaQuery.of(context).size.width * 0.90,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(20),
                                   color: Colors.blueAccent,
                                 ),
                                 child: Center(child: Text("Track Countires",style: TextStyle(color: Colors.white,fontSize: 20),)),
                               ),
                             ),

                           ],
                        );
                  }
                },),


          ],
        ),
      ),
    );
  }
}

class Resueblerow extends StatelessWidget {
  String title , value ;
  Resueblerow({Key? key ,required this.title ,required this.value } ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,style: TextStyle(fontSize: 20),),
                Text(value,style: TextStyle(fontSize: 15),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


