import 'package:flutter/material.dart';

class MenuView extends StatefulWidget {
  const MenuView({super.key = const ValueKey('menu_view')});

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("Menu TODO"),
    );
  }
}
