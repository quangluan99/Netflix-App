import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/data/model/movie_detail.dart';
import 'package:netflix_app/resources/functions/get_api_movie_detail.dart';
import 'package:netflix_app/resources/widgets/Button_Text_Icon.dart';

class MovieDetailedScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailedScreen({super.key, required this.movieId});

  @override
  State<MovieDetailedScreen> createState() => _MovieDetailedScreenState();
}

class _MovieDetailedScreenState extends State<MovieDetailedScreen> {
  late Future<MovieDetail?> detail;
  @override
  void initState() {
    detail = getDataApiMovieDetail(widget.movieId);
    super.initState();
  }

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
      body: FutureBuilder(
        future: detail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  'Get Data Movie Detail Error Because : ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final moviesDetail = snapshot.data!;
            String generesText = moviesDetail.genres.map(
              (e) {
                return e.name;
              },
            ).join(', ');
            return Column(
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
                        )),
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
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.white,
                                    )),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.black54,
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.cast,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ),
                        )),
                    Positioned(
                        top: size.height * 0.27,
                        left: size.height * 0.20,
                        child: Icon(
                          Icons.play_circle_outline,
                          size: size.width * 0.12,
                          color: Colors.white,
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            moviesDetail.title,
                            style: textTheme.bodyLarge!.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          ),
                          Spacer(),
                          Image.asset(
                            height: size.width * 0.08,
                            'assets/Netflix-Series.png',
                            fit: BoxFit.cover,
                            color: Colors.white,
                          ),
                        ],
                      ),
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
                            child: Text(
                              textAlign: TextAlign.center,
                              'U/A 16+   ',
                              style: textTheme.bodySmall!.copyWith(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Text(
                            "${formatRuntime(moviesDetail.runtime)} ",
                            style: textTheme.bodyMedium,
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white60, width: 1.5)),
                            child: Text(
                              textAlign: TextAlign.center,
                              'HD   ',
                              style: textTheme.bodySmall!.copyWith(
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ButtonTextIcon(
                        colorBackground: Colors.white,
                        colorText: Colors.black,
                        onTap: () {},
                        textTheme: textTheme,
                        icon: Icons.play_arrow,
                        title: 'Play',
                      ),
                      ButtonTextIcon(
                        colorBackground: Colors.grey.shade800,
                        colorText: Colors.white,
                        onTap: () {},
                        textTheme: textTheme,
                        icon: Icons.download_rounded,
                        title: 'Dowload',
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Category: $generesText',
                        style: textTheme.titleMedium!
                            .copyWith(color: Colors.grey.shade600),
                      ),
                      Text(
                        maxLines: 3,
                        moviesDetail.overview,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Problem to fetch data'),
            );
          }
        },
      ),
    );
  }
}
