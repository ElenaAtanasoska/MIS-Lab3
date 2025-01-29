import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/joke_model.dart';
import '../widgets/joke_card.dart';

class RandomJokeScreen extends StatelessWidget {
  const RandomJokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.pink.shade700],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Random Joke',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<Joke>(
              future: ApiService.getRandomJoke(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final joke = snapshot.data;
                return joke == null
                    ? const Center(child: Text('No joke available.'))
                    : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: JokeCard(joke: joke),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}