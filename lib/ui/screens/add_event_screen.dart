import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadbiro/utils/colors.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final nameController = TextEditingController();
  final dayController = TextEditingController();
  final timeController = TextEditingController();
  final aboutEventController = TextEditingController();
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Tadbir Qo'shish"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Nomi",
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Kuni",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: "Vaqti",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.alarm),
                ),
              ),
            ),
            SizedBox(
              child: TextFormField(
                controller: messageController,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Fill this space!";
                  }
                  return null;
                },
                maxLines: 10,
                minLines: 5,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(16.r),
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 12.h,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.w,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 1.w,
                    ),
                  ),
                  hintText: "Message",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    height: 1.5.h,
                    color: const Color(0xFFDADEE3),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
