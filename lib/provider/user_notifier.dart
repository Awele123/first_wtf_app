import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_wtf_app/model/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserNotifier extends ChangeNotifier {
  UserDetail? loggedInUser;

  void login(BuildContext context, String email, String password) async {
    try {
      // create user on firebase
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      //fetch user record from firestore
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .get();

      Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

      UserDetail userDetail = UserDetail.fromJson(data);

      loggedInUser = userDetail;

      // take user to home page
      Navigator.of(context).pushReplacementNamed("/home");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "error occured")));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
    notifyListeners();
  }

  Future<bool> signUp({
    required BuildContext context,
    required String userName,
    required String password,
    required String email,
  }) async {
    try {
      // create user on firebase auth
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // create userdetail object
      var userDetail = UserDetail(email: email, name: userName);

      // store user to firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(email)
          .set(userDetail.toJson());

      loggedInUser = userDetail;

      //Alert user on success
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User $userName has been created successfully")),
      );

      // take user to home page
      Navigator.of(context).pushReplacementNamed("/home");
      return true;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "error occured")));
      return false;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
      return false;
    }
  }

  void signInWithGoogle(BuildContext context) async {
    try {
      var instance = GoogleSignIn.instance;
      final GoogleSignInAccount? googleUser = await instance.authenticate();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential user = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      // create userdetail object
      var userDetail = UserDetail(
        email: user.user!.email!,
        name: user.user!.displayName ?? "No name",
        profilePicture: user.user!.photoURL ?? "",
      );

      // store user to firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userDetail.email)
          .set(userDetail.toJson());

      loggedInUser = userDetail;

      // take user to home page
      Navigator.of(context).pushReplacementNamed("/home");
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? "error occured")));
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    loggedInUser = null;
  }

  void forgotPassword(String email) {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
