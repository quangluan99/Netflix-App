import 'package:flutter/material.dart';
import 'package:netflix_app/data/model/popular_model.dart';
import 'package:netflix_app/data/remote/movie/api_popular_movie.dart';

Future<PopularMovie?> getDataApiPopular() async {
  final dataApi = await ApiPopularMovie().getApiPopularMovie();
  try {
    if (dataApi != null) {
      debugPrint('getDataApiPopular successfully!');
      return dataApi;
    } else {
      debugPrint('getDataApiPopular failed?????!');
      return null;
    }
  } catch (err) {
    debugPrint('getDataApiPopular Error because: $err');

    return null;
  }
}
