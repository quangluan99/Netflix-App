import 'package:flutter/material.dart';
import 'package:netflix_app/data/model/movie_model.dart';
import 'package:netflix_app/data/remote/movie/api_now_playing_movies.dart';

Future<Movie?> getDataApiNowPlaying() async {
  try {
    final dataApi = await ApiNowPlaying().getApiNowPlaying();
    if (dataApi != null) {
      debugPrint('getDataApiNowPlaying successfully!');
      return dataApi;
    } else {
      debugPrint('getDataApiNowPlaying Failed?????');
      return null;
    }
  } catch (err) {
    debugPrint("getDataApiNowPlaying Error because $err");
    return null;
  }
}
