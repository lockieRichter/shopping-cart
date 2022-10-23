import 'package:flutter/material.dart';

class RecipiesView extends StatefulWidget {
  const RecipiesView({super.key = const ValueKey('recipes_view')});

  @override
  State<RecipiesView> createState() => _RecipiesViewState();
}

class _RecipiesViewState extends State<RecipiesView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("Recipies TODO"),
    );
  }
}
