import 'package:applojavirtualguilherme/helpers/firebase_errors.dart';
import 'package:applojavirtualguilherme/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class UserManager extends ChangeNotifier {
  userManager() {
    _loadingCurrentUser();
    //loading = false;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final Firestore firestore = Firestore.instance;
  //FirebaseUser user;
  User user;

  bool _loading = false;

  bool get loading => _loading;

  bool get isLoggedIn => user != null;

  Future<void> signIn({User user, Function onFail, Function onSuccess}) async {
    loading = true;
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      //this.user = result.user;
      //print(result.user.uid);
      //await Future.delayed(Duration(seconds: 14));
      await _loadCurrentUser(firebaseUser: result.user);
      onSuccess();
    } on PlatformException catch (e) {
      //print(getErrorString(e.code));
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  Future<void> signUp({User user, Function onFail, Function onSucess}) async {
    loading = true;
    try{
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: user.email, password:user.password);
      //this.user = result.user;

      user.id = result.user.uid;
      this.user = user;

      await user.saveData();

      onSucess();
    } on PlatformException catch (e){
      onFail(getErrorString(e.code));
    }
    loading = false;
  }

  void signOut(){
    auth.signOut();
    user = null;
    notifyListeners();
  }

  set loading(bool value) {
    _loading = value; //igual ao valor recebido
    notifyListeners();
  }

  //notifyListeners();

  void _loadingCurrentUser() {
    auth.currentUser();
  }

  Future<void> _loadCurrentUser({FirebaseUser firebaseUser}) async {
    //final FirebaseUser currentUser = await auth.currentUser();
    final FirebaseUser currentUser = firebaseUser ?? await auth.currentUser();

    if (currentUser != null) {
      final DocumentSnapshot docUser = await firestore.collection('users')
          .document(currentUser.uid).get();
      user = User.fromDocument(docUser);
    }
    notifyListeners();
  }
}
