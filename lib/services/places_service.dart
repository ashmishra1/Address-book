import 'package:http/http.dart' as http;
import 'package:new_app/models/place_search.dart';
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyA_FJMaioHXKUpJdUYAtq43tAIIPHgDiBk';

  Future<List<PlaceSearch>> getAutocomplete(String search) async {
    var url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$search&types=(cities)&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['predictions'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }
}
