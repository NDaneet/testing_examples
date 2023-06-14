import "package:flutter/material.dart";

class FruitCard extends StatelessWidget {
  const FruitCard({
    super.key,
    required this.fruitAssetLocation,
  });

  final String fruitAssetLocation;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        elevation: 10.0,
        child: SizedBox(
          height: 100,
          width: 60,
          child: Image.asset(
            fruitAssetLocation,
            fit: BoxFit.fitHeight,
          ),
        ));
  }
}
