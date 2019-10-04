import 'package:equatable/equatable.dart';
import 'package:pokemon/model/pokemon.dart';

abstract class PokemonEvent extends Equatable {
  PokemonEvent([List props = const []]);
  List<Object> get props => [props];
}

class GetPokemon extends PokemonEvent {
  GetPokemon();

  List<Object> get props => [];
}
