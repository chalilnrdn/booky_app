import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class DateSelectionSheet extends StatefulWidget {
 final DateTime? initialStartDate;
 final DateTime? initialEndDate;


 const DateSelectionSheet({
   super.key,
   this.initialStartDate,
   this.initialEndDate,
 });


 @override
 State<DateSelectionSheet> createState() => _DateSelectionSheetState();
}


class _DateSelectionSheetState extends State<DateSelectionSheet> {
 DateTime? _rangeStart;
 DateTime? _rangeEnd;
 DateTime _focusedDay = DateTime.now();


 @override
 void initState() {
   super.initState();
   _rangeStart = widget.initialStartDate;
   _rangeEnd = widget.initialEndDate;
   if (_rangeStart != null) {
     _focusedDay = _rangeStart!;
   }
 }


 @override
 Widget build(BuildContext context) {
   return Container(
     padding: const EdgeInsets.all(20),
     decoration: const BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
     ),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         // Drag handle
         Container(
           width: 40,
           height: 5,
           decoration: BoxDecoration(
             color: Colors.grey[300],
             borderRadius: BorderRadius.circular(10),
           ),
         ),
         const SizedBox(height: 20),


         // Kalender
         TableCalendar(
           firstDay: DateTime.now().subtract(const Duration(days: 365)),
           lastDay: DateTime.now().add(const Duration(days: 730)),
           focusedDay: _focusedDay,
           rangeStartDay: _rangeStart,
           rangeEndDay: _rangeEnd,
           rangeSelectionMode: RangeSelectionMode.toggledOn,


           onDaySelected: (selectedDay, focusedDay) {
             setState(() {
               if (_rangeStart == null || _rangeEnd != null) {
                 _rangeStart = selectedDay;
                 _rangeEnd = null;
               } else {
                 _rangeEnd = selectedDay;
               }
               _focusedDay = selectedDay;
             });
           },


           onRangeSelected: (start, end, focused) {
             setState(() {
               _rangeStart = start;
               _rangeEnd = end;
               _focusedDay = focused;
             });
           },


           headerStyle: const HeaderStyle(
             formatButtonVisible: false,
             titleCentered: true,
             titleTextStyle: TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.bold,
               color: Colors.black,
             ),
           ),


           calendarStyle: CalendarStyle(
             rangeHighlightColor: Colors.black.withOpacity(0.08),


             rangeStartDecoration: const BoxDecoration(
               color: Colors.black,
               shape: BoxShape.circle,
             ),
             rangeEndDecoration: const BoxDecoration(
               color: Colors.black,
               shape: BoxShape.circle,
             ),
             selectedDecoration: const BoxDecoration(
               color: Colors.black,
               shape: BoxShape.circle,
             ),


             // Hari ini
             todayDecoration: BoxDecoration(
               color: Colors.grey[300],
               shape: BoxShape.circle,
             ),


             // Teks hari biasa & weekend
             defaultTextStyle: const TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.bold,
               fontSize: 15,
             ),
             weekendTextStyle: const TextStyle(
               color: Colors.red,
               fontWeight: FontWeight.bold,
               fontSize: 15,
             ),


             // Tanggal di luar bulan (outside days) → abu-abu
             outsideTextStyle: const TextStyle(
               color: Color.fromARGB(255, 206, 206, 206),
               fontWeight: FontWeight.w500,
               fontSize: 15,
             ),


             // Teks di tanggal terpilih
             selectedTextStyle: const TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
             ),
             rangeStartTextStyle: const TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
             ),
             rangeEndTextStyle: const TextStyle(
               color: Colors.white,
               fontWeight: FontWeight.bold,
             ),
             todayTextStyle: const TextStyle(
               color: Colors.black,
               fontWeight: FontWeight.bold,
             ),
           ),
         ),


         const SizedBox(height: 30),


         // Tombol Cancel & Select
         Row(
           children: [
             Expanded(
               child: TextButton(
                 onPressed: () => Navigator.pop(context),
                 child: const Text(
                   'Cancel',
                   style: TextStyle(color: Colors.black54, fontSize: 16),
                 ),
               ),
             ),
             const SizedBox(width: 16),
             Expanded(
               flex: 2,
               child: ElevatedButton(
                 onPressed: _rangeStart == null || _rangeEnd == null
                     ? null
                     : () {
                         Navigator.pop(context, {
                           'start': _rangeStart,
                           'end': _rangeEnd,
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
                 child: const Text('Select', style: TextStyle(fontSize: 16)),
               ),
             ),
           ],
         ),
         const SizedBox(height: 20),
       ],
     ),
   );
 }
}

