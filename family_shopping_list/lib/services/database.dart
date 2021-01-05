import 'package:family_shopping_list/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_shopping_list/models/brew.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // Collection reference
  final CollectionReference brewCollection =
      Firestore.instance.collection('brews');

  /// Update the user's data.
  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  /// Brew list from snapshot.
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '',
        strength: doc.data['strength'] ?? '',
      );
    }).toList();
  }

  /// UserData from snapshot.
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      strength: snapshot.data['strength'],
      sugars: snapshot.data['sugars'],
    );
  }

  /// Get brews stream.
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  /// Get user doc stream.
  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
