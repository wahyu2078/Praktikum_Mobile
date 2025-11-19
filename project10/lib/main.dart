import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocator Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Geolocator Example')),
        body: const LocationWidget(),
      ),
    );
  }
}

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  String _location = 'Tekan tombol untuk mendapatkan lokasi';

  Future<void> _getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _location = 'Location service disabled');
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _location = 'Permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _location = 'Permission denied forever');
      return;
    }

    final pos = await Geolocator.getCurrentPosition();
    setState(() => _location = 'Lat: ${pos.latitude}, Long: ${pos.longitude}');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_location, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getLocation,
            child: const Text('Get Current Location'),
          ),
        ],
      ),
    );
  }
}
