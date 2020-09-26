import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  MapPage({@required this.lat, @required this.long});
  final lat;
  final long;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  List<Marker> marker = [];

  @override
  void initState() {
    super.initState();
    marker.add(
      Marker(
        markerId: MarkerId('our_location'),
        draggable: false,
        onTap: () {
          print('Marker has been tapped');
        },
        position: LatLng(widget.lat, widget.long),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Location'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat, widget.long),
          zoom: 14.5,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set.from(marker),
      ),
    );
  }
}
