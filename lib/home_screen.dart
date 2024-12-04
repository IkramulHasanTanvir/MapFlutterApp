import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Map',
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
      ),
    );
  }
}

class CustomBit extends StatelessWidget implements BitmapDescriptor{
  const CustomBit({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  @override
  Object toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

