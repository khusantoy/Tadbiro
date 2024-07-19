import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadbiro/data/models/event.dart';
import 'package:tadbiro/logic/blocs/event/event_bloc.dart';
import 'package:tadbiro/ui/widgets/custom_drawer.dart';
import 'package:tadbiro/ui/widgets/event_item_widget.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(GetEventsEvent());
    _searchController.addListener(
        _onSearchChanged); // Listen for changes in the search field
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text;
    context.read<EventBloc>().add(SearchCurrencyEvent(query));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text("Bosh sahifa"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/notifications");
              },
              icon: const Icon(Icons.notifications_none_rounded),
            )
          ],
        ),
        body: BlocBuilder<EventBloc, EventState>(
          bloc: context.read<EventBloc>()..add(GetEventsEvent()),
          builder: (context, state) {
            if (state is LoadingEventState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ErrorEventState) {
              return Center(
                child: Text(state.message),
              );
            }

            if (state is LoadedEventsState) {
              final today = DateTime.now();
              final nextWeek = today.add(const Duration(days: 7));

              final upcomingEvents = state.events.where((event) {
                // Parse the event date string into a DateTime object
                final eventDate =
                    DateFormat('yyyy-MM-dd HH:mm').parse(event.date);
                return eventDate.isAfter(today) && eventDate.isBefore(nextWeek);
              }).toList();

              List<Event> events = [];

              if (state is LoadedEventsState) {
                events = state.events;
              } else if (state is SearchedCurrencyState) {
                events = state.events;
              }

              return state.events.isEmpty
                  ? const Center(
                      child: Text("Afsuski tadbirlar mavjud emas"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15.w, top: 15.h, right: 15.w),
                            child: TextFormField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                prefixIcon: const Icon(Icons.search),
                                suffixIcon: PopupMenuButton(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: const Icon(Icons.tune),
                                  ),
                                  onSelected: (value) {
                                    // Handle menu item selection
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return [
                                      const PopupMenuItem(
                                        value: 1,
                                        child: Text("Tadbir nomi bo'yicha"),
                                      ),
                                      const PopupMenuItem(
                                        value: 2,
                                        child: Text("Manzil bo'yicha"),
                                      ),
                                    ];
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Yaqin 7 kun ichida",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 200.h,
                            child: PageView.builder(
                              itemCount: upcomingEvents.length,
                              itemBuilder: (context, index) {
                                final event = upcomingEvents[index];

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/details",
                                        arguments: {
                                          "imageUrl": event.imageUrl,
                                          "title": event.title,
                                          "date": event.date,
                                          "location": event.location,
                                          "latitude": event.latitude,
                                          "longitude": event.longitude,
                                          "participants": event.participants,
                                          "creatorId": event.creatorId,
                                          "description": event.description,
                                          "likedUsers": event.likedUsers,
                                        });
                                  },
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.w),
                                    child: Container(
                                      height: 200.h,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            event.imageUrl,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Stack(
                                          children: [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.white,
                                                ),
                                                padding:
                                                    const EdgeInsets.all(3),
                                                child: Text(event.title),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                child: IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<EventBloc>()
                                                        .add(MakeLikedEvent(
                                                            id: event.id));
                                                  },
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: event.likedUsers
                                                            .contains(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .email)
                                                        ? Colors.red
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(event.date
                                                      .substring(0, 10)),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "Barcha tadbirlar",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: (120.h + 30.h) * state.events.length,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.events.length,
                              itemBuilder: (context, index) {
                                final event = state.events[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context, "/details",
                                        arguments: {
                                          "imageUrl": event.imageUrl,
                                          "title": event.title,
                                          "date": event.date,
                                          "location": event.location,
                                          "latitude": event.latitude,
                                          "longitude": event.longitude,
                                          "participants": event.participants,
                                          "creatorId": event.creatorId,
                                          "description": event.description,
                                          "likedUsers": event.likedUsers,
                                        });
                                  },
                                  child: EventItemWidget(
                                    title: event.title,
                                    imageUrl: event.imageUrl,
                                    date: event.date,
                                    location: event.location,
                                    iconBtn: IconButton(
                                      onPressed: () {
                                        context
                                            .read<EventBloc>()
                                            .add(MakeLikedEvent(id: event.id));
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: event.likedUsers.contains(
                                                FirebaseAuth.instance
                                                    .currentUser!.email)
                                            ? Colors.red
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    );
            }
            return const Center(
              child: Text("Mahsulotlar mavjud emas"),
            );
          },
        ));
  }
}
