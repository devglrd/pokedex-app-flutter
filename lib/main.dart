import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/bloc/bloc.dart';
import 'package:pokemon/model/pokemon.dart';
import 'package:pokemon/pokemonDetail.dart';
import 'bloc/pokemon_bloc.dart';
import 'bloc/pokemon_state.dart';
import 'search.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Poke App",
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokeHub pokeHub;

  final PokemonBloc pokeBloc = PokemonBloc();

  @override
  void initState() {
    pokeBloc.dispatch(GetPokemon());
    super.initState();
  }

  _selectedSearch(Pokemon pokemon) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PokemonDetail(
                  pokemon: pokemon,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poke App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: DataSearch((pokemon) => _selectedSearch(pokemon), pokeBloc));
            },
          )
        ],
        backgroundColor: Colors.cyan,
      ),
      body: BlocProvider<PokemonBloc>(
        builder: (BuildContext context) => pokeBloc,
        child: PokemonListPage(),
      ),
      drawer: Drawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => pokeBloc.dispatch(GetPokemon()),
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class PokemonListPage extends StatefulWidget {
  PokemonListPage({Key key}) : super(key: key);

  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocListener(
        bloc: BlocProvider.of<PokemonBloc>(context),
        listener: (context, state) {},
        child: BlocBuilder(
          bloc: BlocProvider.of<PokemonBloc>(context),
          builder: (context, state) {
            if (state is InitialPokemonState) {
              BlocProvider.of<PokemonBloc>(context).dispatch(GetPokemon());
            } else if (state is LoadingPokemonState) {
              return Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedPokemonState) {
              return GridView.count(
                crossAxisCount: 2,
                children:
                    state.pokemons.map((Pokemon e) => PokeCard(e)).toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class PokeCard extends StatelessWidget {
  final Pokemon pokemon;
  PokeCard(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PokemonDetail(
                          pokemon: pokemon,
                        )))
          },
          child: Hero(
            tag: pokemon.img,
            child: Card(
              elevation: 2.0,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        image:
                            DecorationImage(image: NetworkImage(pokemon.img))),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.normal,
                        color: Colors.cyan),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
