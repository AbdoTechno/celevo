import 'package:celevo/core/models/person_details_model.dart';
import 'package:celevo/core/models/person_images_model.dart';
import 'package:celevo/core/repos/person_details_repo.dart';
import 'package:celevo/features/persons/cubit/person_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonDetailsCubit extends Cubit<PersonDetailsState> {
  final PersonDetailsRepo _repo;

  PersonDetailsCubit(this._repo) : super(const PersonDetailsInitial());

  Future<void> fetchPersonFullData(int personId) async {
    emit(const PersonDetailsLoading());
    try {
      final results = await Future.wait([
        _repo.getPersonDetails(personId),
        _repo.getPersonImages(personId),
      ]);

      final details = results[0] as PersonDetailsModel;
      final images = results[1] as PersonImagesModel;

      emit(PersonDetailsSuccess(
        details: details,
        images: images,
      ));
    } catch (e) {
      emit(PersonDetailsError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
