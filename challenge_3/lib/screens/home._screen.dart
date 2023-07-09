import 'package:challenge_3/models/movie_popular_model.dart';
import 'package:challenge_3/service/api_service.dart';
import 'package:challenge_3/widgets/scroll_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<MovieModel>> popularMovies = ApiService.getPopularMovies();

  final Future<List<MovieModel>> nowPlayingMovies =
      ApiService.getNowPlayingMovies();

  final Future<List<MovieModel>> comingSoonMovies =
      ApiService.getComingSoonMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 50,
                bottom: 50,
              ),
              child: Column(
                children: [
                  FutureBuilder(
                    future: popularMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ScrollWithTitleView(
                          movieList: snapshot,
                          title: "Popular Movies",
                          width: MediaQuery.of(context).size.width * 0.85,
                        );
                      } else {
                        return const SizedBox(
                          height: 280,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                    future: nowPlayingMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ScrollWithTitleView(
                          movieList: snapshot,
                          title: "Now in Cinemas",
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          subTitle: true,
                        );
                      } else {
                        return const SizedBox(
                          height: 280,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                    future: comingSoonMovies,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ScrollWithTitleView(
                          movieList: snapshot,
                          title: "Coming soon",
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * 0.4,
                          subTitle: true,
                        );
                      } else {
                        return const SizedBox(
                          height: 280,
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
