import 'package:covid_19/Screen/detail_screen.dart';
import 'package:covid_19/Services/states_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Track_countries extends StatefulWidget {
  const Track_countries({Key? key}) : super(key: key);

  @override
  State<Track_countries> createState() => _Track_countriesState();
}

class _Track_countriesState extends State<Track_countries> {

  TextEditingController search  = TextEditingController();

  @override
  Widget build(BuildContext context) {

    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar:AppBar(
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextFormField(
                controller: search,
                onChanged: (value){
                  setState(() {

                  });
                },
                decoration: InputDecoration(
                  hintText: "Search with country name ",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                    future: statesServices.fetchcountriesstateRecord(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      if(!snapshot.hasData){
                        return ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                             return Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Container(height: 10,width: 90,color: Colors.white,),
                                  subtitle: Container(height: 10,width: 90,color: Colors.white,),
                                  leading: Container(height: 50,width: 90,color: Colors.white,),
                                ),
                              ],
                            ));
                          },);
                      }else{

                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {

                          String name = snapshot.data![index]['country'];
                          if(search.text.isEmpty){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Detail_screen(
                                        name:snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalcase: snapshot.data![index]['cases'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        totaldeaths: snapshot.data![index]['todayDeaths'],
                                        population: snapshot.data![index]['population'],



                                      );
                                    },));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),
                                    ),
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  ),
                                ),

                              ],
                            );

                          }else if(name.toLowerCase().contains(search.text.toLowerCase())){
                            return Column(
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return Detail_screen(
                                        name:snapshot.data![index]['country'],
                                        image: snapshot.data![index]['countryInfo']['flag'],
                                        totalcase: snapshot.data![index]['cases'],
                                        active: snapshot.data![index]['active'],
                                        critical: snapshot.data![index]['critical'],
                                        test: snapshot.data![index]['tests'],
                                        todayRecovered: snapshot.data![index]['todayRecovered'],
                                        totaldeaths: snapshot.data![index]['todayDeaths'],
                                        population: snapshot.data![index]['population'],



                                      );
                                    },));
                                  },
                                  child: ListTile(
                                    leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(
                                          snapshot.data![index]['countryInfo']['flag']
                                      ),
                                    ),
                                    title: Text(snapshot.data![index]['country']),
                                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  ),
                                ),
                              ],
                            );
                          }else{
                            return Container();
                          }

                      },);
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
