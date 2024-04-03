import 'dart:convert';
import 'package:http/http.dart' as http;

class CountriesGetApi {

  Future<List<dynamic>> fatchCountriesData() async {
    var data;
    final responce =
        await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));


    if (responce.statusCode == 200) {
      data = jsonDecode(responce.body);
      return data;
    } else {
      throw Exception('Failed to load data');
    }
  }
}


