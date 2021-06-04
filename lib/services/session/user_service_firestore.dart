// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:ps_i1/models/user.dart';
import 'package:ps_i1/services/session/user_service.dart';

firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;

const db = FirebaseFirestore;

final userCollection = FirebaseFirestore.instance.collection("users");

User fromDocumentSnapshot(DocumentSnapshot doc, String email, String password) {
  final data = doc.data();
  if (data == null || data is! Map) throw "DocumentSnapshot data error!";
  return User(
    uid: doc.id,
    name: data['name'],
    isTeacher: data['isTeacher'],
    email: email,
    password: password,
  );
}

class UserServiceFirestore extends UserService {
  @override
  Future<User?> login(String email, String password) async {
    firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((userCredential) {
      // Signed in
      print("Logado!");
      print(userCredential);
      userCollection.doc(userCredential.user!.uid).get().then((doc) {
        final user = fromDocumentSnapshot(doc, email, password);
        //Encontrou
        print("Encontrou doc");
        return user;
      }).catchError((error) {
        print("Erro ao buscar documento: ");
        print(error);
      });
    }).catchError((error) {
      // Error
      print(error.message);
    });
    return null;
  }

  @override
  Future<void> logout(User user) async {
    firebaseAuth.signOut().then((user) {
      print("saiu");
    }).catchError((Error) {
      print("erro ao sair");
      print(Error);
    });
  }
}