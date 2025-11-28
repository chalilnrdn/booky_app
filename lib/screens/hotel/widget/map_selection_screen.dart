import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class MapSelectionScreen extends StatefulWidget {
 final String currentLocation;


 const MapSelectionScreen({super.key, required this.currentLocation});


 @override
 State<MapSelectionScreen> createState() => _MapSelectionScreenState();
}


class _MapSelectionScreenState extends State<MapSelectionScreen> {
 late TextEditingController _controller;


 @override
 void initState() {
   super.initState();
   _controller = TextEditingController(text: widget.currentLocation);
 }


 @override
 void dispose() {
   _controller.dispose();
   super.dispose();
 }


 @override
 Widget build(BuildContext context) {
   return Scaffold(
     body: Stack(
       children: [
         // Dummy map background
         Container(
           width: double.infinity,
           height: double.infinity,
           decoration: const BoxDecoration(
             image: DecorationImage(
               image: AssetImage('assets/images/dummy-map.jpg'),
               fit: BoxFit.cover,
             ),
           ),
         ),


         // Search bar atas (bisa ngetik beneran)
         Positioned(
           top: MediaQuery.of(context).padding.top + 10,
           left: 70,
           right: 20,
           child: Container(
             padding: const EdgeInsets.symmetric(horizontal: 16),
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(30),
               boxShadow: const [
                 BoxShadow(color: Colors.black26, blurRadius: 10),
               ],
             ),
             child: TextField(
               controller: _controller,
               autofocus: true,
               style: const TextStyle(color: Colors.black, fontSize: 16),
               cursorColor: Colors.black,
               decoration: InputDecoration(
                 hintText: 'Search your destination',
                 hintStyle: const TextStyle(color: Colors.grey),
                 border: InputBorder.none,
                 prefixIcon: const Icon(Icons.search, color: Colors.black54),
                 contentPadding: const EdgeInsets.symmetric(vertical: 16),
               ),
             ),
           ),
         ),


         // Tombol Search di bawah (konfirmasi pilihan)
         Positioned(
           bottom: 40,
           left: 40,
           right: 40,
           child: SizedBox(
             height: 60,
             child: ElevatedButton(
               onPressed: () {
                 // Kirim hasil kembali ke screen sebelumnya
                 Navigator.pop(
                   context,
                   _controller.text.trim().isEmpty
                       ? 'Anywhere'
                       : _controller.text,
                 );
               },
               style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.black87,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(30),
                 ),
               ),
               child: Text(
                 'Search',
                 style: GoogleFonts.inter(
                   fontSize: 18,
                   fontWeight: FontWeight.w600,
                   color: Colors.white,
                 ),
               ),
             ),
           ),
         ),


         // Back button
         Positioned(
           top: MediaQuery.of(context).padding.top + 10,
           left: 16,
           child: IconButton(
             icon: const CircleAvatar(
               backgroundColor: Colors.black54,
               child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
             ),
             onPressed: () => Navigator.pop(context),
           ),
         ),
       ],
     ),
   );
 }
}



