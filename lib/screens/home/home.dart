
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:personal_flutter_app2/models/brew.dart';
import 'package:personal_flutter_app2/screens/home/settings_home.dart';
import 'package:personal_flutter_app2/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:personal_flutter_app2/services/database.dart';
import 'brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {


    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
         title: Text('Coffe List'),
         backgroundColor: Colors.brown[500],
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person, color: Colors.white),
              label:  Text('logout'),
              textColor: Colors.white,
              onPressed: () async {
                  await _auth.signOut();
              },
            ),
            FlatButton.icon(
              icon: Icon(Icons.settings, color: Colors.white),
              label:  Text(''),
              onPressed: () {
                _showSettingsPanel();
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage (
            image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover
          ),
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
