import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  //User({this.email, this.password});
  User({this.email, this.password, this.name, this.cpf, this.cidade, this.siglaEstado, this.id});

  User.fromDocument(DocumentSnapshot document){
    id = document.documentID;
    name = document.data['name'] as String;
    email = document.data['email'] as String;
    cpf = document.data['cpf'] as String;
    /*if (document.data.containsKey('address')) {
      address = Address.fromMap(
          document.data['address'] as Map<String, dynamic>);
    }*/
  }

  String id;
  String name;
  String email;
  String password;
  String cpf;
  String cidade;
  String siglaEstado;

  String confirmPassword;

  bool admin = false;

  //Address address;

  DocumentReference get firestoreRef =>
      Firestore.instance.document('users/$id');

  CollectionReference get cartReference =>
      firestoreRef.collection('cart');

  CollectionReference get tokensReference =>
      firestoreRef.collection('tokens');

  Future<void> saveData() async {
    await firestoreRef.setData(toMap());
  }

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'email': email,
      if(cpf != null)
        'cpf': cpf
    };
  }

}