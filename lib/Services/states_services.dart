import 'dart:convert';
import 'package:covid_19/Model/WorldstateModel.dart';
import 'package:covid_19/Services/Utilities/app_url.dart';
import 'package:http/http.dart' as http ;

class StatesServices {

  Future<worldstateModel> fetchworldstateRecord () async {
    final respones = await http.get(Uri.parse(AppUrl.worldstateUrl));

    if(respones.statusCode == 200){
      var data = jsonDecode(respones.body);
      return worldstateModel.fromJson(data);
    }else{
    }
      throw Exception("Error");
  }


  Future<List<dynamic>> fetchcountriesstateRecord () async {

    var data;
    final respones = await http.get(Uri.parse(AppUrl.countriesUrl));

    if(respones.statusCode == 200){
      var data = jsonDecode(respones.body);
      return data;
    }else{
      throw Exception("Error");
    }
  }

}