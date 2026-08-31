import 'dart:convert';
import 'dart:io';
import 'package:celevo/core/models/popular_person_model.dart';
import 'package:path_provider/path_provider.dart';

class FavoritesRepo {
  static const String _fileName = 'favorite_persons.json';

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<List<PersonModel>> getFavorites() async {
    try {
      final file = await _getFile();
      if (!await file.exists()) {
        return [];
      }
      final content = await file.readAsString();
      if (content.trim().isEmpty) return [];
      final List<dynamic> jsonList = jsonDecode(content);
      return jsonList
          .map((item) => PersonModel.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  Future<bool> isFavorite(int id) async {
    final favorites = await getFavorites();
    return favorites.any((person) => person.id == id);
  }

  Future<void> toggleFavorite(PersonModel person) async {
    final favorites = await getFavorites();
    final existingIndex = favorites.indexWhere((p) => p.id == person.id);

    if (existingIndex >= 0) {
      favorites.removeAt(existingIndex);
    } else {
      favorites.insert(0, person);
    }

    final file = await _getFile();
    await file.writeAsString(
      jsonEncode(favorites.map((p) => p.toJson()).toList()),
    );
  }

  Future<void> removeFavorite(int id) async {
    final favorites = await getFavorites();
    favorites.removeWhere((p) => p.id == id);
    final file = await _getFile();
    await file.writeAsString(
      jsonEncode(favorites.map((p) => p.toJson()).toList()),
    );
  }
}
