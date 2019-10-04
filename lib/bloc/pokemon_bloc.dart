import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:pokemon/model/pokemon.dart';
import 'package:http/http.dart' as http;
import './bloc.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  @override
  PokemonState get initialState => InitialPokemonState();

  @override
  Stream<PokemonState> mapEventToState(
    PokemonEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is GetPokemon) {
      print('Try get pokemons');
      yield LoadingPokemonState();
      List<Pokemon> pokemons = await _fetchPokemon();
      print('get pokemons ${pokemons[0].name}');
      yield LoadedPokemonState(pokemons);
    }
  }

  _fetchPokemon() async {
    var url =
        "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

    var res = await http.get(url);
    var decodedJson = jsonDecode(res.body);
    return PokeHub.fromJson(decodedJson).pokemon;
  }
}
