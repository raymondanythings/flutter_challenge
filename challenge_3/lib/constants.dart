class Constants {
  static const imageBase = 'https://image.tmdb.org/t/p/w500/';

  static String makeImagePath(String url) {
    return "$imageBase$url";
  }
}
