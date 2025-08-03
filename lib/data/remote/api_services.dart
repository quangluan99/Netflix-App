import 'dart:convert';

import 'package:netflix_app/common/utlis.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_app/data/model/movie_model.dart';

const key = "?api_key=$apiKey";

class ApiServices {
  Future<Movie?> getApi() async {
    final endpoint = "movie/now_playing";
    final apiUrl = "$baseUrl$endpoint$key";
    final uri = Uri.parse(apiUrl);

    try {
      final response = await http.get(uri);
      final statusCode = response.statusCode;
      print("Status code. is ${response.statusCode}");
      if (statusCode == 200) {
        final body = response.body;
        if (body.isEmpty) {
          throw Exception("Response body is empty");
        }
        final js = json.decode(body);
        if (js == null || js.isEmpty || js is! Map<String, dynamic>) {
          throw Exception("Decoded JSON is null or not a Map<String, dynamic>");
        }
        return Movie.fromJson(js);
      } else {
        throw Exception("Failed to load weather data ");
      }
    } catch (err) {
      print('ApiServices GET Movie ERROR BECAUSE : $err ');
      return null;
    }
  }
}
