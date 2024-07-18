import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tadbiro/logic/blocs/event/event_bloc.dart';
import 'package:tadbiro/utils/colors.dart';
import 'package:tadbiro/utils/loading_dialog.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final dayController = TextEditingController();
  final timeController = TextEditingController();
  final aboutEventController = TextEditingController();
  LatLng? selectedLocation;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? imageFile;
  String? _currentAddress;

  void openGallery() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  void openCamera() async {
    final imagePicker = ImagePicker();
    final XFile? pickedImage = await imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      requestFullMetadata: false,
    );

    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
    }
  }

  // Function to combine date and time into a DateTime and convert to timestamp
  int getTimestamp(DateTime date, TimeOfDay time) {
    final DateTime combined = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );
    return combined.millisecondsSinceEpoch;
  }

  void _validateAndSubmit() async {
    if (_formKey.currentState!.validate() &&
        imageFile != null &&
        selectedLocation != null) {
      LoadingDialog.showLoadingDialog(context);
      context.read<EventBloc>().add(
            AddEventEvent(
              title: nameController.text,
              description: descriptionController.text,
              timestamp: "${dayController.text} ${timeController.text}",
              imageFile: imageFile!,
              latitude: selectedLocation!.latitude.toString(),
              longitude: selectedLocation!.longitude.toString(),
              location: _currentAddress!,
            ),
          );
      Navigator.pop(context);
      Navigator.pop(context, true);
    }

    if (imageFile == null) {
      Fluttertoast.showToast(
          msg: "Iltimos rasm yuklang",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    } else if (selectedLocation == null) {
      Fluttertoast.showToast(
          msg: "Iltimos manzilni belgilang",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Nomi",
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Tadbir nomini kiriting";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  readOnly: true,
                  controller: dayController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Kuni",
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101));

                        if (picked != null && picked != selectedDate) {
                          setState(() {
                            selectedDate = picked;
                            dayController.text =
                                selectedDate.toString().substring(0, 10);
                          });
                        }
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Tadbir kunini tanlang";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFormField(
                  readOnly: true,
                  controller: timeController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Vaqti",
                    suffixIcon: IconButton(
                      onPressed: () async {
                        // Show the time picker and await the selected time
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        // Perform actions based on the selected time
                        if (pickedTime != null) {
                          // Update the state with the selected time
                          setState(() {
                            selectedTime = pickedTime;
                            timeController.text = selectedTime
                                .toString()
                                .replaceAll("TimeOfDay(", "")
                                .replaceAll(")", "");
                          });
                        } else {
                          // Handle the case where the user cancels the picker
                        }
                      },
                      icon: const Icon(Icons.alarm),
                    ),
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return "Tadbir vaqtini tanlang";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  child: TextFormField(
                    controller: descriptionController,
                    onChanged: (value) {},
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Maydonni to'ldiring!";
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
                          Radius.circular(5.r),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      hintText: "Tadbir xaqida ma'lumot:",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Rasm yuklash",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: openCamera,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 - 20.w,
                        height: 100.h,
                        child: const Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.camera),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Kamera"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: openGallery,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 - 20.w,
                        height: 100.h,
                        child: const Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.photo),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Gallereya"),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (imageFile != null)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Container(
                      width: double.infinity,
                      height: 300.h,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.file(
                        imageFile!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                SizedBox(
                  height: 20.h,
                ),
                Text(
                  "Tadbir joyini belgilash",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                selectedLocation != null
                    ? SizedBox(
                        width: double.infinity,
                        height: 400.h,
                        child: GoogleMap(
                          buildingsEnabled: true,
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
                      )
                    : GestureDetector(
                        onTap: () async {
                          final data =
                              await Navigator.pushNamed(context, "/map");

                          setState(() {
                            selectedLocation = data as LatLng;
                          });
                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(
                                  selectedLocation!.latitude,
                                  selectedLocation!.longitude);

                          Placemark place1 = placemarks[0];
                          _currentAddress = place1.subAdministrativeArea;
                        },
                        child: SizedBox(
                          width: double.infinity,
                          height: 100.h,
                          child: const Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.map),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Xarita"),
                              ],
                            ),
                          ),
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
                    onPressed: _validateAndSubmit,
                    child: const Text("Qo'shish"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
