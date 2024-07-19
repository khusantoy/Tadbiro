import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UsersFirebaseServices {
  final _usersCollection = FirebaseFirestore.instance.collection('users');
  final _usersImageStorage = FirebaseStorage.instance;

  Stream<QuerySnapshot> getUsers() async* {
    yield* _usersCollection.snapshots();
  }

  Future<void> addUser(
    String fullName,
    String email,
    File imageFile,
  ) async {
    final imageReference = _usersImageStorage
        .ref()
        .child("users")
        .child("images")
        .child("$fullName.jpg");

    final uploadTask = imageReference.putFile(imageFile);

    await uploadTask.whenComplete(() async {
      final imageUrl = await imageReference.getDownloadURL();
      await _usersCollection.add({
        "username": fullName,
        "email": email,
        "imageUrl": imageUrl,
        "deniedEvents": [],
      });
    });
  }

  // Function to get user data by email
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserByEmail(
      String email) async {
    final querySnapshot =
        await _usersCollection.where('email', isEqualTo: email).get();

    return querySnapshot.docs.first;
  }

  Future<void> editUser(
    String? fullName,
    File? imageFile,
  ) async {
    final Map<String, dynamic> updatedData = {};
    final userId = FirebaseAuth.instance.currentUser?.uid;

    print("---------------");
    print(userId);
    print("---------------");

    if (fullName != null) {
      updatedData['username'] = fullName;
    }

    if (imageFile != null) {
      final imageReference = _usersImageStorage
          .ref()
          .child("users")
          .child("images")
          .child("$userId.jpg");

      final uploadTask = imageReference.putFile(imageFile);
      await uploadTask.whenComplete(() async {
        final imageUrl = await imageReference.getDownloadURL();
        updatedData['imageUrl'] = imageUrl;
      });
    }

    if (updatedData.isNotEmpty) {
      await _usersCollection
          .doc(userId) // Assuming you're using document ID for user
          .update(updatedData);
    }
  }
}
