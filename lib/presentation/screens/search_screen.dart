import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflix_app/common/utlis.dart';
import 'package:netflix_app/data/model/search_movie.dart';
import 'package:netflix_app/data/remote/dto/get_api_search_movie.dart';
import 'package:netflix_app/presentation/screens/movie_detailed_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future<SearchMovie?>? searchMovie;
  late TextEditingController searchController;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Bar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoSearchTextField(
              backgroundColor: Colors.grey.shade200,
              controller: searchController,
              padding: EdgeInsets.all(10),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              suffixIcon: Icon(
                Icons.cancel,
              ),
              onChanged: (value) {
                if (value.isEmpty) {
                  return;
                } else {
                  searchMovie =
                      getDataApiSearchMovie(searchController.text).then(
                    (value) {
                      return value;
                    },
                    onError: (err) {
                      return 'Lỗi phần onChanged SEARCH $err';
                    },
                  );
                  setState(() {});
                }
              },
            ),
            SizedBox(
              height: 15.h,
            ),
            searchController.text.isEmpty
                ? Center(
                    child: Text(
                      'No searchController found?',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                : searchMovie == null
                    ? Center(
                        child: Text(
                          'No searchMovie found?',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : FutureBuilder(
                        future: searchMovie,
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
                                'Get Data Error because ${snapshot.error}',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data != null) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapshot.data!.results.length,
                              itemBuilder: (context, index) {
                                final search = snapshot.data!.results[index];
                                return search.backdropPath == null
                                    ? SizedBox.shrink()
                                    : InkWell(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailedScreen(
                                                    movieId: search.id),
                                          ));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      '$imageUrl${search.backdropPath}',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 14.w,
                                              ),
                                              Expanded(
                                                  flex: 4,
                                                  child: Text(
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      search.title)),
                                              Expanded(
                                                  flex: 1,
                                                  child: Icon(Icons.alarm))
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            );
                          } else {
                            return Center(
                              child: Text(
                                'Problem to fetch data',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                        },
                      )
          ],
        ),
      ),
    );
  }
}
