import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            child: Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              height: 110.h,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2.w,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      "https://yesofcorsa.com/wp-content/uploads/2017/11/Latte-Wallpaper-For-Desktop.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Flutter Global hakaton",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text("10:10 06 Sentabr 2024"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width -
                            67.w -
                            80.w -
                            10.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.place_outlined),
                                Text("Yoshlar Ijod Saroyi"),
                              ],
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.favorite_outline),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
