import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/data/model/search_movie.dart';
import 'package:http/http.dart' as http;

class ApiSearchMovie {
  Future<SearchMovie?> getApiSearchMovie(String? searchName) async {
    final endpoint = "search/movie";
    final apiUrl = "$baseUrl$endpoint$key&query=$searchName";
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
        debugPrint(
            'CHECK DATA backdrop_path: ${js["results"][0]["backdrop_path"]}'); //ktra data
        debugPrint(
            'CHECK DATA poster_path: ${js["results"][0]["poster_path"]}'); //ktra data
        debugPrint(
            'CHECK DATA original_title: ${js["results"][0]["original_title"]}'); //ktra data
        if (js == null || js is! Map<String, dynamic>) {
          throw Exception("Decoded JSON is null or not a Map<String, dynamic>");
        }
        return SearchMovie.fromJson(js);
      } else {
        throw Exception("Failed to load data ApiSearchMovie");
      }
    } catch (err) {
      debugPrint(' getApiSearchMovie ERROR BECAUSE : $err ');
      return null;
    }
  }
}
