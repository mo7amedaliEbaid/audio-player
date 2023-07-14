part of 'cubit.dart';

class AuthDataProvider {
//  static final firebaseFirestore = FirebaseFirestore.instance;

  static Future<User> login(String email, String password) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      User user = (await FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password))
          .user!;

      prefs.setString(user.uid, user.uid);

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "wrong-password":
          throw Exception("Invalid password. Try again!");

        case "user-not-found":
          throw Exception("Account not found, please sign up!");

        case "invalid-email":
          throw Exception("Invalid email address!");

        case "account-exists-with-different-credential":
          throw Exception("Account already logged in");

        default:
          throw Exception(
            e.message,
          );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<User> signUp(
    String fullName,
    String email,
    String password,
  ) async {
    try {
      User user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user!;

      await user.updateDisplayName(fullName);

      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw Exception("Email already in use, Try with different Email");
        case "invalid-email":
          throw Exception("Invalid email address!");
        case "account-exists-with-different-credential":
          throw Exception("Account already logged in");
        default:
          throw Exception(e.message);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<UserInfo> loginProviderInfo =
          FirebaseAuth.instance.currentUser!.providerData;

      await prefs.remove(FirebaseAuth.instance.currentUser!.uid);

      for (var prov in loginProviderInfo) {
        if (prov.providerId.contains('password')) {
          await FirebaseAuth.instance.signOut();
        } else if (prov.providerId.contains('google.com')) {
          await GoogleSignIn().signOut();
        } else if (prov.providerId.contains('facebook.com')) {}
      }

      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
  }

  static Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No account has been registered against this Email');
      }
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<User?> googleSignIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final googleAuth = await googleUser.authentication;

      final creds = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential user =
          await FirebaseAuth.instance.signInWithCredential(creds);

      prefs.setString(user.user!.uid, user.user!.uid);

      return user.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
/*
  static Future<User?> facebookSignIn() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.accessToken == null) {
        return null;
      }

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      UserCredential? user = await FirebaseAuth.instance
          .signInWithCredential(facebookAuthCredential);

      if (user.user == null) {
        return null;
      }

      prefs.setString(user.user!.uid, user.user!.uid);

      return user.user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }*/
}
