import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificatioinsScreen extends StatefulWidget {
  const NotificatioinsScreen({super.key});

  @override
  State<NotificatioinsScreen> createState() => _NotificatioinsScreenState();
}

class _NotificatioinsScreenState extends State<NotificatioinsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xabarlar"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg"),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Alisher Zokirov",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text("22:00 19-iyun 2024")
                          ],
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.circle,
                      size: 10,
                      color: Colors.red,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                const Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum ",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
