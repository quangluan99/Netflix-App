import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/data/model/movie_model.dart';
import 'package:netflix_app/data/model/popular_model.dart';
import 'package:netflix_app/data/model/top_rate_model.dart';
import 'package:netflix_app/data/model/trending_model.dart';
import 'package:netflix_app/data/model/upcoming_model.dart';
import 'package:netflix_app/presentation/screens/movie_detailed_screen.dart';
import 'package:netflix_app/data/remote/dto/get_api_now_playing.dart';
import 'package:netflix_app/data/remote/dto/get_api_popular.dart';
import 'package:netflix_app/data/remote/dto/get_api_top_rate.dart';
import 'package:netflix_app/data/remote/dto/get_api_upcoming.dart';
import 'package:netflix_app/data/remote/dto/get_apo_trending.dart';
import 'package:netflix_app/resources/functions/movies_Type.dart';
import 'package:netflix_app/resources/widgets/Ntext_Button.dart';
import 'package:netflix_app/resources/widgets/Nfilled_button.dart';
import 'package:netflix_app/resources/widgets/Nicon_Button.dart';

class NetflixHomeScreen extends StatefulWidget {
  const NetflixHomeScreen({super.key});

  @override
  State<NetflixHomeScreen> createState() => _NetflixHomeScreenState();
}

class _NetflixHomeScreenState extends State<NetflixHomeScreen> {
  late Future<Movie?> movie;
  late Future<UpcomingMovie?> upComing;
  late Future<TrendingMovie?> trending;
  late Future<TopRateMovie?> topRate;
  late Future<PopularMovie?> popular;
  int currentIndex = 0;

  //Controllers cho PageView và ListView
  late PageController _pageController;
  late ScrollController _listViewController;
  //Timer cho auto scroll
  Timer? _pageTimer;
  Timer? _listTimer;

  //Biến theo dõi vị trí hiện tại của ListView
  int _currentListIndex = 0;

  @override
  void initState() {
    super.initState();
    popular = getDataApiPopular();
    topRate = getDataApiTopRate();
    movie = getDataApiNowPlaying();
    upComing = getDataApiUpComing();
    trending = getDataApiTrending();

    // Khởi tạo controllers
    _pageController = PageController();
    _listViewController = ScrollController();

    // Bắt đầu auto scroll cho PageView
    _startPageAutoScroll();

    // Bắt đầu auto scroll cho ListView
    _startListAutoScroll();
  }

