import 'package:flutter/material.dart';

class RecipesView extends StatefulWidget {
  const RecipesView({super.key = const ValueKey('recipes_view')});

  @override
  State<RecipesView> createState() => _RecipesViewState();
}

class _RecipesViewState extends State<RecipesView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("Recipies TODO"),
    );
  }
}
