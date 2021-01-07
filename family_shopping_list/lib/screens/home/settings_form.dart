import 'package:family_shopping_list/models/user.dart';
import 'package:family_shopping_list/services/database.dart';
import 'package:family_shopping_list/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:family_shopping_list/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  SettingsForm({Key key}) : super(key: key);

  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // Form values.
  String _currentName;
  String _currentShoppingList;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Padding(
                padding: MediaQuery.of(context).viewInsets,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(height: 1.0),
                    Text(
                      'Update your shopping list.',
                      style: TextStyle(
                        fontSize: 19.0,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0.0, 0.0),
                            blurRadius: 1,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      initialValue: userData.name,
                      decoration:
                          textInputDecoration.copyWith(labelText: 'Name'),
                      validator: (val) =>
                          val.isEmpty ? 'Please enter a name' : null,
                      onChanged: (val) => setState(() => _currentName = val),
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      initialValue: userData.shoppingList,
                      decoration: textInputDecoration.copyWith(
                          labelText: 'Shopping list'),
                      onChanged: (val) =>
                          setState(() => _currentShoppingList = val),
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.blue,
                      child: Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await DatabaseService(uid: user.uid).updateUserData(
                              _currentName ?? userData.name,
                              _currentShoppingList ?? userData.shoppingList);
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
