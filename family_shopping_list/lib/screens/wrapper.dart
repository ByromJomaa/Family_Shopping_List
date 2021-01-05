import 'package:family_shopping_list/models/user.dart';
import 'package:family_shopping_list/screens/authenticate/authenticate.dart';
import 'package:family_shopping_list/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // Return either Home or Authenticate screens.
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
