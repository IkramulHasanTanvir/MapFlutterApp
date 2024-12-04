import 'package:flutter/material.dart';
import 'package:googl_map_flutter_app/home_screen.dart';

class MapFlutterApp extends StatelessWidget {
  const MapFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
