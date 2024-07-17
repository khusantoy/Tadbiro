import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadbiro/ui/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15.w, top: 15.h, right: 15.w),
              child: TextFormField(
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
                      print(value);
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
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, "/details");
              },
              child: SizedBox(
                height: 200.h,
                child: PageView(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Container(
                        height: 200.h,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://wallpapers.com/images/hd/ocean-view-with-iceberg-penguins-jbr8tlmccjsoeaxt.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
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
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                  ),
                                  padding: const EdgeInsets.all(3),
                                  child: const Text("Linux Festival"),
                                ),
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
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("12"),
                                    Text("May"),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Container(
                        width: double.infinity,
                        height: 200.h,
                        clipBehavior: Clip.hardEdge,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              "https://wallpapers.com/images/hd/ocean-view-with-iceberg-penguins-jbr8tlmccjsoeaxt.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
              height: (110.h + 20.h) * 4,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          icon: const Icon(
                                              Icons.favorite_outline),
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
            )
          ],
        ),
      ),
    );
  }
}
