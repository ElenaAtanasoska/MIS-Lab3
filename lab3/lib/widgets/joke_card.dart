import 'package:flutter/material.dart';
import '../models/joke_model.dart';
import '../providers/favorite_joke_provider.dart';
import 'package:provider/provider.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({Key? key, required this.joke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pink.shade50, Colors.white],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  joke.setup,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  joke.punchline,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFFC66687),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    favoritesProvider.isFavorite(joke)
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favoritesProvider.isFavorite(joke)
                        ? Colors.red
                        : Colors.grey,
                  ),
                  onPressed: () {
                    favoritesProvider.toggleFavorite(joke);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}