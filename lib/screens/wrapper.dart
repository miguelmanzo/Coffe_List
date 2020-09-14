import 'package:flutter/material.dart';
import 'package:personal_flutter_app2/screens/authenticate/authenticate.dart';
import 'package:personal_flutter_app2/screens/home/home.dart';
import 'package:provider/provider.dart';
import 'package:personal_flutter_app2/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    if(user== null){
      return Authenticate();
    } else {
    return Home();
    }

    //return authenticate or home
    return Authenticate();
  }
}
