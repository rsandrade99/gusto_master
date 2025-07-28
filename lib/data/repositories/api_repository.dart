import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pokemon_model.dart';

abstract class ApiRepository {
  Future<List<PokemonModel>> fetchPokemons();
}

class ApiRepositoryImpl extends ApiRepository {
  @override
  Future<List<PokemonModel>> fetchPokemons() async {
    final response = await http.get(
      Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;

      // Obtener detalles de cada Pokémon
      final List<PokemonModel> pokemons = [];

      for (var item in results) {
        final detailResponse = await http.get(Uri.parse(item['url']));
        if (detailResponse.statusCode == 200) {
          final detailData = jsonDecode(detailResponse.body);
          pokemons.add(PokemonModel.fromDetailJson(detailData));
        }
      }

      return pokemons;
    } else {
      throw Exception('Error al cargar Pokémons');
    }
  }
}
