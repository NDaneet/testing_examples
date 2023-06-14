import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/favorite_listtile.dart';
import '../model/favourites_model.dart';
import '../model/fruits_model.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ///removed the context of appbar to see if it will work
          _appBar(),
          SliverList(
            delegate: _buildFavouriteFruitsList(context),
          ),
        ],
      ),
    );

    }

//remove the context
  SliverAppBar _appBar(){
  return const SliverAppBar(
    expandedHeight: 150.0,
    backgroundColor: Color.fromARGB(255, 218, 157, 153),
    floating: true,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      expandedTitleScale: 2.5,
      title: Text(
        "Favourites",
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
    ),
  );
}

  SliverChildDelegate _buildFavouriteFruitsList(BuildContext context){
    FavouriteModel favouriteList = Provider.of<FavouriteModel>(context);
    final List<FavouriteFruitListTile> favouriteFruitListTile = [];
  for (Fruit fruit in favouriteList.favoriteFruits) {
    favouriteFruitListTile.add(
      FavouriteFruitListTile(
        fruitName: fruit.fruitName,
        fruitAssetLocation: fruit.fruitAssetLocation,));
  }
    return SliverChildBuilderDelegate(
    (BuildContext context, int index) => favouriteFruitListTile[index],
    childCount: favouriteFruitListTile.length,
    );
  }
}