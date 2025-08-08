import 'package:flutter/material.dart';
import 'package:netflix_app/data/model/recommen_dations.dart';
import 'package:netflix_app/data/remote/movie/api_recommen_dations.dart';

Future<RecommenDations?> getDataApiRecommenDations(int id) async {
  try {
    final dataApi = await ApiRecommenDations().getApiRecommenDations(id);
    if (dataApi != null) {
      debugPrint('getDataApiRecommenDations Sucessfully!');
      return dataApi;
    } else {
      debugPrint('getDataApiRecommenDations failed???');

      return null;
    }
  } catch (err) {
    debugPrint('getDataApiRecommenDations Error because: $err???');
    return null;
  }
}
