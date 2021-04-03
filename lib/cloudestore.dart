import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  final CollectionReference store =
      FirebaseFirestore.instance.collection('Users');
  Future<void> storeData(String name, String mail, String uid) async {
    return await store.doc(uid).set({'name': name, 'mail': mail});
  }
}
