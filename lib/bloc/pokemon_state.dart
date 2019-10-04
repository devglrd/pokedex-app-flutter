import 'package:equatable/equatable.dart';
import 'package:pokemon/model/pokemon.dart';

abstract class PokemonState extends Equatable {
  PokemonState([List props = const []]);
  List<Object> get props => [props];
}

class InitialPokemonState extends PokemonState {
  @override
  List<Object> get props => [];
}

class LoadingPokemonState extends PokemonState {}

class LoadedPokemonState extends PokemonState {
  final List<Pokemon> pokemons;

  LoadedPokemonState(this.pokemons);
  List<Object> get props => [this.pokemons];
}
