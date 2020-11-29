import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;


  Future registerEmailPassword(String email, String pass, String name,
      String surname, String nickname) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      return result.user;
    }
    catch (err) {
      print(err.toString());
      return null;
    }
  }

  Future signIn(String email, String pass) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: pass);
      return result.user;
    }
    catch (err) {
      print(err.toString());
    }
  }

  Future signOut() async {
    _auth.signOut();
  }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }
}