import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/joke_type_card.dart';

class JokeTypesScreen extends StatelessWidget {
  const JokeTypesScreen({Key? key}) : super(key: key);

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
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                'Joke Types',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  fontFamily: 'Roboto',
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: Image.asset(
                      'assets/random_button.png',
                      width: 32,
                      height: 32,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/random_joke');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: const Icon(Icons.favorite),
                    onPressed: () {
                      Navigator.pushNamed(context, '/favorites');
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: ApiService.getJokeTypes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No joke types found.'));
                  }

                  final jokeTypes = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: jokeTypes.length,
                    itemBuilder: (context, index) {
                      final type = jokeTypes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: JokeTypeCard(
                          type: type,
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/jokes_by_type',
                              arguments: type,
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}