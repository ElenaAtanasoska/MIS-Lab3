import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/joke_model.dart';

class ApiService {

  static Future<List<String>> getJokeTypes() async {
    final url = Uri.parse('https://official-joke-api.appspot.com/types');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return List<String>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch joke types');
    }
  }


  static Future<List<Joke>> getJokesByType(String type) async {
    final url = Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jokes = jsonDecode(response.body);
      return jokes.map((joke) => Joke.fromJson(joke)).toList();
    } else {
      throw Exception('Failed to fetch jokes');
    }
  }


  static Future<Joke> getRandomJoke() async {
    final url = Uri.parse('https://official-joke-api.appspot.com/random_joke');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return Joke.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to fetch random joke');
    }
  }
}