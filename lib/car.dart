import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Favoritecar extends StatefulWidget {
  const Favoritecar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FavoritecarState createState() => _FavoritecarState();
}

class _FavoritecarState extends State<Favoritecar> {
  List<dynamic> car = [];

  @override
  void initState() {
    super.initState();
    loadCars();
  }

  Future<void> loadCars() async {
    final String response = await rootBundle.loadString('assets/car.json');
    final data = await json.decode(response);
    setState(() {
      car = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: car.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.asset(
                car[index]['image'],
                width: 110,
              ),
              title: Text(
                car[index]['brand'],
                style: GoogleFonts.oswald(
                  textStyle: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car[index]['model'],
                    style: GoogleFonts.oswald(
                        textStyle: const TextStyle(fontSize: 18)),
                  ),
                  Text(
                    'Year: ${car[index]['year']}',
                    style: GoogleFonts.oswald(
                        textStyle: const TextStyle(fontSize: 16)),
                  ),
                  Text(
                    'Color: ${car[index]['color']}',
                    style: GoogleFonts.oswald(
                        textStyle: const TextStyle(fontSize: 16)),
                  ),
                  Text(
                    'Price: ${car[index]['price']} THB',
                    style: GoogleFonts.oswald(
                        textStyle: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoritecarScreen(
                        car: car[index]), // ส่งข้อมูลรถไปยังหน้าจอรายละเอียด
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class FavoritecarScreen extends StatefulWidget {
  final Map<String, dynamic> car; // รับข้อมูลรถเป็น Map

  const FavoritecarScreen({super.key, required this.car}); // ใช้ Constructor

  @override
  // ignore: library_private_types_in_public_api
  _FavoritecarScreenState createState() => _FavoritecarScreenState();
}

class _FavoritecarScreenState extends State<FavoritecarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.car['brand'], style: GoogleFonts.oswald()),
        backgroundColor: Colors.blueGrey,
      ),
      body: SingleChildScrollView(
        // ทำให้สามารถเลื่อนหน้าจอได้
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.car['image'],
              height: 200,
              width: 600,
            ),
            const SizedBox(height: 16.0),
            Text(
              'รุ่น: ${widget.car['model']}',
              style:
                  GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 24)),
            ),
            Text(
              'ผลิตปี: ${widget.car['year']}',
              style:
                  GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 20)),
            ),
            Text(
              'สี: ${widget.car['color']}',
              style:
                  GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 20)),
            ),
            Text(
              'ราคา: ${widget.car['price']} THB',
              style:
                  GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 20)),
            ),
            Text(
              'ประวัติ: ${widget.car['record']}', // เพิ่มรายละเอียด
              style:
                  GoogleFonts.oswald(textStyle: const TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
