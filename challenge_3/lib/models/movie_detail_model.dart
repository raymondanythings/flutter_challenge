class MovieDetailModel {
  final int id, runtime;
  final String originalTitle, overview, posterPath, title, backdropPath;
  final List<dynamic> genres;
  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : originalTitle = json['original_title'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        title = json['title'],
        backdropPath = json['backdrop_path'],
        id = json['id'],
        runtime = json['runtime'],
        genres = json['genres'];
}
