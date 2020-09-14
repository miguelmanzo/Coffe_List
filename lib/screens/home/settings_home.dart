import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_flutter_app2/models/user.dart';
import 'package:personal_flutter_app2/services/database.dart';
import 'package:personal_flutter_app2/shared/shared.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1', '2', '3', '4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    print( "User: " + user.uid);

    return StreamBuilder<UserData>(

      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          UserData user = snapshot.data;
          print(user.strength);
          print(user.sugars);
          print(user.name);

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: _currentName ?? user.name,
                  decoration: textInputDecoration,
                  validator: (val) {
                    if (val.isEmpty) {
                      return "Enter a name";
                    } else
                      return null;
                  },
                  onChanged: (val) {
                    setState(() {
                      _currentName = val;
                    });
                  },
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: textInputDecoration,

                  value: _currentSugars ?? user.sugars,
                  items: sugars.map((sugar) {
                    return DropdownMenuItem(
                      value: sugar,
                      child: Text('${sugar} sugars'),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentSugars = val),
                ),
                SizedBox(height: 20),
                Slider(
                  min: 100,
                  max: 900,
                  divisions: 8,
                  onChanged: (val) =>
                      setState(() => _currentStrength = val.round()),
                  value: (_currentStrength ?? user.strength).toDouble(),
                  activeColor: Colors.brown[_currentStrength ?? user.strength],
                  inactiveColor: Colors.brown[_currentStrength ?? user.strength],
                ),
                SizedBox(height: 20),
                RaisedButton(
                  color: Colors.blue,
                  child: Text("Update"),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                   await DatabaseService(uid: user.uid).updateUserData(
                        _currentSugars ?? snapshot.data.sugars,
                        _currentName ?? snapshot.data.name,
                        _currentStrength ?? snapshot.data.strength);
                    }
                    Navigator.pop(context);
                  }
                )
              ],
            ),
          );
        } else return Text('tet');
      }
    );
  }
}
