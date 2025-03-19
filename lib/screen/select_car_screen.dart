import 'package:ev_power/Model/Car.dart';
import 'package:ev_power/Services/Cars.dart';
import 'package:ev_power/widgets/mybutton2.dart';
import 'package:ev_power/widgets/station_card.dart';
import 'package:flutter/material.dart';

class SelectcarScreen extends StatefulWidget {
  const SelectcarScreen({super.key});

  @override
  State<SelectcarScreen> createState() => _SelectcarScreenState();
}

class _SelectcarScreenState extends State<SelectcarScreen> {
  List<Car> cars = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadCars();
  }

  Future<void> _loadCars() async {
    try {
      final loadedCars = await CarsApi.getCars();
      setState(() {
        cars = loadedCars;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'فشل في تحميل السيارات: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;

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
        backgroundColor: const Color.fromARGB(255, 0, 127, 230),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 127, 230),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: _buildContent(currentWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(double currentWidth) {
    if (_isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        color: Color.fromARGB(255, 2, 207, 9),
      ));
    }

    if (_errorMessage.isNotEmpty) {
      return Center(child: Text(_errorMessage));
    }

    if (cars.isEmpty) {
      return const Center(child: Text('لا توجد سيارات مضافة'));
    }

    return RefreshIndicator(
      onRefresh: _loadCars,
      child: Column(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(25),
            itemCount: cars.length,
            itemBuilder: (context, index) {
              final car = cars[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 40),
                width: 200,
                height: 200,
                child: StationCard(
                  car.carNumber, // استخدام البيانات الحقيقية
                  car.chargingType,
                  () {},
                  const Color.fromARGB(255, 164, 183, 199),
                  const Color.fromARGB(255, 218, 103, 50),
                  'asset/car.json',
                  currentWidth < 370 ? 100 : 200,
                ),
              );
            },
          ),
          MyButton2(
            Title: 'اضافة سيارة',
            color: Colors.blue,
            onPressed: () async {
              await Navigator.pushNamed(context, 'create_car_screen');
              _loadCars();
            },
          ),
        ],
      ),
    );
  }
}
