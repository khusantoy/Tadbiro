import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadbiro/core/main_app.dart';
import 'package:tadbiro/data/repositories/user_repository.dart';
import 'package:tadbiro/firebase_options.dart';
import 'package:tadbiro/logic/blocs/auth/auth_bloc.dart';
import 'package:tadbiro/services/auth_firebase_services.dart';
import 'package:tadbiro/services/users_firebase_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize the services
  final AuthFirebaseServices authFirebaseServices = AuthFirebaseServices();
  final UsersFirebaseServices usersFirebaseServices = UsersFirebaseServices();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) {
          return UserRepository(authFirebaseServices, usersFirebaseServices);
        })
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            return AuthBloc(context.read<UserRepository>());
          })
        ],
        child: const MainApp(),
      ),
    ),
  );
}
