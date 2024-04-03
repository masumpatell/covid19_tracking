import 'dart:convert';
import 'package:http/http.dart' as http;

class GetApi{
  fetchCovidData() async{
    final responce = await http.get(Uri.parse("https://disease.sh/v3/covid-19/all"));

    if(responce.statusCode == 200){
      var data = jsonDecode(responce.body);
      return data;
    }
    else{
      throw Exception('Failed to load data');
    }
  }
}