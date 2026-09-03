import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/repos/popular_person_repo.dart';
import 'package:celevo/features/home/cubit/popular_persons_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularPersonsCubit extends Cubit<PopularPersonsState> {
  final PopularPersonRepo _repo;

  PopularPersonsCubit(this._repo) : super(const PopularPersonsInitial());

  Future<void> getPopularPersons({int page = 1}) async {
    if (page == 1) {
      emit(const PopularPersonsLoading());
    } else {
      if (state is PopularPersonsSuccess) {
        final current = state as PopularPersonsSuccess;
        emit(current.copyWith(isLoadingMore: true));
      }
    }
    try {
      final response = await _repo.getPopularPersons(page: page);
      final newResults = response.results ?? [];
      final totalPages = response.totalPages ?? 1;
      if (page == 1) {
        emit(
          PopularPersonsSuccess(
            persons: newResults,
            filteredPersons: newResults,
            currentPage: page,
            totalPages: totalPages,
          ),
        );
      } else {
        if (state is PopularPersonsSuccess) {
          final current = state as PopularPersonsSuccess;
          final updatedPersons = [...current.persons, ...newResults];
          final filtered = _applyFilterAndSearch(
            updatedPersons,
            current.selectedDepartment,
            current.searchQuery,
          );

          emit(
            current.copyWith(
              persons: updatedPersons,
              filteredPersons: filtered,
              currentPage: page,
              totalPages: totalPages,
              isLoadingMore: false,
            ),
          );
        }
      }
    } catch (e) {
      if (page == 1) {
        emit(PopularPersonsError(e.toString().replaceAll('Exception: ', '')));
      } else if (state is PopularPersonsSuccess) {
        final current = state as PopularPersonsSuccess;
        emit(current.copyWith(isLoadingMore: false));
      }
    }
  }

  void searchPersons(String query) {
    if (state is! PopularPersonsSuccess) return;
    final current = state as PopularPersonsSuccess;
    final filtered = _applyFilterAndSearch(
      current.persons,
      current.selectedDepartment,
      query,
    );

    emit(current.copyWith(filteredPersons: filtered, searchQuery: query));
  }

  void filterByDepartment(String? department) {
    if (state is! PopularPersonsSuccess) return;
    final current = state as PopularPersonsSuccess;
    final newDep = current.selectedDepartment == department ? null : department;
    final filtered = _applyFilterAndSearch(
      current.persons,
      newDep,
      current.searchQuery,
    );

    emit(
      current.copyWith(
        filteredPersons: filtered,
        selectedDepartment: newDep,
        clearDepartment: newDep == null,
      ),
    );
  }

  List<PersonModel> _applyFilterAndSearch(
    List<PersonModel> list,
    String? department,
    String query,
  ) {
    return list.where((person) {
      final matchesDepartment =
          department == null ||
          department.isEmpty ||
          (person.knownForDepartment != null &&
              person.knownForDepartment!.toLowerCase() ==
                  department.toLowerCase());

      final matchesQuery =
          query.isEmpty ||
          (person.name != null &&
              person.name!.toLowerCase().contains(query.toLowerCase()));

      return matchesDepartment && matchesQuery;
    }).toList();
  }

  void loadNextPage() {
    if (state is! PopularPersonsSuccess) return;
    final current = state as PopularPersonsSuccess;
    if (current.isLoadingMore || current.currentPage >= current.totalPages) {
      return;
    }
    getPopularPersons(page: current.currentPage + 1);
  }
}
