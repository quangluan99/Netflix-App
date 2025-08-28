import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/common/utlis.dart';

Padding moviesType({
  void Function()? pauseListAutoScroll,
  void Function()? resumeListAutoScroll,
  ScrollController? listViewController,
  required Size size,
  required Future futureData,
  required String movieType,
  required TextTheme textTheme,
}) {
  return Padding(
    padding: EdgeInsets.only(top: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          movieType,
          style: textTheme.bodyLarge!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        SizedBox(
          height: size.height * 0.22,
          width: double.maxFinite,
          child: FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Get Data Error because ${snapshot.error}'),
                );
              } else if (snapshot.hasData && snapshot.data != null) {
                final moviesResults = snapshot.data!.results;
                return listViewController != null &&
                        resumeListAutoScroll != null &&
                        pauseListAutoScroll != null
                    ? NotificationListener<ScrollNotification>(
                        // Xử lý khi user tương tác với ListView
                        onNotification: (ScrollNotification scrollInfo) {
                          if (scrollInfo is ScrollStartNotification) {
                            pauseListAutoScroll();
                          } else if (scrollInfo is ScrollEndNotification) {
                            // Tiếp tục auto scroll sau 3 giây
                            Future.delayed(const Duration(seconds: 3), () {
                              resumeListAutoScroll();
                            });
                          }
                          return false;
                        },
                        child: ListView.builder(
                          controller: listViewController,
                          itemCount: 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: size.height * 0.15,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        "$imageUrl${moviesResults[index].posterPath}"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : ListView.builder(
                        controller: listViewController,
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: size.height * 0.15,
                              margin: EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                      "$imageUrl${moviesResults[index].posterPath}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
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
  );
}
