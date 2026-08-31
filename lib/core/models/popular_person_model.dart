class PopularPersonModel {
  int? page;
  List<PersonModel>? results;
  int? totalPages;
  int? totalResults;

  PopularPersonModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  PopularPersonModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];

    if (json['results'] != null) {
      results = <PersonModel>[];

      json['results'].forEach((v) {
        results!.add(PersonModel.fromJson(v));
      });
    }

    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
}

class PersonModel {
  bool? adult;
  int? gender;
  int? id;
  String? knownForDepartment;
  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  List<KnownFor>? knownFor;

  PersonModel({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.knownFor,
  });

  PersonModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    originalName = json['original_name'];

    popularity = json['popularity'] != null
        ? (json['popularity'] as num).toDouble()
        : null;

    profilePath = json['profile_path'];

    if (json['known_for'] != null) {
      knownFor = <KnownFor>[];

      json['known_for'].forEach((v) {
        knownFor!.add(KnownFor.fromJson(v));
      });
    }
  }
}

class KnownFor {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;

  // TV fields
  String? name;
  String? originalName;
  String? firstAirDate;
  List<String>? originCountry;

  KnownFor({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  KnownFor.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];

    title = json['title'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];

    mediaType = json['media_type'];
    originalLanguage = json['original_language'];

    genreIds = (json['genre_ids'] as List?)
        ?.map((e) => e as int)
        .toList();

    popularity = json['popularity'] != null
        ? (json['popularity'] as num).toDouble()
        : null;

    releaseDate = json['release_date'];

    video = json['video'];
    voteAverage = json['vote_average'] != null
        ? (json['vote_average'] as num).toDouble()
        : null;

    voteCount = json['vote_count'];

    // TV
    name = json['name'];
    originalName = json['original_name'];
    firstAirDate = json['first_air_date'];

    originCountry = (json['origin_country'] as List?)
        ?.map((e) => e.toString())
        .toList();
  }
}
