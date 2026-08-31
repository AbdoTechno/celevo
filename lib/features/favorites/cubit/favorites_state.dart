import 'package:celevo/core/models/popular_person_model.dart';

abstract class FavoritesState {
  const FavoritesState();
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<PersonModel> favorites;
  final Set<int> favoriteIds;

  const FavoritesLoaded({
    required this.favorites,
    required this.favoriteIds,
  });

  bool isFavorite(int? id) {
    if (id == null) return false;
    return favoriteIds.contains(id);
  }
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);
}
