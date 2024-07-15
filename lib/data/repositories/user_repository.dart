import 'dart:io';

import 'package:tadbiro/services/auth_firebase_services.dart';
import 'package:tadbiro/services/users_firebase_services.dart';

abstract class InterfaceUserRepository {
  Future<void> getUser();
  Future<void> registerUser(
    String fullName,
    String email,
    String password,
    File imageFile,
  );
  Future<void> loginUser(
    String email,
    String password,
  );
  Future<void> resetPassword(String email);
  Future<void> logout();

  Future<void> editUser(
    String fullName,
    File imageFile,
  );
  Future<void> deleteUser(String id);
}

class UserRepository implements InterfaceUserRepository {
  final AuthFirebaseServices authFirebaseServices;
  final UsersFirebaseServices usersFirebaseServices;

  UserRepository(this.authFirebaseServices, this.usersFirebaseServices);

  @override
  Future<void> getUser() async {}

  @override
  Future<void> registerUser(
      String fullName, String email, String password, File imageFile) async {
    await authFirebaseServices.register(
        emailAddress: email, password: password);

    await usersFirebaseServices.addUser(fullName, email, imageFile);
  }

  @override
  Future<void> loginUser(String email, String password) async {
    await authFirebaseServices.login(emailAddress: email, password: password);
  }

  @override
  Future<void> resetPassword(String email) async {
    await authFirebaseServices.resetPassword(email: email);
  }

  @override
  Future<void> logout() async {
    await AuthFirebaseServices.logout();
  }

  @override
  Future<void> editUser(String fullName, File imageFile) async {}

  @override
  Future<void> deleteUser(String id) async {}
}
