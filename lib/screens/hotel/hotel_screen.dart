// lib/screens/hotels_page.dart

import 'package:booky_app/models/hotel_model.dart';
import 'package:booky_app/screens/hotel/widget/filter_bottom_sheet.dart';
import 'package:booky_app/screens/hotel/widget/hotel_card.dart';
import 'package:booky_app/screens/hotel/widget/short_bottom_sheet.dart';
import 'package:booky_app/utils/consts.dart';
import 'package:flutter/material.dart';


class HotelsPage extends StatefulWidget {
 const HotelsPage({super.key});
 static const routeName = '/hotels';


 @override
 State<HotelsPage> createState() => _HotelsPageState();
}


class _HotelsPageState extends State<HotelsPage> {
 late String location;
 late DateTime? checkIn;
 late DateTime? checkOut;
 late int guests;
 late int rooms;


 late List<Hotel> allHotels;
 late List<Hotel> displayedHotels;


 double minPrice = 10;
 double maxPrice = 1000;
 int selectedRating = 0;
 Set<String> selectedFacilities = {};
 String sortBy = 'Highest';


 @override
 void initState() {
   super.initState();
   allHotels = [
     Hotel(
       image: "assets/images/room-1.jpg",
       title: "New York Hotel",
       address: "3rd Avenue, Manhattan",
       rating: 4.5,
       reviews: 3241,
       price: 234,
     ),
     Hotel(
       image: "assets/images/room-2.png",
       title: "Tulipan Hotel",
       address: "Brooklyn, New York",
       rating: 4.7,
       reviews: 2811,
       price: 210,
     ),
     Hotel(
       image: "assets/images/room-3.png",
       title: "Japan Hotel",
       address: "Tokyo, Japan",
       rating: 5.0,
       reviews: 5000,
       price: 650,
     ),
     Hotel(
       image: "assets/images/room-4.png",
       title: "Bangkok Hotel",
       address: "Bangkok, Thailand",
       rating: 4.9,
       reviews: 3544,
       price: 450,
     ),
     Hotel(
       image: "assets/images/room-5.png",
       title: "Jakarta Hotel",
       address: "Jakarta, Indonesia",
       rating: 4.7,
       reviews: 8544,
       price: 125,
     ),
   ];
   displayedHotels = List.from(allHotels);
 }


 @override
 void didChangeDependencies() {
   super.didChangeDependencies();
   final args =
       ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;


   if (args != null) {
     location = args['location'] ?? 'Unknown Location';
     checkIn = args['checkIn'];
     checkOut = args['checkOut'];
     guests = args['guests'] ?? 1;
     rooms = args['rooms'] ?? 1;
   } else {
     location = 'New York';
     checkIn = DateTime.now();
     checkOut = DateTime.now().add(const Duration(days: 3));
     guests = 2;
     rooms = 1;
   }
   _applyFilterAndSort();
 }


 void _applyFilterAndSort() {
   List<Hotel> filtered = allHotels.where((hotel) {
     bool priceOk = hotel.price >= minPrice && hotel.price <= maxPrice;
     bool ratingOk = selectedRating == 0 || hotel.rating >= selectedRating;
     return priceOk && ratingOk;
   }).toList();


   filtered.sort((a, b) {
     switch (sortBy) {
       case 'Highest':
         return b.rating.compareTo(a.rating);
       case 'Lowest Price':
         return a.price.compareTo(b.price);
       case 'Highest Price':
         return b.price.compareTo(a.price);
       case 'Highest Rating':
         return b.rating.compareTo(a.rating);
       case 'Near Me':
         return a.price.compareTo(b.price);
       default:
         return 0;
     }
   });


   setState(() => displayedHotels = filtered);
 }


 void _showFilterSheet() => showModalBottomSheet(
   context: context,
   isScrollControlled: true,
   backgroundColor: Colors.transparent,
   builder: (_) => FilterBottomSheet(
     minPrice: minPrice,
     maxPrice: maxPrice,
     selectedRating: selectedRating,
     selectedFacilities: selectedFacilities,
     onApply: (min, max, rating, facilities) {
       setState(() {
         minPrice = min;
         maxPrice = max;
         selectedRating = rating;
         selectedFacilities = facilities;
       });
       _applyFilterAndSort();
     },
   ),
 );


 void _showSortSheet() => showModalBottomSheet(
   context: context,
   isScrollControlled: true,
   backgroundColor: Colors.transparent,
   builder: (_) => SortBottomSheet(
     currentSort: sortBy,
     onSortSelected: (newSort) {
       setState(() => sortBy = newSort);
       _applyFilterAndSort();
     },
   ),
 );


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: const Color(0xFF0D0D0D),
     body: SafeArea(
       child: Column(
         children: [
           Container(
             color: Colors.black.withOpacity(0.7),
             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 GestureDetector(
                   onTap: () => Navigator.pop(context),
                   child: const Icon(
                     Icons.arrow_back_ios_new,
                     color: Colors.white,
                     size: 22,
                   ),
                 ),
                 Text(
                   location,
                   style: const TextStyle(
                     color: Colors.white,
                     fontSize: 20,
                     fontWeight: FontWeight.w600,
                   ),
                 ),
                 Row(
                   children: [
                     IconButton(
                       onPressed: _showSortSheet,
                       icon: const Icon(Icons.swap_vert, color: Colors.white),
                     ),
                     IconButton(
                       onPressed: _showFilterSheet,
                       icon: const Icon(
                         Icons.filter_list,
                         color: Colors.white,
                       ),
                     ),
                   ],
                 ),
               ],
             ),
           ),


           // === INFO TANGGAL & TAMU ===
           Container(
             width: double.infinity,
             color: Colors.black.withOpacity(0.7),
             padding: const EdgeInsets.symmetric(vertical: 14),
             child: Center(
               child: Text(
                 "${guests} Guest${guests > 1 ? 's' : ''} • ${rooms} Room${rooms > 1 ? 's' : ''} • ${checkIn != null ? '${checkIn!.day}/${checkIn!.month}' : '?'} - ${checkOut != null ? '${checkOut!.day}/${checkOut!.month}' : '?'}",
                 style: const TextStyle(color: Colors.white70, fontSize: 13),
               ),
             ),
           ),


           // === LIST HOTEL DENGAN BACKGROUND PUTIH + CARD MELAYANG ===
           Expanded(
             child: Container(
               margin: const EdgeInsets.only(
                 top: 20,
               ), // Jarak dari header hitam
               decoration: const BoxDecoration(
                 color: Colors.white,
                 borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
               ),
               child: displayedHotels.isEmpty
                   ? const Center(
                       child: Text(
                         "No hotels found",
                         style: TextStyle(color: textColor),
                       ),
                     )
                   : ListView.builder(
                       padding: const EdgeInsets.only(
                         top: 24,
                         left: 20,
                         right: 20,
                         bottom: 20,
                       ),
                       itemCount: displayedHotels.length,
                       itemBuilder: (context, i) {
                         final hotel = displayedHotels[i];
                         return Padding(
                           padding: const EdgeInsets.only(bottom: 20),
                           child: HotelCard(
                             image: hotel.image,
                             title: hotel.title,
                             address: hotel.address,
                             rating: hotel.rating,
                             reviews: hotel.reviews,
                             price: hotel.price,
                           ),
                         );
                       },
                     ),
             ),
           ),
         ],
       ),
     ),
   );
 }
}