  @override
  void dispose() {
    // Hủy bỏ timers và controllers khi widget bị dispose
    _pageTimer?.cancel();
    _listTimer?.cancel();
    _pageController.dispose();
    _listViewController.dispose();
    super.dispose();
  }

// Hàm bắt đầu auto scroll cho PageView
  void _startPageAutoScroll() {
    _pageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.hasClients) {
        setState(() {
          if (currentIndex >= 7) {
            currentIndex = 0;
          } else {
            currentIndex++;
          }
        });

        _pageController.animateToPage(
          currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

// Hàm bắt đầu auto scroll cho ListView
  void _startListAutoScroll() {
    _listTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_listViewController.hasClients) {
        setState(() {
          if (_currentListIndex >= 7) {
            _currentListIndex = 0;
            _listViewController.animateTo(
              0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            _currentListIndex++;
            _listViewController.animateTo(
              _currentListIndex * 138.0,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          }
        });
      }
    });
  }

  void _pausePageAutoScroll() {
    _pageTimer?.cancel();
  }

  void _resumePageAutoScroll() {
    _pageTimer?.cancel();
    _startPageAutoScroll();
  }

  void _pauseListAutoScroll() {
    _listTimer?.cancel();
  }

  void _resumeListAutoScroll() {
    _listTimer?.cancel();
    _startListAutoScroll();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/netflix_logo.png',
                    height: 55,
                  ),
                  Spacer(),
                  NIconButton(
                    icon: Icons.search,
                    onPress: () {},
                  ),
                  NIconButton(
                    icon: Icons.download,
                    onPress: () {},
                  ),
                  NIconButton(
                    icon: Icons.cast,
                    onPress: () {},
                  ),
                ],
              ),
              Row(
                children: [
                  NTextButton(
                    textTheme: textTheme,
                    text: 'TV Shows',
                    onPress: () {},
                  ),
                  SizedBox(width: 5.0),
                  NTextButton(
                    textTheme: textTheme,
                    text: 'Movies',
                    onPress: () {},
                  ),
                  SizedBox(width: 5.0),
                  NTextButton(
                    keyboardArrowDown: Icons.keyboard_arrow_down,
                    textTheme: textTheme,
                    text: 'Categories',
                    onPress: () {},
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: size.height * 0.6,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white38)),
                    child: FutureBuilder(
                      future: movie,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                'Get Data Error because ${snapshot.error}'),
                          );
                        } else if (snapshot.hasData && snapshot.data != null) {
                          final moviesResults = snapshot.data!.results;
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: 8,
                              onPageChanged: (value) {
                                setState(() {
                                  currentIndex = value;
                                });
                              },
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return MovieDetailedScreen(
                                            movieId: moviesResults[index].id);
                                      },
                                    ));
                                  },
                                  onPanDown: (_) {
                                    // Dừng auto scroll khi user bắt đầu vuốt
                                    _pausePageAutoScroll();
                                  },
                                  onPanEnd: (_) {
                                    // Tiếp tục auto scroll sau 3 giây khi user ngừng vuốt
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      _resumePageAutoScroll();
                                    });
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.6,
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "$imageUrl${moviesResults[index].posterPath}",
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Container(
                                        color: Colors.grey[900],
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.error_outline,
                                                color: Colors.white, size: 50),
                                            Text('Không thể tải ảnh',
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return Center(
                            child: Text('Problem to fetch data'),
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.58,
                    left: size.width * 0.35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        8,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.bounceInOut,
                          margin: const EdgeInsets.only(right: 4.0),
                          width: index == currentIndex ? 15.0 : 8.0,
                          height: 8.0,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: index == currentIndex
                                  ? Colors.blue
                                  : Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: size.height * 0.58,
                      child: Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.fromLTRB(size.height * 0.04,
                                  size.height * 0.02, size.height * 0.006, 0),
                              child: NfilledButton(
                                onPress: () {},
                                icon: Icons.play_arrow,
                                size: size,
                                text: 'Play',
                                textTheme: textTheme,
                                right: false,
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                left: size.height * 0.006,
                                top: size.height * 0.02,
                              ),
                              child: NfilledButton(
                                onPress: () {},
                                icon: Icons.add,
                                text: 'My List',
                                right: true,
                                size: size,
                                textTheme: textTheme,
                              ))
                        ],
                      ))
                ],
              ),
              SizedBox(
                height: size.height * 0.048,
              ),
              moviesType(
                listViewController: _listViewController,
                pauseListAutoScroll: _pauseListAutoScroll,
                resumeListAutoScroll: _resumeListAutoScroll,
                textTheme: textTheme,
                size: size,
                futureData: upComing,
                movieType: 'UpComing Movies',
              ),
              moviesType(
                listViewController: _listViewController,
                pauseListAutoScroll: _pauseListAutoScroll,
                resumeListAutoScroll: _resumeListAutoScroll,
                textTheme: textTheme,
                size: size,
                futureData: trending,
                movieType: 'Trending Movies',
              ),
              moviesType(
                listViewController: _listViewController,
                pauseListAutoScroll: _pauseListAutoScroll,
                resumeListAutoScroll: _resumeListAutoScroll,
                textTheme: textTheme,
                size: size,
                futureData: topRate,
                movieType: 'Top Rate Movies',
              ),
              moviesType(
                listViewController: _listViewController,
                pauseListAutoScroll: _pauseListAutoScroll,
                resumeListAutoScroll: _resumeListAutoScroll,
                textTheme: textTheme,
                size: size,
                futureData: popular,
                movieType: 'Popular Tv Series - Watch For You',
              ),
            ],
          ),
        )),
      ),
    );
  }
}
