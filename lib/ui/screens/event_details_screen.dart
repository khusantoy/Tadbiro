import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:tadbiro/data/models/event.dart';
import 'package:tadbiro/logic/blocs/event/event_bloc.dart';
import 'package:tadbiro/logic/blocs/user/user_bloc.dart';
import 'package:tadbiro/utils/colors.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  LatLng? selectedLocation;
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    selectedLocation = LatLng(
      double.parse(args['latitude']),
      double.parse(
        args['longitude'],
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewPadding.top + 15.h,
                left: 15.w,
                right: 15.w,
              ),
              width: double.infinity,
              height: 250.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(args['imageUrl']),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
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
                              .add(MakeLikedEvent(id: args['id']));
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: args['likedUsers'].contains(
                                  FirebaseAuth.instance.currentUser!.email)
                              ? Colors.red
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    args['title'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: const Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        args['date'],
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: const Icon(
                          Icons.place,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        args['location'],
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Container(
                        width: 60.w,
                        height: 60.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        child: const Icon(
                          Icons.public,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        (args['participants'] as List<Participant>)
                            .length
                            .toString(),
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  BlocBuilder<UserBloc, UserState>(
                      bloc: context.read<UserBloc>()
                        ..add(
                          GetUserEvent(
                            FirebaseAuth.instance.currentUser!.email!,
                          ),
                        ),
                      builder: (context, state) {
                        if (state is LoadingUserState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (state is ErrorUserState) {
                          return Center(
                            child: Text(state.message),
                          );
                        }

                        if (state is LoadedUsersState) {
                          return Card(
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(state.user['imageUrl']),
                              ),
                              title: Text(state.user['username']),
                              subtitle: const Text("Tadbir tashkilotchisi"),
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text(
                    "Tadbir haqida",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    args['description'],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  const Text(
                    "Manzil",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    args['location'],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 300.h,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: selectedLocation!,
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("location"),
                          position: selectedLocation!,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed),
                        ),
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(24.0),
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: const Icon(Icons.arrow_back),
                                          ),
                                        ),
                                        Text(
                                          "Ro'yhatdan o'tish",
                                          style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(Icons.close),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      "Joylar sonini tanlang",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                amount++;
                                              });
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text(
                                          amount.toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                amount--;
                                              });
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Text(
                                      "To'lov turini tanlang",
                                      style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Card(
                                      child: ListTile(
                                        leading: Container(
                                          clipBehavior: Clip.hardEdge,
                                          width: 45.w,
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                            "assets/images/paymee.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: const Text("Paymee"),
                                        trailing:
                                            const Icon(Icons.circle_outlined),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Card(
                                      child: ListTile(
                                        leading: Container(
                                          clipBehavior: Clip.hardEdge,
                                          width: 45.w,
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                            "assets/images/click.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: const Text("Click"),
                                        trailing:
                                            const Icon(Icons.circle_outlined),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Card(
                                      child: ListTile(
                                        leading: Container(
                                          clipBehavior: Clip.hardEdge,
                                          width: 45.w,
                                          height: 45.h,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Image.asset(
                                            "assets/images/uzum.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        title: const Text("Uzum bank"),
                                        trailing:
                                            const Icon(Icons.circle_outlined),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 32.h,
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 55,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.white,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                          ),
                                        ),
                                        onPressed: () {
                                          context.read<EventBloc>().add(
                                                MakeParticipantEvent(
                                                    args['id'], "1"),
                                              );
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    lottie.Lottie.asset(
                                                      'assets/lotties/success.json',
                                                      repeat: false,
                                                    ),
                                                    Text(
                                                      "Tabriklaymiz!",
                                                      style: TextStyle(
                                                        fontSize: 20.sp,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15.h,
                                                    ),
                                                    Text(
                                                      "Siz Flutter Global Hakaton 2024 tadbiriga muvvaffaqiyatli ro'yhatdan o'tdingiz.",
                                                      style: TextStyle(
                                                        fontSize: 18.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15.h,
                                                    ),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 55,
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          foregroundColor:
                                                              Colors.white,
                                                          backgroundColor:
                                                              AppColors
                                                                  .primaryColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                        ),
                                                        onPressed: () {},
                                                        child: const Text(
                                                            "Eslatmani belgilash"),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15.h,
                                                    ),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 55,
                                                      child: OutlinedButton(
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pushNamed(
                                                              context, "/home");
                                                        },
                                                        child: const Text(
                                                            "Bosh sahifa"),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: const Text("Keyingi"),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Text("Ro'yhatdan o'tish"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
