class PersonDetailsModel {
  final bool? adult;
  final List<String>? alsoKnownAs;
  final String? biography;
  final String? birthday;
  final String? deathday;
  final int? gender;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? knownForDepartment;
  final String? name;
  final String? placeOfBirth;
  final double? popularity;
  final String? profilePath;

  PersonDetailsModel({
    this.adult,
    this.alsoKnownAs,
    this.biography,
    this.birthday,
    this.deathday,
    this.gender,
    this.homepage,
    this.id,
    this.imdbId,
    this.knownForDepartment,
    this.name,
    this.placeOfBirth,
    this.popularity,
    this.profilePath,
  });

  factory PersonDetailsModel.fromJson(Map<String, dynamic> json) {
    return PersonDetailsModel(
      adult: json['adult'] as bool?,
      alsoKnownAs: (json['also_known_as'] as List?)?.map((e) => e.toString()).toList(),
      biography: json['biography'] as String?,
      birthday: json['birthday'] as String?,
      deathday: json['deathday'] as String?,
      gender: json['gender'] as int?,
      homepage: json['homepage'] as String?,
      id: json['id'] as int?,
      imdbId: json['imdb_id'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      popularity: json['popularity'] != null ? (json['popularity'] as num).toDouble() : null,
      profilePath: json['profile_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'also_known_as': alsoKnownAs,
      'biography': biography,
      'birthday': birthday,
      'deathday': deathday,
      'gender': gender,
      'homepage': homepage,
      'id': id,
      'imdb_id': imdbId,
      'known_for_department': knownForDepartment,
      'name': name,
      'place_of_birth': placeOfBirth,
      'popularity': popularity,
      'profile_path': profilePath,
    };
  }
}
