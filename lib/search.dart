import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/bloc/bloc.dart';
import 'package:pokemon/model/pokemon.dart';

class DataSearch extends SearchDelegate<String> {
  final ValueChanged<Pokemon> onSelected;
  final PokemonBloc bloc;
  DataSearch(this.onSelected, this.bloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    // ACTION FOR APP BAR
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result base and the selection
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searcch something

    return Container(
      child: BlocListener(
        bloc: this.bloc,
        listener: (context, state) {},
        child: BlocBuilder(
          bloc: this.bloc,
          builder: (context, state) {
            if (state is InitialPokemonState) {
              this.bloc.dispatch(GetPokemon());
            } else if (state is LoadingPokemonState) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedPokemonState) {
              var suggestionList = query.isEmpty
                  ? state.pokemons
                  : state.pokemons
                      .where((p) => p.name.startsWith(query))
                      .toList();
              return ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  onTap: () {
                    this.onSelected(suggestionList[index]);
                  },
                  leading: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(suggestionList[index].img))),
                  ),
                  title: RichText(
                      text: TextSpan(
                          text: suggestionList[index]
                              .name
                              .substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                            text: suggestionList[index]
                                .name
                                .substring(query.length),
                            style: TextStyle(color: Colors.grey)),
                      ])),
                ),
                itemCount: suggestionList.length,
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
