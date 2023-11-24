import 'package:flutter/material.dart';
import 'pokemon.dart';
import 'package:poke_api_flutter/services/api_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Pokemon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PokemonListPage(),
    );
  }
}

class PokemonListPage extends StatefulWidget {
  @override
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  late Future<dynamic> pokemons;

  @override
  void initState() {
    super.initState();
    pokemons = ApiServiceSkeleton().fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokémon List'),
      ),
      body: FutureBuilder<dynamic>(
        future: pokemons,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No Pokémon found"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var pokemon = snapshot.data![index];
                return ListTile(
                  title: Text(pokemon.name),
                  leading: Image.network(pokemon.imageUrl),
                );
              },
            );
          }
        },
      ),
    );
  }
}
