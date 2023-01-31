class Cast {
  List<Actor> actores = [];

  Cast.fromJsonList(List<dynamic>? jsonList){
    if(jsonList == null) return;

    for (var element in jsonList) {
      final actor = Actor.fromJsonMap(element);
      actores.add(actor);
    }
  }
}

class Actor {
  int? gender;
  int? id;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  String? knownForDepartment = 'Acting';

  Actor({
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.knownForDepartment,
  });

  Actor.fromJsonMap( Map<String, dynamic> json ){
    gender             = json['gender'];
    id                 = json['id'];
    name               = json['name'];
    originalName       = json['original_name'];
    popularity         = json['popularity'];
    profilePath        = json['profile_path'];
    castId             = json['cast_id'];
    character          = json['character'];
    creditId           = json['credit_id'];
    order              = json['order'];
    knownForDepartment = json['known_for_department'];
  }

  getActorFoto(){
    if(profilePath == null){
      return 'https://ualr.edu/elearning/files/2020/10/No-Photo-Available.jpg';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}