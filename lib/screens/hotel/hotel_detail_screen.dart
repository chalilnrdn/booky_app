import 'package:flutter/material.dart';


class HotelDetailScreen extends StatelessWidget {
  const HotelDetailScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;


    // safety check → supaya tidak error "Null is not a subtype of Map"
    if (args == null || args is! Map) {
      return const Scaffold(
        body: Center(
          child: Text(
            "No hotel data received.\nPlease check Navigator arguments.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }


    final data = args; // sudah pasti Map sekarang


    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.zero,
            children: [
              // image top
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Image.asset(
                  data['image'],
                  height: 330,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),


              SizedBox(height: 30),


              // title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['title'],
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),


                        SizedBox(height: 10),


                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(width: 6),
                            Text(
                              data['address'],
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),


                        SizedBox(height: 6),


                        Row(
                          children: [
                            Icon(Icons.star, size: 20, color: Colors.amber),
                            SizedBox(width: 5),
                            Text(
                              data['rating'].toString(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(width: 4),
                            Text(
                              "(${data['reviews']} reviews)",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black45,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),


                    // PRICE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "\$${data['price']}",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                        Text(
                          "/night",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),


              SizedBox(height: 35),


              // FACILITIES
              Padding(
                padding: EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FacilityItem(icon: Icons.restaurant, title: "Restaurant"),
                    FacilityItem(icon: Icons.wifi, title: "Wifi"),
                    FacilityItem(icon: Icons.directions_bus, title: "Rent"),
                    FacilityItem(icon: Icons.pool, title: "Pool"),
                    FacilityItem(icon: Icons.support, title: "Support"),
                  ],
                ),
              ),


              SizedBox(height: 40),


              // DETAILS
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 14),
                    Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
                      "Aenean commodo ligula eget dolor. Aenean massa. "
                      "Cum sociis natoque penatibus et magnis dis parturient.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                        fontFamily: 'Inter',
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 40),


              // LOCATION
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Location",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 20),


                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "assets/images/dummy-map.jpg",
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),


              SizedBox(height: 40),


              // booking button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 30),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Center(
                    child: Text(
                      "Book Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),


          // back to hotel screen
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// FACILITY ITEM COMPONENT
class FacilityItem extends StatelessWidget {
  final IconData icon;
  final String title;


  const FacilityItem({super.key, required this.icon, required this.title});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontFamily: 'Inter',
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}



