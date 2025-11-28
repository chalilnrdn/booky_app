// lib/screens/guest_room_sheet.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class GuestRoomSheet extends StatefulWidget {
 final int initialGuests;
 final int initialRooms;


 const GuestRoomSheet({
   super.key,
   required this.initialGuests,
   required this.initialRooms,
 });


 @override
 State<GuestRoomSheet> createState() => _GuestRoomSheetState();
}


class _GuestRoomSheetState extends State<GuestRoomSheet> {
 late int guests;
 late int rooms;


 @override
 void initState() {
   super.initState();
   guests = widget.initialGuests;
   rooms = widget.initialRooms;
 }


 @override
 Widget build(BuildContext context) {
   return Container(
     padding: const EdgeInsets.all(24),
     decoration: const BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
     ),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         // Drag handle
         Center(
           child: Container(
             width: 40,
             height: 5,
             decoration: BoxDecoration(
               color: Colors.grey[300],
               borderRadius: BorderRadius.circular(10),
             ),
           ),
         ),
         const SizedBox(height: 20),


         // Title — HITAM
         Text(
           'Guest and room',
           style: GoogleFonts.inter(
             fontSize: 22,
             fontWeight: FontWeight.bold,
             color: Colors.black,
           ),
         ),
         const SizedBox(height: 24),


         // Guests Counter
         _buildCounterRow(
           icon: Icons.person_outline,
           iconColor: Colors.orange[100]!,
           label: 'Guests',
           value: guests,
           onDecrease: () => setState(() => guests = (guests > 1) ? guests - 1 : 1),
           onIncrease: () => setState(() => guests += 1),
         ),
         const SizedBox(height: 16),


         // Rooms Counter
         _buildCounterRow(
           icon: Icons.king_bed_outlined,
           iconColor: Colors.purple[100]!,
           label: 'Rooms',
           value: rooms,
           onDecrease: () => setState(() => rooms = (rooms > 1) ? rooms - 1 : 1),
           onIncrease: () => setState(() => rooms += 1),
         ),


         const SizedBox(height: 32),


         // Buttons
         Row(
           children: [
             Expanded(
               child: TextButton(
                 onPressed: () => Navigator.pop(context),
                 child: const Text(
                   'Cancel',
                   style: TextStyle(color: Colors.black54, fontSize: 16), // tetap abu biar beda
                 ),
               ),
             ),
             const SizedBox(width: 16),
             Expanded(
               flex: 2,
               child: ElevatedButton(
                 onPressed: () {
                   Navigator.pop(context, {
                     'guests': guests,
                     'rooms': rooms,
                   });
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.black,
                   foregroundColor: Colors.white,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(30),
                   ),
                   padding: const EdgeInsets.symmetric(vertical: 16),
                 ),
                 child: const Text('Done', style: TextStyle(fontSize: 16, color: Colors.white)),
               ),
             ),
           ],
         ),
         SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
       ],
     ),
   );
 }


 Widget _buildCounterRow({
   required IconData icon,
   required Color iconColor,
   required String label,
   required int value,
   required VoidCallback onDecrease,
   required VoidCallback onIncrease,
 }) {
   return Container(
     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
     decoration: BoxDecoration(
       color: Colors.grey[50],
       borderRadius: BorderRadius.circular(16),
     ),
     child: Row(
       children: [
         CircleAvatar(
           radius: 22,
           backgroundColor: iconColor,
           child: Icon(icon, color: Colors.black54, size: 26),
         ),
         const SizedBox(width: 16),
         Expanded(
           child: Text(
             label,
             style: GoogleFonts.inter(
               fontSize: 16,
               fontWeight: FontWeight.w600,
               color: Colors.black87, // HITAM
             ),
           ),
         ),
         _counterButton(Icons.remove_circle_outline, onDecrease, value == 1),
         const SizedBox(width: 12),
         Text(
           '$value',
           style: GoogleFonts.inter(
             fontSize: 24,
             fontWeight: FontWeight.bold,
             color: Colors.black, // ANGKA HITAM PEKAT
           ),
         ),
         const SizedBox(width: 12),
         _counterButton(Icons.add_circle_outline, onIncrease, false),
       ],
     ),
   );
 }


 Widget _counterButton(IconData icon, VoidCallback onPressed, bool disabled) {
   return GestureDetector(
     onTap: disabled ? null : onPressed,
     child: Container(
       padding: const EdgeInsets.all(8),
       decoration: BoxDecoration(
         shape: BoxShape.circle,
         color: disabled ? Colors.grey[300] : Colors.black,
       ),
       child: Icon(icon, color: Colors.white, size: 28),
     ),
   );
 }
}

