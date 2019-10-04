import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemon.dart';


class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;
  PokemonDetail({this.pokemon});

  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            left: 10.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    pokemon.name,
                    style: TextStyle(fontSize: 34),
                  ),
                  Text('Height : ${pokemon.height}'),
                  Text('Wieght : ${pokemon.weight}'),
                  Text('Types'),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.type
                          .map((t) => FilterChip(
                                label: Text(t),
                                onSelected: (b) {},
                              ))
                          .toList()),
                  Text('Weakness'),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses
                          .map((t) => FilterChip(
                                label: Text(t),
                                onSelected: (b) {},
                              ))
                          .toList()),
                  Text('Next evolution'),
                  pokemon.nextEvolution == null
                      ? Text('No evolution')
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: pokemon.nextEvolution
                              .map((t) => FilterChip(
                                    label: Text(t.name),
                                    onSelected: (b) {},
                                  ))
                              .toList()),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 150.00,
                width: 150.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.cyan,
        title: Text('Detail of ${pokemon.name}'),
      ),
      body: bodyWidget(context),
    );
  }
}
