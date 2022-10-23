import 'package:flutter/material.dart';

class ShoppingListView extends StatefulWidget {
  const ShoppingListView({super.key = const ValueKey('shopping_list_view')});

  @override
  State<ShoppingListView> createState() => _ShoppingListViewState();
}

class _ShoppingListViewState extends State<ShoppingListView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("Shopping List TODO"),
    );
  }
}
