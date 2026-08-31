class PersonImagesModel {
  final int? id;
  final List<ProfileImageModel>? profiles;

  PersonImagesModel({
    this.id,
    this.profiles,
  });

  factory PersonImagesModel.fromJson(Map<String, dynamic> json) {
    return PersonImagesModel(
      id: json['id'] as int?,
      profiles: (json['profiles'] as List?)
          ?.map((v) => ProfileImageModel.fromJson(v as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'profiles': profiles?.map((v) => v.toJson()).toList(),
    };
  }
}

class ProfileImageModel {
  final double? aspectRatio;
  final String? filePath;
  final int? height;
  final int? width;
  final double? voteAverage;
  final int? voteCount;

  ProfileImageModel({
    this.aspectRatio,
    this.filePath,
    this.height,
    this.width,
    this.voteAverage,
    this.voteCount,
  });

  factory ProfileImageModel.fromJson(Map<String, dynamic> json) {
    return ProfileImageModel(
      aspectRatio: json['aspect_ratio'] != null ? (json['aspect_ratio'] as num).toDouble() : null,
      filePath: json['file_path'] as String?,
      height: json['height'] as int?,
      width: json['width'] as int?,
      voteAverage: json['vote_average'] != null ? (json['vote_average'] as num).toDouble() : null,
      voteCount: json['vote_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aspect_ratio': aspectRatio,
      'file_path': filePath,
      'height': height,
      'width': width,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}
