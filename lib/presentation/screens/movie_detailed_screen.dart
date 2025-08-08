import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/data/model/movie_detail.dart';
import 'package:netflix_app/data/model/recommen_dations.dart';
import 'package:netflix_app/data/model/top_rate_model.dart';
import 'package:netflix_app/data/remote/dto/get_api_movie_detail.dart';
import 'package:netflix_app/data/remote/dto/get_api_top_rate.dart';
import 'package:netflix_app/data/remote/dto/get_recomend_dations.dart';
import 'package:netflix_app/resources/functions/movies_Type.dart';
import 'package:netflix_app/resources/widgets/Button_Text_Icon.dart';

class MovieDetailedScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailedScreen({super.key, required this.movieId});

  @override
  State<MovieDetailedScreen> createState() => _MovieDetailedScreenState();
}

class _MovieDetailedScreenState extends State<MovieDetailedScreen> {
  late Future<MovieDetail?> detail;
  late Future<RecommenDations?> recommenDations;
  late Future<TopRateMovie?> topRate;

  @override
  void initState() {
    recommenDations = getDataApiRecommenDations(widget.movieId);
    detail = getDataApiMovieDetail(widget.movieId);
    topRate = getDataApiTopRate();
    super.initState();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;

    String formatRuntime(int runtime) {
      int hours = runtime ~/ 60;
      int minutes = runtime % 60;
      return '  ${hours}h ${minutes}m';
    }

    return Scaffold(
      body: FutureBuilder<MovieDetail?>(
        future: detail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.white,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  'Get Data Movie Detail Error Because : ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final moviesDetail = snapshot.data!;
            String generesText =
                moviesDetail.genres.map((e) => e.name).join(', ');

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height / 1.88,
                        child: CachedNetworkImage(
                          imageUrl: "$imageUrl${moviesDetail.posterPath}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned(
                        right: size.width * 0.03,
                        top: size.width * 0.02,
                        child: SafeArea(
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.cast,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: size.height * 0.27,
                        left: size.height * 0.20,
                        child: loading
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    loading = !loading;
                                  });
                                },
                                child: const CircularProgressIndicator(
                                    color: Colors.white),
                              )
                            : IconButton(
                                onPressed: () {
                                  setState(() {
                                    loading = !loading;
                                  });
                                },
                                icon: Icon(
                                  Icons.play_circle_outline,
                                  size: size.width * 0.12,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                moviesDetail.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 1,
                              child: Image.asset(
                                'assets/Netflix-Series.png',
                                height: size.width * 0.07,
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              "${moviesDetail.releaseDate.year}  ",
                              style: textTheme.bodyMedium,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white60, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                child: Text(
                                  'U/A 16+',
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodySmall!.copyWith(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "${formatRuntime(moviesDetail.runtime)} ",
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(width: 8),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.white60, width: 1.5)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                child: Text(
                                  'HD',
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodySmall!.copyWith(
                                      color: Colors.white60,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        ButtonTextIcon(
                          colorBackground: Colors.white,
                          colorText: Colors.black,
                          onTap: () {},
                          textTheme: textTheme,
                          icon: Icons.play_arrow,
                          title: 'Play',
                        ),
                        const SizedBox(height: 8),
                        ButtonTextIcon(
                          colorBackground: Colors.grey.shade800,
                          colorText: Colors.white,
                          onTap: () {},
                          textTheme: textTheme,
                          icon: Icons.download_rounded,
                          title: 'Download',
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Category: $generesText',
                          style: textTheme.titleMedium!
                              .copyWith(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          moviesDetail.overview,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        DefaultTabController(
                          length: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              TabBar(
                                tabs: const [
                                  Tab(text: 'My List', icon: Icon(Icons.add)),
                                  Tab(text: 'Rate', icon: Icon(Icons.thumb_up)),
                                  Tab(text: 'Share', icon: Icon(Icons.share)),
                                ],
                                indicatorColor: Colors.red,
                                labelColor: Colors.white,
                                unselectedLabelColor: Colors.white60,
                              ),
                              SizedBox(
                                height: size.height * 0.3,
                                child: TabBarView(
                                  children: [
                                    moviesType(
                                        size: size,
                                        futureData: recommenDations,
                                        movieType: "More Like This",
                                        textTheme: textTheme),
                                    moviesType(
                                      textTheme: textTheme,
                                      size: size,
                                      futureData: topRate,
                                      movieType: 'Top Rate Movies',
                                    ),
                                    moviesType(
                                        size: size,
                                        futureData: recommenDations,
                                        movieType: "Movies Share",
                                        textTheme: textTheme),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Problem to fetch data'));
          }
        },
      ),
    );
  }
}
