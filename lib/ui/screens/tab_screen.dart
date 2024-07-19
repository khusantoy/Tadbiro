import 'package:flutter/material.dart';
import 'package:tadbiro/ui/widgets/event_item_widget.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          // return const EventItemWidget(
          //   title: "Choyxona",
          //   imageUrl:
          //       "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/Nest_One_Tashkent.jpg/800px-Nest_One_Tashkent.jpg",
          //   date: "2024-07-18 23:12",
          //   location: "Tashkent",
          // );
        },
      ),
    );
  }
}
