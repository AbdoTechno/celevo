import 'package:celevo/core/models/popular_person_model.dart';
import 'package:celevo/core/repos/favorites_repo.dart';
import 'package:celevo/features/favorites/cubit/favorites_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoritesRepo _repo;

  FavoritesCubit(this._repo) : super(const FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());
    try {
      final list = await _repo.getFavorites();
      final ids = list.map((p) => p.id).whereType<int>().toSet();
      emit(FavoritesLoaded(favorites: list, favoriteIds: ids));
    } catch (e) {
      emit(FavoritesError('Failed to load favorites: $e'));
    }
  }

  Future<void> toggleFavorite(PersonModel person) async {
    try {
      await _repo.toggleFavorite(person);
      final list = await _repo.getFavorites();
      final ids = list.map((p) => p.id).whereType<int>().toSet();
      emit(FavoritesLoaded(favorites: list, favoriteIds: ids));
    } catch (e) {
      emit(FavoritesError('Failed to update favorite: $e'));
    }
  }

  Future<void> removeFavorite(int id) async {
    try {
      await _repo.removeFavorite(id);
      final list = await _repo.getFavorites();
      final ids = list.map((p) => p.id).whereType<int>().toSet();
      emit(FavoritesLoaded(favorites: list, favoriteIds: ids));
    } catch (e) {
      emit(FavoritesError('Failed to remove favorite: $e'));
    }
  }
}
