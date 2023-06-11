import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pamlfirebase/model/usermdl.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  bool get succes => false;

  Future<UserMdl?> signInWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await usersCollection.doc(user.uid).get();

        final UserMdl currentUser = UserMdl(
          uId: user.uid,
          email: user.email ?? '',
          name: snapshot['name'],
        );
        return currentUser;
      }
    } catch (e) {
      print('Error Signing In: $e');
    }
    return null;
  }

  Future<UserMdl?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final UserMdl newUser = UserMdl(
          uId: user.uid,
          email: user.email ?? '',
          name: name,
        );

        await usersCollection.doc(user.uid).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print('Error signin in : $e');
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
