import 'package:cloud_firestore/cloud_firestore.dart';

class Product {

  Product({this.id, this.name, this.description, this.imagens});

  Product.fromDocument(DocumentSnapshot document) {
    id = document.documentID;
    name = document['name'] as String;
    description = document['description'] as String;
    imagens = List<String>.from(document.data['imagens'] as List<dynamic>);
  }

  String id;
  String name;
  String description;
  List<String> imagens;

  CollectionReference  get firestoreRef =>
      Firestore.instance.collection('products');

  Future<void> saveData() async {
    await firestoreRef.add(toMap());
  }


  DocumentReference get documentRef =>
      Firestore.instance.document('products/$id');
  Future<void> updateData() async {
    await documentRef.setData(toMap());
  }
  Future<void> removeData() async {
    await documentRef.delete();
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'imagens':imagens,
    };
  }

}