import 'package:flutter/material.dart';
import '../models/joke_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Joke> _favorites = [];

  List<Joke> get favorites => List.unmodifiable(_favorites);

  void toggleFavorite(Joke joke) {
    if (_favorites.contains(joke)) {
      _favorites.remove(joke);
    } else {
      _favorites.add(joke);
    }
    notifyListeners();
  }

  bool isFavorite(Joke joke) {
    return _favorites.contains(joke);
  }
}