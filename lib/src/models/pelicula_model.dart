// Generated by https://quicktype.io

class Peliculas {
  List<Pelicula> lasPeliculas = [];

  Peliculas.fromJsonList(List<dynamic>? jsonList){
    if (jsonList == null) return;

    for (var item in jsonList) {
      final pelicula = Pelicula.fromJsonMap(item);
      lasPeliculas.add(pelicula);
    }
    
  }
}

class Pelicula {
  String? uniqId;
  String? posterPath;
  bool? adult;
  String? overview;
  String? releaseDate;
  List<int>? genreIds;
  int? id;
  String? originalTitle;
  String? originalLanguage;
  String? title;
  String? backdropPath;
  double? popularity;
  int? voteCount;
  bool? video;
  double? voteAverage;

  Pelicula({
    this.posterPath,
    this.adult,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video,
    this.voteAverage,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json){
    posterPath       = json['poster_path'];
    adult            = json['adult'];
    overview         = json['overview'];
    releaseDate      = json['release_date'];
    genreIds         = json['genre_ids'].cast<int>();
    id               = json['id'];
    originalTitle    = json['original_title'];
    originalLanguage = json['original_language'];
    title            = json['title'];
    backdropPath     = json['backdrop_path'];
    popularity       = json['popularity'] / 1;
    voteCount        = json['vote_count'];
    video            = json['video'];
    voteAverage      = json['vote_average'] / 1;
  }

  getPosterImg () {

    if(posterPath == null) {
      return 'https://ualr.edu/elearning/files/2020/10/No-Photo-Available.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
    
  }

  getBackgroundImg () {

    if(posterPath == null) {
      return 'https://ualr.edu/elearning/files/2020/10/No-Photo-Available.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }

  }
}

