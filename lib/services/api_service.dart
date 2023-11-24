import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:poke_api_flutter/models/pokemon.dart';

class ApiServiceSkeleton {
  Future<List<Pokemon>> fetchPokemons() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));

    if (response.statusCode == 200) {
      List<dynamic> pokemonsJson = json.decode(response.body)['results'];
      final List<Pokemon> responsePokemons = [];
      for (var json in pokemonsJson) {
        var pokemon = PokemonSkeleton.fromJson(json);
        var pokemonDetails = await _fetchPokemonDetails(pokemon.url);
        responsePokemons.add(pokemonDetails);
      }
      return responsePokemons;
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }

  Future<Pokemon> _fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final pokemonsJson = json.decode(response.body);
      return Pokemon(
        image: pokemonsJson['sprites']['front_default'],
        name: pokemonsJson['name'],
        types: pokemonsJson['types'],
      );
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}
