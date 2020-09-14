import 'package:flutter/material.dart';
import 'package:personal_flutter_app2/screens/wrapper.dart';
import 'package:personal_flutter_app2/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

//myflutterproject-c0693

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider.value(
      value: AuthService().user,
      child: MaterialApp(
//          theme: ThemeData(
//            // Define the default brightness and colors.
//            brightness: Brightness.dark,
//            primaryColor: Colors.lightBlue[800],
//            accentColor: Colors.cyan[600],
//
//            // Define the default font family.
//            fontFamily: 'Georgia',
//
//            // Define the default TextTheme. Use this to specify the default
//            // text styling for headlines, titles, bodies of text, and more.
//            textTheme: TextTheme(
//              headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//              subhead: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//              body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
//            ),
//          ),
        home: Wrapper()
      ),
    );
  }
}
