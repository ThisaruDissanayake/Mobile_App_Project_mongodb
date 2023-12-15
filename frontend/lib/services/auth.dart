import 'package:firebase_auth/firebase_auth.dart';
import 'package:frontend/models/UserModel.dart';
 import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  //create fb instance
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create a user from UID
  UserModel? _userWithFirebaseUserUid(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //create the stream for checking the auth changes in the user
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userWithFirebaseUserUid);
  }

  //Sign in anon
  Future signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

// signInWithGoogle() async {
//     // Trigger the authentication flow
//     final GoogleSignInAccount? googleUser = await GoogleSignIn(
//         scopes: <String>["email"]).signIn();

//     // Obtain the auth details from the request
//     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

//     // Create a new credential
//     final credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );

//     // Once signed in, return the UserCredential
//     return await FirebaseAuth.instance.signInWithCredential(credential);
//   }








  Future<UserModel?> signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>["email"]).signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with the credential
    final UserCredential authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    // Extract the user from the result
    final User? user = authResult.user;

    // Return a UserModel
    return _userWithFirebaseUserUid(user);
  } catch (err) {
    print("Error signing in with Google: $err");
    return null;
  }
}


  //register using email and pwd
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //sign in using email and pwd
  Future signinUsingEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userWithFirebaseUserUid(user);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  //sign in using gmail

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
