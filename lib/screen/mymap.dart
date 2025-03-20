import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class Mymap extends StatefulWidget {
  Mymap({super.key});

  // static LatLng getLoc() {
  //   return loc;
  // }

  _MapState m = new _MapState();
  
  @override
  State<Mymap> createState() => _MapState();
}

class _MapState extends State<Mymap> {
  final MapController mapController = MapController();
  LocationData? currentlocation;
  List<LatLng> routpoints = [];
  List<Marker> markers = [];
    static late LatLng loc;
  static   LatLng getLoc() {
    return loc;
  }

  final String orsApiKey =
      '5b3ce3597851110001cf6248cef75b93fc964e608ef110a0b7e38006';
  @override
  void initState() {
    getcurrentlocation();
    super.initState();
  }

  Future<void> getcurrentlocation() async {
    var location = Location();
    try {
      var userloaction = await location.getLocation();
      setState(() {
        currentlocation = userloaction;
        markers.add(Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(userloaction.latitude!, userloaction.longitude!),
            child: const Icon(
              Icons.my_location,
              color: Colors.blue,
              size: 40.0,
            )));
      });
    } on Exception {
      currentlocation = null;
    }
    location.onLocationChanged.listen((LocationData newlocation) {
      setState(() {
        currentlocation = newlocation;
      });
    });
  }

  Future<void> getroute(LatLng destination) async {
    if (currentlocation == null) return;

    final start =
        LatLng(currentlocation!.latitude!, currentlocation!.longitude!);
    final response = await http.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];
      setState(() {
        routpoints = coords.map((coord) => LatLng(coord[1], coord[0])).toList();
        markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: destination,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
          ),
        );
      });
    } else {
      // Handle errors
      print('Failed to fetch route');
    }
  }

  LatLng _addDestinationMarker(LatLng point) {
    setState(() {
      markers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: point,
          child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      );
    });
    getroute(point);
    return point;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: currentlocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: LatLng(
                    currentlocation!.latitude!, currentlocation!.longitude!),
                initialZoom: 15.0,
                onTap: (tapPosition, point) =>
                    loc = _addDestinationMarker(point),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: markers,
                ),
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: routpoints,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          if (currentlocation != null) {
            mapController.move(
              LatLng(currentlocation!.latitude!, currentlocation!.longitude!),
              15.0,
            );
          }
        },
        child: const Icon(
          Icons.my_location,
          color: Colors.blue,
        ),
      ),
    );
  }
}
