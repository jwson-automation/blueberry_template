import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  get context => null;


  ///Google Sign In
  signInWithGoogle() async {
    ///Begin interactive sign in process
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    ///obtaiin auth details from request
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    ///create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    ///finally, lets sign in
    await FirebaseAuth.instance.signInWithCredential(credential);
    var ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await ref.get();
    if(!snapshot.exists){
      return await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'account_level' : 1,
        //account_level이 0이되면 Delete timestamp확인하여 14일 뒤 삭제
        'email' : FirebaseAuth.instance.currentUser!.email,
        'name' : FirebaseAuth.instance.currentUser!.displayName,
        'age' : 0,
        'createdAt' : DateTime.timestamp(),
        'profilePicture' : "",
      }
      );
    }
  }

  ///Apple Sign In
  signInWithApple() async {
    final appleIdCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    var ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await ref.get();
    if(!snapshot.exists){
      return await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'account_level' : 1,
        //account_level이 0이되면 Delete timestamp확인하여 14일 뒤 삭제
        'email' : FirebaseAuth.instance.currentUser!.email,
        'name' : FirebaseAuth.instance.currentUser!.displayName,
        'age' : 0,
        'createdAt' : DateTime.timestamp(),
        'profilePicture' : "",
      }
      );
    }
  }


}

