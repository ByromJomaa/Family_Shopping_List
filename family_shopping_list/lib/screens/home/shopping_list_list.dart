import 'package:family_shopping_list/models/shopping_list.dart';
import 'package:family_shopping_list/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'shopping_list_tile.dart';

class ShoppingListList extends StatefulWidget {
  ShoppingListList({Key key}) : super(key: key);

  @override
  _ShoppingListListState createState() => _ShoppingListListState();
}

class _ShoppingListListState extends State<ShoppingListList> {
  @override
  Widget build(BuildContext context) {
    final shoppingListList = Provider.of<List<ShoppingList>>(context) ?? [];

    return shoppingListList == []
        ? Loading()
        : ListView.builder(
            itemCount: shoppingListList.length,
            itemBuilder: (context, index) {
              return ShoppingListTile(shoppingList: shoppingListList[index]);
            },
          );
  }
}
