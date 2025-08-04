import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_app/data/model/upcoming_model.dart';

class ApiUpcoming {
  Future<UpcomingMovie?> getApiUpComing() async {
    final endpoint = "movie/upcoming";
    final apiUrl = "$baseUrl$endpoint$key";
    final uri = Uri.parse(apiUrl);

    try {
      final response = await http.get(uri);
      final statusCode = response.statusCode;
      debugPrint("Status code. is ${response.statusCode}");
      if (statusCode == 200) {
        final body = response.body;
        if (body.isEmpty) {
          throw Exception("Response body is empty");
        }
        final js = json.decode(body);
        if (js == null || js is! Map<String, dynamic>) {
          throw Exception("Decoded JSON is null or not a Map<String, dynamic>");
        }
        return UpcomingMovie.fromJson(js);
      } else {
        throw Exception("Failed to load data ApiUpComing ");
      }
    } catch (err) {
      debugPrint('getApiUpComing ERROR BECAUSE : $err ');
      return null;
    }
  }
}
