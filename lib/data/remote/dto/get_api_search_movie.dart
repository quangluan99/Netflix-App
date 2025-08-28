import 'package:flutter/material.dart';
import 'package:netflix_app/data/model/search_movie.dart';
import 'package:netflix_app/data/remote/movie/api_search_movie.dart';

Future<SearchMovie?> getDataApiSearchMovie(String? searchName) async {
  final dataApi = await ApiSearchMovie().getApiSearchMovie(searchName);

  try {
    if (dataApi != null) {
      debugPrint('getDataApiSearchMovie successfully!');
      return dataApi;
    } else {
      debugPrint('getDataApiSearchMovie failed?????');
      return null;
    }
  } catch (err) {
    debugPrint('getDataApiSearchMovie Error because $err');
    return null;
  }
}
