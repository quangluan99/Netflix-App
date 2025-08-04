import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/data/model/top_rate_model.dart';

class ApiTopRateMovies {
  Future<TopRateMovie?> getApiTopRate() async {
    final endpoint = "movie/top_rated";
    final apiUrl = "$baseUrl$endpoint$key";
    final uri = Uri.parse(apiUrl);

    try {
      final response = await http.get(uri);
      debugPrint("Status code. is ${response.statusCode}");
      if (response.statusCode == 200) {
        final body = response.body;
        if (body.isEmpty) {
          throw Exception("Response body is empty");
        }
        final js = jsonDecode(body);

        if (js == null || js is! Map<String, dynamic>) {
          throw Exception("Decoded JSON is null or not a Map<String, dynamic>");
        }
        return TopRateMovie.fromJson(js);
      } else {
        throw Exception("Failed to load data ApiTrending");
      }
    } catch (err) {
      debugPrint(' getApiTrending ERROR BECAUSE : $err ');
      return null;
    }
  }
}
