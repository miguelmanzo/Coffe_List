import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_flutter_app2/services/auth.dart';
import 'package:personal_flutter_app2/shared/loading.dart';

import '../../shared/shared.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _fromKey = GlobalKey<FormState>();
  bool loading = false;

  String error = "";
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.cyan [100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        elevation: 0,
        title: Text('Ingresa'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
        color: Colors.brown[100],
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
        child: Form(
          key: _fromKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) {
                    return "Enter an email";
                  }
                  if (!val.contains("@")) {
                    return "Where is the fucking @?";
                  } else
                    return null;
                },
                decoration: textInputDecoration.copyWith(
                    hintText: 'Email'
                ),
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Password'
                ),
                onChanged: (val) {
                setState(() {
                  password = val;
                });
              },
                validator: (val) => val.length < 6 ? "6 Characters min" : null,
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.brown[500],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.brown[100]),
                ),
                onPressed: () async {
                  if (_fromKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    print(result.toString());
                    if (result == null) {
                      setState(() {
                        loading = false;
                        error = "Could not sign in with those credentials";
                      });
                    }
                  }
                },
              )
            ],
          ),
        ),
//        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//        child: RaisedButton(
//          child: Text('Sign in Anon'),
//          onPressed: () async {
//            dynamic result = await _auth.signInAnon();
//            if(result == null){
//              print('Error signing in');
//            } else {print('Succes signing in');
//            print(result.uid);
//            }
//          },
//        ),
      ),
    );
  }
}
