import 'package:celevo/core/models/person_details_model.dart';
import 'package:celevo/core/models/person_images_model.dart';

abstract class PersonDetailsState {
  const PersonDetailsState();
}

class PersonDetailsInitial extends PersonDetailsState {
  const PersonDetailsInitial();
}

class PersonDetailsLoading extends PersonDetailsState {
  const PersonDetailsLoading();
}

class PersonDetailsSuccess extends PersonDetailsState {
  final PersonDetailsModel details;
  final PersonImagesModel images;

  const PersonDetailsSuccess({
    required this.details,
    required this.images,
  });
}

class PersonDetailsError extends PersonDetailsState {
  final String message;

  const PersonDetailsError(this.message);
}
