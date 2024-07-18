import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tadbiro/services/geolocator_service.dart';
import 'package:tadbiro/utils/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  LatLng myCurrentPosition = const LatLng(38.8951, -77.0364);

  void _onMapCreated(GoogleMapController controller) async {
    final position = await GeolocatorService.getLocation();
    myCurrentPosition = LatLng(position.latitude, position.longitude);

    setState(() {
      mapController = controller;

      mapController.moveCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 15,
          ),
        ),
      );
    });
  }

  void onCameraMove(CameraPosition position) {
    setState(() {
      myCurrentPosition = position.target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onCameraMove: onCameraMove,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: myCurrentPosition,
              zoom: 15,
            ),
          ),
          const Align(
            child: Icon(
              Icons.place,
              color: Colors.red,
              size: 40,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
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
                    Navigator.pop(context, myCurrentPosition);
                  },
                  child: const Text("Belgilash"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
