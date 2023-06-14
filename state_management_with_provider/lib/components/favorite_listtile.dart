import "package:flutter/material.dart";
import "fruit_card.dart";

class FavouriteFruitListTile extends StatelessWidget {
  const FavouriteFruitListTile({
    super.key,
    required this.fruitAssetLocation,
    required this.fruitName,
  });

  final String fruitAssetLocation;
  final String fruitName;


  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 236, 226, 226),
      child: ListTile(
          leading: FruitCard(
            fruitAssetLocation: fruitAssetLocation,
          ),
          title: Text(
            fruitName,
            style: const TextStyle(
              fontSize: 19.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
    );
  }
}
