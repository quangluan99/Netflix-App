import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:http/http.dart' as http;
import 'package:netflix_app/data/model/tv_share.dart';

class ApiTvShare {
  Future<TvShare?> getApiTvShare() async {
    final endpoint = "discover/tv";
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
        final js = json.decode(body);
        if (js == null || js is! Map<String, dynamic>) {
          throw Exception("Decoded JSON is null or not a Map<String, dynamic>");
        }
        return TvShare.fromJson(js);
      } else {
        throw Exception("Failed to load data ApiTrending");
      }
    } catch (err) {
      debugPrint('getApiTvShare ERROR BECAUSE : $err ');
      return null;
    }
  }
}
