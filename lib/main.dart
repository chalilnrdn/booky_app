// main.dart
import 'package:booky_app/screens/hotel/hotel_detail_screen.dart';
import 'package:booky_app/screens/splash/spash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BookyApp());
}

class BookyApp extends StatelessWidget {
  const BookyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == 'hotelDetail' || settings.name == '/hotel-detail') {
          return MaterialPageRoute(
            builder: (context) => const HotelDetailScreen(),
            settings: settings, // biar args bisa diambil di HotelDetailScreen
          );
        }
        return null;
      },
    );
  }
}