import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:personal_flutter_app2/models/brew.dart';
import 'package:personal_flutter_app2/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  final CollectionReference dataCollection = Firestore.instance.collection("data");

  Future updateUserData(String sugars, String name, int strength) async {
    return await dataCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength
    });
  }

  //brew list from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        strength: doc.data['strength'] ?? 0,
        sugar: doc.data['sugars'] ?? '0'
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }

  Stream<List<Brew>> get brews {
    return dataCollection.snapshots()
        .map(_brewListFromSnapshot);
  }

  //get user doc stream
  Stream<UserData> get userData{
    return dataCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

}