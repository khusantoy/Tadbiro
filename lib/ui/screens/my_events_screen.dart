import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tadbiro/ui/screens/tab_screen.dart';
import 'package:tadbiro/utils/colors.dart';

class MyEventsScreen extends StatefulWidget {
  const MyEventsScreen({super.key});

  @override
  State<MyEventsScreen> createState() => _MyEventsScreenState();
}

class _MyEventsScreenState extends State<MyEventsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Mening tadbirlarim"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/notifications");
              },
              icon: const Icon(Icons.notifications_none_rounded),
            )
          ],
          bottom: TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: const [
                Tab(
                  text: "Tashkil qilganlarim",
                ),
                Tab(
                  text: "Yaqinda",
                ),
                Tab(
                  text: "Ishtirok etganlarim",
                ),
                Tab(
                  text: "Bekor qilganlarim",
                )
              ]),
        ),
        body: TabBarView(
          controller: tabController,
          children: const [
            TabScreen(),
            TabScreen(),
            TabScreen(),
            TabScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () async {
            final data = await Navigator.pushNamed(context, "/add-event");
            if (data == true) {
              Fluttertoast.showToast(
                  msg: "Tadbir yaratildi",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb: 1,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
