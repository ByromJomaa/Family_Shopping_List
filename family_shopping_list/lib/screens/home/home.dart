import 'package:family_shopping_list/models/shopping_list.dart';
import 'package:family_shopping_list/screens/home/settings_form.dart';
import 'package:family_shopping_list/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:family_shopping_list/services/database.dart';
import 'package:provider/provider.dart';
import 'package:family_shopping_list/screens/home/shopping_list_list.dart';

class Home extends StatelessWidget {
  // The Firebase auth service.
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // Builds the settings panel.
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SettingsForm(),
          );
        },
      );
    }

    // The home page widget tree.
    return StreamProvider<List<ShoppingList>>.value(
      value: DatabaseService().shoppingList,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Family Shopping List',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.blue[300],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Log out'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('Settings'),
              onPressed: () => _showSettingsPanel(),
            ),
          ],
        ),
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage('assets/coffee_bg.png'),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          child: ShoppingListList(),
        ),
      ),
    );
  }
}
