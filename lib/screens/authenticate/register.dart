import 'package:flutter/material.dart';
import 'package:personal_flutter_app2/services/auth.dart';
import 'package:personal_flutter_app2/shared/loading.dart';

import '../../shared/shared.dart';

class Register extends StatefulWidget {


  final Function toggleView;
  Register ({this.toggleView});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _fromKey = GlobalKey<FormState>();
  bool loading = false;


  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[500],
        elevation: 0,
        title: Text('Register'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () { widget.toggleView();},
              icon: Icon(Icons.person),
              label: Text('Sign In'))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 60),
        child: Form(
          key: _fromKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                    hintText: 'Email'
                ),
                validator: (val) {
                  if (val.isEmpty){ return "Enter an email";}
                  if (!val.contains("@")){ return "Where is the fucking @?";}
                  else return null;
                },
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
                obscureText: true,
                validator: (val) => val.length < 6 ? "6 Characters min" : null ,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20),
              RaisedButton(
                color: Colors.brown[500],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if(_fromKey.currentState.validate()) {
                    setState(() {
                      loading = true;
                    });
                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                  if(result == null){
                    setState(() {
                      loading = false;
                      error = "Please supply a valid email";
                    });
                  }
                  }
                  },
              ),
              SizedBox(height: 20,),
              Text(
                error,
                style: TextStyle(color: Colors.red),
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
