import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class StationScreen extends StatefulWidget {
  const StationScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChargingStationPageState createState() => _ChargingStationPageState();
}

class _ChargingStationPageState extends State<StationScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  List<String> timeSlots = [
    '08:00 - 08:30',
    '08:30 - 09:00',
    '09:00 - 09:30',
    // ... إضافة المزيد من الفترات
  ];
  String? selectedTimeSlot;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

//map
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool state = false;

  late LatLng location_station;

  //map
  final MapController mapController = MapController();
  LocationData? currentlocation;
  List<LatLng> routpoints = [];
  List<Marker> markers = [];

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
      markers.clear();

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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(height: 10, child: Image.asset('images/ev.png')),
        ),
        centerTitle: true,
        title: const Text(
          'EV_POWER',
          style: TextStyle(
              color: Color.fromARGB(255, 231, 222, 222),
              fontSize: 30,
              fontWeight: FontWeight.w400),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.grey,
          Colors.black54,
        ])),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // صورة المحطة
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                    width: double.infinity,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'images/station3.jpg',
                          fit: BoxFit.cover,
                        ))),
              ),
              const SizedBox(height: 20),

              // معلومات المحطة
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'محطة الشحن السريع',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          SizedBox(width: 5),
                          Text('الرياض، حي المالكات'),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(Icons.access_time),
                          SizedBox(width: 5),
                          Text('أوقات العمل: ٦ صباحًا - ١٢ مساءً'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // اختيار التاريخ
              Card(
                child: ListTile(
                  title: const Text('اختر تاريخ الحجز'),
                  subtitle: Text(selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                      : 'لم يتم اختيار تاريخ'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                ),
              ),
              Center(
                child: Expanded(
                  child: Container(
                    height: 300,
                    width: 300,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Scaffold(
                          body: currentlocation == null
                              ? const Center(child: CircularProgressIndicator())
                              : FlutterMap(
                                  mapController: mapController,
                                  options: MapOptions(
                                    initialCenter: LatLng(
                                        currentlocation!.latitude!,
                                        currentlocation!.longitude!),
                                    initialZoom: 15.0,
                                    onTap: (tapPosition, point) =>
                                        location_station =LatLng(0, 0)
                                           
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
                                  LatLng(currentlocation!.latitude!,
                                      currentlocation!.longitude!),
                                  15.0,
                                );
                              }
                            },
                            child: const Icon(
                              Icons.my_location,
                              color: Colors.blue,
                            ),
                          ),
                        )),
                  ),
                ),
              ),

              // اختيار الوقت
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'اختر فترة زمنية:',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedTimeSlot = timeSlots[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedTimeSlot == timeSlots[index]
                            ? Colors.green[200]
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(timeSlots[index]),
                    ),
                  );
                },
              ),

              // زر الحجز
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.indigo,
                    ),
                    onPressed: () {
                      if (selectedDate != null && selectedTimeSlot != null) {
                        // تنفيذ عملية الحجز
                      }
                    },
                    child: const Text(
                      'تأكيد الحجز',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
