import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController _googleMapController;

  Position? position;

  Future<void> _getCurrentLocation() async {
    final isGranted = await _isLocationPermissionGranted();
    if (isGranted) {
      final isEnable = await _checkGPSServiceEnable();
      if (isEnable) {
        Position currentPosition = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(distanceFilter: 10));
        position = currentPosition;
        setState(() {});
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      final result = await _requestLocationPermission();
      if (result) {
        _getCurrentLocation();
      } else {
        Geolocator.openAppSettings();
      }
    }
  }

  Future<bool> _isLocationPermissionGranted() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _requestLocationPermission() async {
    LocationPermission locationPermission =
        await Geolocator.requestPermission();
    if (locationPermission == LocationPermission.always ||
        locationPermission == LocationPermission.whileInUse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _checkGPSServiceEnable() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Google Map',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.amber,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(23.864765120989297, 90.29022071510553),
          zoom: 16,
        ),
        onTap: (LatLng? latLog) {
          debugPrint(latLog.toString());
        },
        zoomControlsEnabled: true,
        trafficEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _googleMapController = controller;
        },
        markers: <Marker>{
          const Marker(
            markerId: MarkerId('initial-value'),
            position: LatLng(23.864765120989297, 90.29022071510553),
          ),
          Marker(
            markerId: const MarkerId('home'),
            position: const LatLng(23.863986939932396, 90.28948478400709),
            infoWindow: const InfoWindow(title: 'home'),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          ),
        },
        circles: <Circle>{
          Circle(
              circleId: const CircleId('initial-circle'),
              center: const LatLng(23.862241994490237, 90.28771318495274),
              radius: 300,
              fillColor: Colors.red.withOpacity(0.3),
              strokeWidth: 0),
        },
        polylines: <Polyline>{
          const Polyline(
            width: 3,
            jointType: JointType.mitered,
            polylineId: PolylineId('initial-polyline'),
            points: <LatLng>[
              LatLng(23.86998292187493, 90.28878439217806),
              LatLng(23.86686600252344, 90.2925730124116),
              LatLng(23.861674138610514, 90.29284290969372),
              LatLng(23.85739612920099, 90.29078297317028),
            ],
          ),
        },
        polygons: <Polygon>{
          const Polygon(
            polygonId: PolygonId('initial-polygon'),
            points: <LatLng>[
              LatLng(23.856226643038394, 90.28297506272793),
              LatLng(23.85491456144058, 90.28883635997772),
              LatLng(23.851763242247664, 90.28615079820156),
              LatLng(23.847546542615284, 90.28483886271715),
              LatLng(23.85378184932356, 90.2809888869524),
            ],
          ),
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (position == null) {
            await _getCurrentLocation();
          }
          if (position != null) {
            _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  zoom: 16,
                  target: LatLng(position!.latitude, position!.longitude),
                ),
              ),
            );
          }
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
