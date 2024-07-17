import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg"),
                ),
                title: Text("Alisher Zokirov"),
                subtitle: Text("alisherzokirov@gmail.com"),
              ),
            ),
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.calendar_month),
                title: Text("Mening tadbirlarim"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text("Profil ma'lumotlari"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                leading: Icon(Icons.translate),
                title: Text("Tilni o'zgartirish"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              ),
              ListTile(
                leading: Icon(Icons.light_mode),
                title: Text("Tungi/Kunduzgi holat"),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
              )
            ],
          ),
        ],
      ),
    );
  }
}
