import 'package:firebase_auth/firebase_auth.dart';
import 'package:posts/models/user.dart';
import 'package:posts/services/database.dart';

class AuthService {

  FirebaseAuth _auth = FirebaseAuth.instance;
  Database database=new Database();

  Future registerEmailPassword(String email, String pass, String name,
      String surname, String nickname) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      UserUpdateInfo update=new UserUpdateInfo(); update.displayName=nickname;
      result.user.updateProfile(update);
      database.addUser(new User(uid:result.user.uid,name:name,surname:surname,nickname:nickname));
      result.user.sendEmailVerification();
      return result.user;
    }
    catch (err) {
      if(err.toString().contains('INVALID')){return 'The email address is badly formatted';}
      else if(err.toString().contains('ALREADY')){return 'The email address is already in use by another account';}
      return 'The password must be 6 characters long or more';
    }
  }

  Future signIn(String email, String pass) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: pass);
      return result.user;
    }
    catch (err) {
      return null;
    }

  }
  Future signOut() async {
    _auth.signOut();
  }
  Future changePassword(String current,String newone) async {
    var user=await _auth.currentUser();
    var authCredential=EmailAuthProvider.getCredential(email:user.email,password: current);
    try{
     var reAuth=await user.reauthenticateWithCredential(authCredential);
     user.updatePassword(newone);
    }catch(e){
      print(e.toString());
      if(e.toString().contains('WRONG_PASSWORD')){return 'Current password is incorrect.';}
      if(e.toString().contains('WEAK_PASSWORD')){return 'New password requires at least 6 characters';}
      return 'Unable to complete request';
    }
  }
  Future resetPassword(String email)async{
    try{
     await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      if(e.toString().contains('NOT_FOUND'))return 'User not found'; return 'Malformed email';
    }
  }

  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
  }
}