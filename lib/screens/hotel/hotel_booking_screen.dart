import 'package:booky_app/screens/hotel/hotel_screen.dart';
import 'package:booky_app/screens/hotel/widget/date_selection_sheet.dart';
import 'package:booky_app/screens/hotel/widget/guest_room_sheet.dart';
import 'package:booky_app/screens/hotel/widget/map_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HotelBookingScreen extends StatefulWidget {
  const HotelBookingScreen({super.key});

  @override
  State<HotelBookingScreen> createState() => _HotelBookingScreenState();
}

class _HotelBookingScreenState extends State<HotelBookingScreen> {
  String selectedLocation = '';

  DateTime? dateStart;
  DateTime? dateEnd;

  int guestCount = 0;
  int roomCount = 0;

  String get roomGuestText {
    if (guestCount == 0 || roomCount == 0) return '';
    return '$guestCount Guest${guestCount > 1 ? 's' : ''}, $roomCount Room${roomCount > 1 ? 's' : ''}';
  }

  String get formattedDate {
    if (dateStart == null || dateEnd == null) return '';
    final start = '${dateStart!.day} ${_monthName(dateStart!.month)}';
    final end =
        '${dateEnd!.day} ${_monthName(dateEnd!.month)} ${dateEnd!.year}';
    return '$start - $end';
  }

  String _monthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  // Buka Map
  Future<void> _openMapAndSelectLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MapSelectionScreen(currentLocation: selectedLocation),
      ),
    );
    if (result != null && result is String) {
      setState(() => selectedLocation = result);
    }
  }

  // Buka Kalender (panggil DateSelectionSheet dari components)
  Future<void> _openDatePicker() async {
    final result = await showModalBottomSheet<Map<String, DateTime?>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DateSelectionSheet(
        initialStartDate: dateStart,
        initialEndDate: dateEnd,
      ),
    );

    if (result != null) {
      setState(() {
        dateStart = result['start'];
        dateEnd = result['end'];
      });
    }
  }

  // Buka Guest & Room Picker
  Future<void> _openGuestRoomPicker() async {
    final result = await showModalBottomSheet<Map<String, int>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          GuestRoomSheet(initialGuests: guestCount, initialRooms: roomCount),
    );

    if (result != null) {
      setState(() {
        guestCount = result['guests']!;
        roomCount = result['rooms']!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back_ios_new, size: 20),
        title: Text(selectedLocation),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Booking',
              style: GoogleFonts.inter(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose your favorite hotel and enjoy the service',
              style: GoogleFonts.inter(fontSize: 15, color: Colors.white70),
            ),
            const SizedBox(height: 40),

            GestureDetector(
              onTap: _openMapAndSelectLocation,
              child: _cardItem(
                icon: Icons.location_on,
                iconBgColor: const Color(0xFF8B4513).withOpacity(0.2),
                iconColor: const Color(0xFF8B4513),
                title: 'Location',
                value: selectedLocation,
              ),
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: _openDatePicker,
              child: _cardItem(
                icon: Icons.date_range,
                iconBgColor: const Color(0xFF3949AB).withOpacity(0.2),
                iconColor: const Color(0xFF3949AB),
                title: 'Select Date',
                value: formattedDate,
              ),
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: _openGuestRoomPicker,
              child: _cardItem(
                icon: Icons.king_bed,
                iconBgColor: const Color(0xFF2E7D32).withOpacity(0.2),
                iconColor: const Color(0xFF2E7D32),
                title: 'Room',
                value: roomGuestText,
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => HotelsPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Search',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _cardItem({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    final bool filled = value.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: filled ? Colors.white : const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(18),
        boxShadow: filled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: filled
                ? iconBgColor.withOpacity(0.3)
                : iconBgColor,
            child: Icon(
              icon,
              color: filled ? Colors.black87 : iconColor,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: filled ? Colors.black54 : Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isEmpty ? 'Not selected' : value,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: filled ? Colors.black : Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: filled ? Colors.black38 : Colors.white38,
            size: 28,
          ),
        ],
      ),
    );
  }
}
