import 'package:family_shopping_list/services/auth.dart';
import 'package:family_shopping_list/shared/constants.dart';
import 'package:family_shopping_list/shared/loading-with-background.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  // Constructor.
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // The Firebase auth service.
  final AuthService _auth = AuthService();

  // The register form key.
  final _formKey = GlobalKey<FormState>();

  // Show loading screen.
  bool loading = false;

  // Text field state.
  String email = '';
  String password = '';

  // Error text state.
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingWithBackground()
        : Scaffold(
            backgroundColor: Colors.indigo[50],
            appBar: AppBar(
              backgroundColor: Colors.blue[300],
              elevation: 0.0,
              toolbarHeight: 70.0,
              title: Text(
                'Family Shopping List',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    Text(
                      'Sign in',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Email'),
                      validator: (val) => val.isEmpty ? 'Enter an email' : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Enter a password 6+ chars long'
                          : null,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    RaisedButton(
                      color: Colors.blue[500],
                      child: Text('Sign in',
                          style: TextStyle(color: Colors.white)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error =
                                  'Please supply a correct email & password';
                              loading = false;
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
