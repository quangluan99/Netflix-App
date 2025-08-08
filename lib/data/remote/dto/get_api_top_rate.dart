import 'package:flutter/foundation.dart';
import 'package:netflix_app/data/model/top_rate_model.dart';
import 'package:netflix_app/data/remote/movie/api_top_rate_movies.dart';

Future<TopRateMovie?> getDataApiTopRate() async {
  try {
    final dataApi = await ApiTopRateMovies().getApiTopRate();
    if (dataApi != null) {
      debugPrint('getDataApiTopRate successfully!');
      return dataApi;
    } else {
      debugPrint('getDataApiTopRate failed?????');
      return null;
    }
  } catch (err) {
    debugPrint('getDataApiTopRate Error because $err');
    return null;
  }
}
