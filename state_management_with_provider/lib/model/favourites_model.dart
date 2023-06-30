import "package:flutter/foundation.dart";
import 'fruits_model.dart';

class FavouriteModel extends ChangeNotifier{

  final List<Fruit> _favouriteFruits = [];

  get favouriteFruits => _favouriteFruits;

   bool containsFavourite(Fruit fruit) {
    return _favouriteFruits.contains(fruit);
   }

  void addFavouriteFruit(Fruit fruit){
    if (!containsFavourite(fruit)){
      _favouriteFruits.add(fruit);
    }
    notifyListeners();
  }

  void removeFavouriteFruit(Fruit fruit){
    _favouriteFruits.remove(fruit);
    notifyListeners();
  }
}