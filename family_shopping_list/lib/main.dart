import 'package:family_shopping_list/screens/wrapper.dart';
import 'package:family_shopping_list/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The root of the app widget tree.
    return StreamProvider<User>.value(
      // The StreamProvider should provide User objects
      // to sub widgets.
      value: AuthService().user,
      child: MaterialApp(
        title: 'Family Shopping List',
        // The Wrapper widget which returns either the
        // authentication page or the home page.
        home: Wrapper(),
      ),
    );
  }
}
