import 'package:flutter/material.dart';
import 'package:netflix_app/data/model/movie_detail.dart';
import 'package:netflix_app/data/remote/movie/api_movie_detail.dart';

Future<MovieDetail?> getDataApiMovieDetail(int id) async {
  final dataApi = await ApiMovieDetail().getApiMovieDetail(id: id);

  try {
    if (dataApi != null) {
      debugPrint('getDataApiMovieDetail successfully!');
      return dataApi;
    } else {
      debugPrint('getDataApiMovieDetail failed????');
      return null;
    }
  } catch (err) {
    debugPrint('getDataApiMovieDetail Error Because : $err!');
    return null;
  }
}
