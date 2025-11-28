
import 'package:booky_app/screens/flight/book_flight_screen.dart';
import 'package:booky_app/screens/home/destination_detail_screen.dart';
import 'package:booky_app/screens/home/widget/destination_card.dart';
import 'package:booky_app/screens/home/widget/search_bar.dart';
import 'package:booky_app/screens/hotel/hotel_booking_screen.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.flight), label: "Book"),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag_outlined),
            label: "My Flights",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),


      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 230,
                  color: Colors.black,
                ),
               Padding(
                  padding: EdgeInsets.only(
                    top: 70,
                    left: 24,
                    right: 24,
                    bottom: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello John!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Where are you want going next?",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                ),
               Positioned(
                  top: 185,
                  left: 24,
                  right: 24,
                  child: CustomSearchBar(),
                ),
              ],
            ),


           SizedBox(height: 50),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                    icon: Icons.home_outlined,
                    label: "Hotels",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HotelBookingScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(
                    icon: Icons.flight,
                    label: "Flight",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BookFlightScreen(),
                        ),
                      );
                    },
                  ),
                  _buildMenuItem(icon: Icons.directions_car, label: "Cars"),
                ],
              ),
            ),


           SizedBox(height: 40),


            // Popular Destinations
           Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular Destinations",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),


           SizedBox(height: 20),


            // DESTINATION CARDS
            DestinationCard(
              imageAsset: "assets/images/amerika.png",
              title: "New York",
              price: 689,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationDetailScreen(
                    title: "New York",
                    price: 689,
                    imageName: 'amerika',
                  ),
                ),
              ),
            ),
           SizedBox(height: 16),
            DestinationCard(
              imageAsset: "assets/images/germany.png",
              title: "Germany",
              price: 799,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationDetailScreen(
                    title: "Germany",
                    price: 799,
                    imageName: "germany",
                  ),
                ),
              ),
            ),
           SizedBox(height: 16),
            DestinationCard(
              imageAsset: "assets/images/london.png",
              title: "London",
              price: 345,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationDetailScreen(
                    title: "London",
                    price: 345,
                    imageName: "london",
                  ),
                ),
              ),
            ),
           SizedBox(height: 16),
            DestinationCard(
              imageAsset: "assets/images/paris.png",
              title: "Paris",
              price: 850,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DestinationDetailScreen(
                    title: "Paris",
                    price: 850,
                    imageName: "paris",
                  ),
                ),
              ),
            ),


           SizedBox(height: 40),
          ],
        ),
      ),
    );
  }


  // MENU ITEM — sekarang bisa diklik!
  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: Colors.white, size: 32),
          ),
         SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}





