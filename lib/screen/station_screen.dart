import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
        backgroundColor: const Color.fromARGB(255, 0, 127, 230),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color.fromARGB(255, 0, 127, 230),
          Color.fromARGB(255, 51, 192, 8),
        ])),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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

              // اختيار الوقت
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  'اختر فترة زمنية:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                      backgroundColor: const Color.fromARGB(255, 0, 127, 230),
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
