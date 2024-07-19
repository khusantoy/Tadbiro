import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadbiro/logic/blocs/auth/auth_bloc.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).viewPadding.top,
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
                leading: const Icon(Icons.home),
                title: const Text("Bosh oyna"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/events");
                },
                leading: const Icon(Icons.calendar_month),
                title: const Text("Mening tadbirlarim"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
                leading: const Icon(Icons.person),
                title: const Text("Profil ma'lumotlari"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/settings");
                },
                leading: const Icon(Icons.settings),
                title: const Text("Sozlamalar"),
                trailing: const Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                onTap: () {
                  context.read<AuthBloc>().add(LogoutAuthEvent());
                },
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Chiqish",
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
