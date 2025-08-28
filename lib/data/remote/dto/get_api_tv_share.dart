import 'package:flutter/material.dart';
import 'package:netflix_app/data/model/tv_share.dart';
import 'package:netflix_app/data/remote/movie/api_tv_share.dart';

Future<TvShare?> getDataApiTvShare() async {
  final dataApi = await ApiTvShare().getApiTvShare();
  try {
    if (dataApi != null) {
      debugPrint('getDataApiTvShare successfully!');
      return dataApi;
    } else {
      debugPrint('Get data Tv Share failed????');
      return null;
    }
  } catch (err) {
    debugPrint('Get data Tv Share Error because $err');
    return null;
  }
}
