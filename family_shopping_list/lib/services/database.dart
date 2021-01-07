import 'package:family_shopping_list/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_shopping_list/models/shopping_list.dart';

class DatabaseService {
  // The uid of the user accessing the database.
  final String uid;

  // Constructor.
  DatabaseService({this.uid});

  // The Firestore collection.
  final CollectionReference shoppingListCollection =
      Firestore.instance.collection('shopping_lists');

  /// Update the user's data.
  Future updateUserData(String name, String shoppingList) async {
    return await shoppingListCollection.document(uid).setData({
      'name': name,
      'shoppingList': shoppingList,
    });
  }

  /// ShoppingList from snapshot.
  List<ShoppingList> _shoppingListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return ShoppingList(
        name: doc.data['name'] ?? '',
        shoppingList: doc.data['shoppingList'] ?? '',
      );
    }).toList();
  }

  /// UserData from snapshot.
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      shoppingList: snapshot.data['shoppingList'],
    );
  }

  /// Get ShoppingList objects from stream.
  Stream<List<ShoppingList>> get shoppingList {
    return shoppingListCollection.snapshots().map(_shoppingListFromSnapshot);
  }

  /// Get UserData objects from stream.
  Stream<UserData> get userData {
    return shoppingListCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
