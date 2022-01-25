import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyLocation extends StatefulWidget {
  const MyLocation({Key? key}) : super(key: key);

  @override
  _MyLocationState createState() => _MyLocationState();
}

class _MyLocationState extends State<MyLocation> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(46.9, 17.8), zoom: 15);
  late GoogleMapController _googleMapController;

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {
          const Marker(
            markerId: const MarkerId('basicLocation'),
            position: LatLng(46.9, 17.8),
            draggable: false,
          )
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(_initialCameraPosition)),
          child: Container(
            child: CircleAvatar(
              radius: 50,
              child: Icon(
                Icons.airport_shuttle,
                size: 50,
                color: Colors.black,
              ),
              backgroundColor: Colors.pinkAccent[100],
            ),
          )),
    );
  }
}
