import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:poke_api_flutter/models/pokemon.dart';

class ApiServiceSkeleton {
  Future<List<PokemonSkeleton>> fetchPokemons() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon'));

    if (response.statusCode == 200) {
      List<dynamic> pokemonsJson = json.decode(response.body)['results'];
      return pokemonsJson
          .map((json) => PokemonSkeleton.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}

class ApiServiceByPokemon {
  Future<List<PokemonSkeleton>> fetchPokemons() async {
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/1'));

    if (response.statusCode == 200) {
      List<dynamic> pokemonsJson = json.decode(response.body)['results'];
      return pokemonsJson
          .map((json) => PokemonSkeleton.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}
