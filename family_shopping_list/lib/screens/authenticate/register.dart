import 'package:family_shopping_list/services/auth.dart';
import 'package:family_shopping_list/shared/constants.dart';
import 'package:family_shopping_list/shared/loading-with-background.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  // Constructor.
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
            body: Column(
              children: <Widget>[
                SizedBox(
                  height: 135,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 65.0),
                      Text(
                        '  Family Shopping List',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.fromLTRB(15, 25, 15, 15),
                    children: <Widget>[
                      Center(
                        child: Card(
                          elevation: 8.0,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person),
                                      labelText: "Email",
                                    ),
                                    validator: (val) =>
                                        val.isEmpty ? 'Enter an email' : null,
                                    onChanged: (val) {
                                      setState(() {
                                        email = val;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      labelText: "Password",
                                    ),
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
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(30.0),
                                    //elevation: 5.0,
                                    child: MaterialButton(
                                      minWidth: 150.0,
                                      height: 50.0,
                                      color: Color(0xFF179CDF),
                                      child: Text(
                                        "REGISTER",
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      onPressed: () async {
                                        if (_formKey.currentState.validate()) {
                                          setState(() => loading = true);
                                          dynamic result = await _auth
                                              .registerWithEmailAndPassword(
                                                  email, password);

                                          if (result == null) {
                                            setState(() {
                                              error =
                                                  'Please supply a valid email & password';
                                              loading = false;
                                            });
                                          }
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Text("I already have an account.")),
                          FlatButton(
                            padding: EdgeInsets.zero,
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onPressed: () {
                              widget.toggleView();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
    // : Scaffold(
    //     backgroundColor: Colors.indigo[50],
    //     appBar: AppBar(
    //       backgroundColor: Colors.blue[300],
    //       elevation: 0.0,
    //       toolbarHeight: 70.0,
    //       title: Text(
    //         'Family Shopping List',
    //         style: TextStyle(
    //           color: Colors.black,
    //         ),
    //       ),
    //       actions: <Widget>[
    //         FlatButton.icon(
    //           icon: Icon(Icons.person),
    //           label: Text('Sign in'),
    //           onPressed: () {
    //             widget.toggleView();
    //           },
    //         ),
    //       ],
    //     ),
    //     body: Container(
    //       padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
    //       child: Form(
    //         key: _formKey,
    //         child: Column(
    //           children: <Widget>[
    //             SizedBox(height: 20.0),
    //             Text(
    //               'Sign up as a new user',
    //               textAlign: TextAlign.left,
    //               style: TextStyle(
    //                 fontSize: 20.0,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //             SizedBox(height: 30.0),
    //             TextFormField(
    //               decoration:
    //                   textInputDecoration.copyWith(hintText: 'Email'),
    //               validator: (val) => val.isEmpty ? 'Enter an email' : null,
    //               onChanged: (val) {
    //                 setState(() {
    //                   email = val;
    //                 });
    //               },
    //             ),
    //             SizedBox(height: 20.0),
    //             TextFormField(
    //               decoration:
    //                   textInputDecoration.copyWith(hintText: 'Password'),
    //               validator: (val) => val.length < 6
    //                   ? 'Enter a password 6+ chars long'
    //                   : null,
    //               obscureText: true,
    //               onChanged: (val) {
    //                 setState(() {
    //                   password = val;
    //                 });
    //               },
    //             ),
    //             SizedBox(height: 20.0),
    //             RaisedButton(
    //               color: Colors.blue[500],
    //               child: Text('Register',
    //                   style: TextStyle(color: Colors.white)),
    //               onPressed: () async {
    //                 if (_formKey.currentState.validate()) {
    //                   setState(() => loading = true);
    //                   dynamic result = await _auth
    //                       .registerWithEmailAndPassword(email, password);

    //                   if (result == null) {
    //                     setState(() {
    //                       error = 'Please supply a valid email & password';
    //                       loading = false;
    //                     });
    //                   }
    //                 }
    //               },
    //             ),
    //             SizedBox(height: 12.0),
    //             Text(
    //               error,
    //               style: TextStyle(color: Colors.red, fontSize: 14.0),
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
  }
}
