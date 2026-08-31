import 'package:celevo/core/models/popular_person_model.dart';

abstract class PopularPersonsState {
  const PopularPersonsState();
}

class PopularPersonsInitial extends PopularPersonsState {
  const PopularPersonsInitial();
}

class PopularPersonsLoading extends PopularPersonsState {
  const PopularPersonsLoading();
}

class PopularPersonsSuccess extends PopularPersonsState {
  final List<PersonModel> persons;
  final List<PersonModel> filteredPersons;
  final int currentPage;
  final int totalPages;
  final bool isLoadingMore;
  final String? selectedDepartment;
  final String searchQuery;

  const PopularPersonsSuccess({
    required this.persons,
    required this.filteredPersons,
    required this.currentPage,
    required this.totalPages,
    this.isLoadingMore = false,
    this.selectedDepartment,
    this.searchQuery = '',
  });

  PopularPersonsSuccess copyWith({
    List<PersonModel>? persons,
    List<PersonModel>? filteredPersons,
    int? currentPage,
    int? totalPages,
    bool? isLoadingMore,
    String? selectedDepartment,
    bool clearDepartment = false,
    String? searchQuery,
  }) {
    return PopularPersonsSuccess(
      persons: persons ?? this.persons,
      filteredPersons: filteredPersons ?? this.filteredPersons,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      selectedDepartment: clearDepartment ? null : (selectedDepartment ?? this.selectedDepartment),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class PopularPersonsError extends PopularPersonsState {
  final String message;

  const PopularPersonsError(this.message);
}
