import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/data/model/movie_model.dart';
import 'package:netflix_app/data/remote/api_services.dart';
import 'package:netflix_app/resources/widgets/Nelevated_Button.dart';
import 'package:netflix_app/resources/widgets/Nicon_Button.dart';

class NetflixHomeScreen extends StatefulWidget {
  const NetflixHomeScreen({super.key});

  @override
  State<NetflixHomeScreen> createState() => _NetflixHomeScreenState();
}

class _NetflixHomeScreenState extends State<NetflixHomeScreen> {
  late Future<Movie?> movie;

  Future<Movie?> getApiMovie() async {
    try {
      final dataApi = await ApiServices().getApi();
      if (dataApi != null) {
        debugPrint('mv variable get data successfully!');
        return dataApi;
      } else {
        debugPrint('mv variable get data Failed???!');
        return null;
      }
    } catch (err) {
      debugPrint("getApiMovie Fall because $err");
      return null;
    }
  }

  @override
  void initState() {
    movie = getApiMovie();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/netflix_logo.png',
                  height: 50,
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
            Container(
              height: size.height * 0.6,
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white38)),
              child: FutureBuilder(
                future: movie,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Get Data Error because ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    final moviesResults = snapshot.data!.results;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: PageView.builder(
                        itemCount: moviesResults.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: size.height * 0.6,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        "$imageUrl${moviesResults[index].posterPath}"),
                                    fit: BoxFit.cover),
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
          ],
        ),
      )),
    );
  }
}
