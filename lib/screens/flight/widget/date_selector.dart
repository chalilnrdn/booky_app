import 'package:booky_app/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class DateSelectorSheet extends StatefulWidget {
  final DateTime? initialDate;
  const DateSelectorSheet({super.key, this.initialDate});

  @override
  State<DateSelectorSheet> createState() => _DateSelectorSheetState();
}

class _DateSelectorSheetState extends State<DateSelectorSheet> {
  late DateTime focusedDay;
  DateTime? selectedDay;

  @override
  void initState() {
    super.initState();
    focusedDay = widget.initialDate ?? DateTime.now();
    selectedDay = widget.initialDate;
  }

 @override
Widget build(BuildContext context) {
  return Material(
    color: Colors.white,
    child: SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.70, // <-- batasi tinggi sheet
        child: Column(
          children: [

            // Handle indicator
            Container(
              width: 40,
              height: 5,
              margin: const EdgeInsets.only(top: 12, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            Text(
              "Select Date",
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),

            const SizedBox(height: 20),

            // Biar kalender tidak overflow & tetap tampil normal
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TableCalendar(
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: focusedDay,
                  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                  onDaySelected: (selected, focused) {
                    setState(() {
                      selectedDay = selected;
                      focusedDay = focused;
                    });
                  },
                  headerStyle: HeaderStyle(
                    titleCentered: true,
                    formatButtonVisible: false,
                    titleTextStyle: GoogleFonts.inter(
                      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black),
                    leftChevronIcon: Icon(Icons.chevron_left, color: textColor),
                    rightChevronIcon: Icon(Icons.chevron_right, color: textColor),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: GoogleFonts.inter(color: Colors.black87),
                    weekendStyle: GoogleFonts.inter(color: Colors.red),
                  ),
                  calendarStyle: CalendarStyle(
                    selectedDecoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    defaultTextStyle: GoogleFonts.inter(color: Colors.black87),
                    weekendTextStyle: GoogleFonts.inter(color: Colors.red),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                ),
                onPressed: () => Navigator.pop(context, selectedDay),
                child: const Text("Done"),
              ),
            ),

            const SizedBox(height: 12),

            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.black)),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    ),
  );
}

}
