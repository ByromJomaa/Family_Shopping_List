import 'package:flutter/material.dart';
import 'package:family_shopping_list/models/shopping_list.dart';

class ShoppingListTile extends StatelessWidget {
  final ShoppingList shoppingList;
  ShoppingListTile({this.shoppingList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue,
          ),
          title: Text(shoppingList.name),
          subtitle: Text('${shoppingList.shoppingList}'),
        ),
      ),
    );
  }
}
