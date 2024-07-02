import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthService {
  get context => null;


  ///Google Sign In
  signInWithGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication gAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
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

  ///Github Sign In
  Future<void> signInWithGithub() async {
    // GitHub 앱 설정에서 Client ID와 Secret을 가져옵니다.
    final String clientId = 'YOUR_GITHUB_CLIENT_ID';
    final String clientSecret = 'YOUR_GITHUB_CLIENT_SECRET';

    // GitHub 인증을 위한 URL
    final String redirectUrl = 'YOUR_REDIRECT_URL';
    final String authorizationEndpoint = 'https://github.com/login/oauth/authorize';
    final String tokenEndpoint = 'https://github.com/login/oauth/access_tok en';

    // GitHub 로그인을 위해 웹뷰를 엽니다.
    final String authUrl = '$authorizationEndpoint?client_id=$clientId&redirect_uri=$redirectUrl&scope=read:user%20user:email';
    // 브라우저나 웹뷰에서 URL을 열고 코드가 포함된 리디렉트를 기다립니다.
    // 여기서 리디렉트를 처리하고 인증 코드를 추출해야 합니다.
    final String authorizationCode = await getAuthorizationCodeFromWebview(authUrl, redirectUrl);

    // 인증 코드를 액세스 토큰으로 교환합니다.
    final response = await http.post(
      Uri.parse(tokenEndpoint),
      headers: {
        'Accept': 'application/json',
      },
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': authorizationCode,
        'redirect_uri': redirectUrl,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('인증 코드를 액세스 토큰으로 교환하는 데 실패했습니다');
    }

    final accessToken = jsonDecode(response.body)['access_token'];


    final OAuthCredential credential = GithubAuthProvider.credential(accessToken);
    await FirebaseAuth.instance.signInWithCredential(credential);

    var ref = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
    var snapshot = await ref.get();
    if (!snapshot.exists) {
      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
        'account_level': 1,
        'email': FirebaseAuth.instance.currentUser!.email,
        'name': FirebaseAuth.instance.currentUser!.displayName,
        'age': 0,
        'createdAt': DateTime.now().toIso8601String(),
        'profilePicture': "",
      });
    }
  }

// 인증 코드를 얻기 위해 웹뷰를 여는 더미 함수
  Future<String> getAuthorizationCodeFromWebview(String authUrl, String redirectUrl) async {
    // 이 함수는 웹뷰를 열고 리디렉트 URL에서 인증 코드를 얻기 위해 구현해야 합니다.
    // 이는 플레이스홀더이며 적절한 구현이 필요합니다.
    return 'YOUR_AUTHORIZATION_CODE';
  }


}

