import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_with_provider/model/favourites_model.dart';
import "../model/fruits_model.dart";
import '../components/fruit_listtile.dart';

class FruitScreen extends StatelessWidget {
  const FruitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(context),
          SliverList(
            delegate: _buildFruitsList(context),
          ),
        ],
      ),
    );
  }
}

Widget _appBar(BuildContext context) {
  return SliverAppBar(
    actions: [
      TextButton(
       child: const Text( "Favourites",),
        onPressed: (){
          Navigator.pushNamed(context, "/favourite_screen");
        },
      )
    ],
    expandedHeight: 150.0,
    backgroundColor: const Color.fromARGB(255, 218, 157, 153),
    floating: true,
    pinned: true,
    flexibleSpace: const FlexibleSpaceBar(
      expandedTitleScale: 2.5,
      title: Text(
        "Fruits",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    ),
  );
}

SliverChildDelegate _buildFruitsList(BuildContext context) {
  final favoriteModel = Provider.of<FavouriteModel>(context);
  final List<FruitListTile> fruitListTile = [];
  for (Fruit fruit in Fruits.fruitsList) {
    fruitListTile.add(
      FruitListTile(
        favoriteIcon: favoriteModel.containsFavorite(fruit)
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_border_outlined),
        fruitName: fruit.fruitName,
        fruitAssetLocation: fruit.fruitAssetLocation,
        onPressed: () {
          favoriteModel.containsFavorite(fruit)
          ? favoriteModel.removeFavouriteFruit(fruit)
          : favoriteModel.addFavouriteFruit(fruit);
        }
          )
      );
  }
  return SliverChildBuilderDelegate(
    (BuildContext context, int index) => fruitListTile[index],
    childCount: fruitListTile.length,
  );
}
