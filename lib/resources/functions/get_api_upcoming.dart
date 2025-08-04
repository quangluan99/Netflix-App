import 'package:flutter/material.dart';
import 'package:netflix_app/data/model/upcoming_model.dart';
import 'package:netflix_app/data/remote/movie/api_upcoming_movies.dart';

Future<UpcomingMovie?> getDataApiUpComing() async {
  try {
    final dataApi = await ApiUpcoming().getApiUpComing();
    if (dataApi != null) {
      debugPrint('Get data Upcoming successfully!');
      return dataApi;
    } else {
      debugPrint('Get data Upcoming failed????');
      return null;
    }
  } catch (err) {
    debugPrint('Get data Upcoming Error because $err');
    return null;
  }
}
