import 'package:flutter/material.dart';
import 'package:netflix_app/data/model/trending_model.dart';
import 'package:netflix_app/data/remote/movie/api_treding_movies.dart';

Future<TrendingMovie?> getDataApiTrending() async {
  try {
    final dataApi = await ApiTrending().getApiTrending();
    if (dataApi != null) {
      debugPrint('getDataApiTrending Sucessfully!');
      return dataApi;
    } else {
      debugPrint('getDataApiTrending failed???');

      return null;
    }
  } catch (err) {
    debugPrint('getDataApiTrending Error because: $err???');
    return null;
  }
}
