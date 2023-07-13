import 'dart:convert';
import 'package:restaurant/config/constants.dart';
import 'package:restaurant/model/restaurant.dart';
import 'package:http/http.dart' as http;

Future<RestaurantsModel> getRestaurants() async {
  var url = Uri.parse(ApiConstants.baseUrl);

  try {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return RestaurantsModel.fromJson(jsonDecode(response.body));
    }
  } catch (_) {
  throw 'Unexpected error occurred.';
  }
  throw 'Unexpected error occurred.';
}
