import 'package:flutter/material.dart';
import 'package:tadbiro/ui/screens/tab_screen.dart';
import 'package:tadbiro/ui/widgets/custom_drawer.dart';

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
    tabController = TabController(length: 5, vsync: this);
    tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        bottom:
            TabBar(controller: tabController, isScrollable: true, tabs: const [
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
      drawer: const CustomDrawer(),
      body: TabBarView(
        controller: tabController,
        children: const [
          TabScreen(),
          TabScreen(),
          TabScreen(),
          TabScreen(),
          TabScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add-event");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
