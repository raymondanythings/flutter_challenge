import 'dart:convert';

import 'package:challenge_3/models/movie_detail_model.dart';
import 'package:challenge_3/models/movie_popular_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://movies-api.nomadcoders.workers.dev";

  static Future<List<MovieModel>> getPopularMovies() async {
    final List<MovieModel> movies = [];
    final url = Uri.parse('$baseUrl/popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> moviesResponse = jsonDecode(response.body);
      final List<dynamic> results = moviesResponse['results'];

      for (var element in results) {
        movies.add(MovieModel.fromJson(element));
      }
      return movies;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getNowPlayingMovies() async {
    final List<MovieModel> movies = [];
    const endPoint = 'now-playing';
    final url = Uri.parse('$baseUrl/$endPoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> moviesResponse = jsonDecode(response.body);
      final List<dynamic> results = moviesResponse['results'];

      for (var element in results) {
        movies.add(MovieModel.fromJson(element));
      }
      return movies;
    }
    throw Error();
  }

  static Future<List<MovieModel>> getComingSoonMovies() async {
    final List<MovieModel> movies = [];
    const endPoint = 'coming-soon';
    final url = Uri.parse('$baseUrl/$endPoint');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic> moviesResponse = jsonDecode(response.body);
      final List<dynamic> results = moviesResponse['results'];

      for (var element in results) {
        movies.add(MovieModel.fromJson(element));
      }
      return movies;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieDetailById(int id) async {
    const endPoint = 'movie';
    final url = Uri.parse('$baseUrl/$endPoint?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Error();
  }
}
