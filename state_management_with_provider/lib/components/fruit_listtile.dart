import "package:flutter/material.dart";
import "fruit_card.dart";

class FruitListTile extends StatelessWidget {
  const FruitListTile(
      {super.key,
      required this.fruitAssetLocation,
      required this.fruitName,
      this.trailing});

  final String fruitAssetLocation;
  final String fruitName;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 236, 226, 226),
      child: ListTile(
        leading: FruitCard(
          fruitAssetLocation: fruitAssetLocation,
        ),
        title: Text(
          textAlign: TextAlign.center,
          fruitName,
          style: const TextStyle(
            fontSize: 19.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: trailing
      ),
    );
  }
}