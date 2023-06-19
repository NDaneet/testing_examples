import "package:flutter/foundation.dart";
import 'fruits_model.dart';

class FavouriteModel extends ChangeNotifier{

  final List<Fruit> _favoriteFruits = [];

  get favoriteFruits => _favoriteFruits;

   bool containsFavourite(Fruit fruit) {
    return _favoriteFruits.contains(fruit);
   }

  void addFavouriteFruit(Fruit fruit){
    if (!containsFavourite(fruit)){
      _favoriteFruits.add(fruit);
    }
    notifyListeners();
  }

  void removeFavouriteFruit(Fruit fruit){
    _favoriteFruits.remove(fruit);
    notifyListeners();
  }
}