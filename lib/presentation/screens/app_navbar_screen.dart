import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:netflix_app/presentation/screens/netflix_home.screen.dart';
import 'package:netflix_app/presentation/screens/search_screen.dart';

class AppNavbarScreen extends StatelessWidget {
  const AppNavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(children: [
            NetflixHomeScreen(),
            SearchScreen(),
            Scaffold(),
          ]),
          bottomNavigationBar: Container(
            height: 70,
            padding: EdgeInsets.only(top: 10),
            color: Colors.black,
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(
                    Iconsax.home5,
                  ),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(
                    Iconsax.search_normal,
                  ),
                  text: 'Search',
                ),
                Tab(
                  icon: Icon(Icons.photo_library_outlined),
                  text: 'Hot News',
                )
              ],
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              dividerColor: Colors.black,
            ),
          ),
        ));
  }
}
