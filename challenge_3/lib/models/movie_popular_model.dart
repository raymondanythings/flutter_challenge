class MovieModel {
  final int id;
  final String originalTitle, overview, posterPath, title, backdropPath;
  MovieModel.fromJson(Map<String, dynamic> json)
      : originalTitle = json['original_title'],
        overview = json['overview'],
        posterPath = json['poster_path'],
        title = json['title'],
        backdropPath = json['backdrop_path'],
        id = json['id'];
}
