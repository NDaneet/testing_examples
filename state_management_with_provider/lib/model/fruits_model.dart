class Fruit {
  Fruit(this.fruitName, this.fruitAssetLocation);

  String fruitName;
  String fruitAssetLocation;
}


class Fruits {
  static Map<String, String> fruitsMap = {
    "Almond": "assets/almond.png",
    "Apple": "assets/apple.png",
    "Banana": "assets/banana.png",
    "Blueberry": "assets/blueberry.png",
    "Cherrie": "assets/cherrie.png",
    "Dragon Fruit": "assets/dragon_fruit.png",
    "Dried Fruit": "assets/dried_fruit.png",
    "Durian": "assets/durian.png",
    "Egg Plant": "assets/eggplant.png",
    "Grape": "assets/grape.png",
    "Lemon": "assets/lemon.png",
    "Orange": "assets/orange.png",
    "Passion Fruit": "assets/passion_fruit.png",
    "Pineapple": "assets/pineapple.png",
    "Strawberry": "assets/strawberry.png",
    "Watermelon": "assets/watermelon.png",
  };

  static List<Fruit> fruitsList = fruitsMap.entries
      .map(
        (entries) => Fruit(entries.key, entries.value))
      .toList();
}

