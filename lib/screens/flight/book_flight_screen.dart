import 'package:booky_app/models/passenger_count.dart';
import 'package:booky_app/screens/flight/flight_screen.dart';
import 'package:booky_app/screens/flight/widget/date_selector.dart';
import 'package:booky_app/screens/flight/widget/location_selector.dart';
import 'package:booky_app/screens/flight/widget/passenger_selector.dart';
import 'package:booky_app/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';


class BookFlightScreen extends StatefulWidget {
  const BookFlightScreen({super.key});

  @override
  State<BookFlightScreen> createState() => _BookFlightScreenState();
}

class _BookFlightScreenState extends State<BookFlightScreen> {
  PassengerCount passengers = const PassengerCount();
  DateTime? departureDate;
  String? fromLocation;
  String? toLocation;

  // FORMAT DATE → Monday, 24 November 2025
  String formatDate(DateTime date) {
    return DateFormat("EEEE, d MMMM yyyy", "en_US").format(date);
  }

  // AUTO-SWAP function
  void autoSwapIfSame() {
    if (fromLocation != null &&
        toLocation != null &&
        fromLocation == toLocation) {
      // swap otomatis
      final temp = fromLocation;
      fromLocation = toLocation;
      toLocation = temp;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D0D0D),
        elevation: 0,
        leading: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
        
        title: Text("Book Flight", style: GoogleFonts.inter(color: Colors.white),
      ),
      ),
      

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              "Booking",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            const SizedBox(height: 6),
            const Text("Choose your favorite airlines and enjoy the service", style: TextStyle(color: Colors.white), ),
            const SizedBox(height: 20),

            // Trip type
            Row(
              children: [
                tripTypeChip("One way", true),
                const SizedBox(width: 10),
                tripTypeChip("Round Trip", false),
                const SizedBox(width: 10),
                tripTypeChip("Multi-City", false),
              ],
            ),

            const SizedBox(height: 30),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // LEFT SIDE → From + To stacked vertically
                Expanded(
                  child: Column(
                    children: [
                      bookingTile(
                        title: "From",
                        value: fromLocation ?? "Select Location",
                        onTap: () async {
                          final result = await showCupertinoModalBottomSheet(
                            context: context,
                            builder: (_) => LocationSelectorSheet(
                              title: "Select From Location",
                            ),
                          );

                          if (result != null) {
                            setState(() => fromLocation = result);
                          }
                        },
                      ),

                      bookingTile(
                        title: "To",
                        value: toLocation ?? "Select Location",
                        onTap: () async {
                          final result = await showCupertinoModalBottomSheet(
                            context: context,
                            builder: (_) => LocationSelectorSheet(
                              title: "Select Destination",
                            ),
                          );

                          if (result != null) {
                            setState(() => toLocation = result);
                          }
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // RIGHT SIDE → Swap Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (fromLocation != null && toLocation != null) {
                        final temp = fromLocation;
                        fromLocation = toLocation;
                        toLocation = temp;
                      }
                    });
                  },
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_vert,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            // DEPARTURE DATE
            bookingTile(
              title: "Departure",
              value: departureDate == null
                  ? "Select Date"
                  : formatDate(departureDate!),
              onTap: () async {
                final result = await showCupertinoModalBottomSheet(
                  context: context,
                  builder: (_) => DateSelectorSheet(),
                );

                if (result != null && result is DateTime) {
                  setState(() => departureDate = result);
                }
              },
            ),

            // PASSENGERS
            bookingTile(
              title: "Passengers",
              value: passengers.total == 0
                  ? "0 Passengers"
                  : passengers.toString(),
              onTap: () async {
                final result = await showCupertinoModalBottomSheet(
                  context: context,
                  builder: (_) => PassengerSelectorSheet(),
                );

                if (result != null && result is PassengerCount) {
                  setState(() => passengers = result);
                }
              },
            ),

            const Spacer(),

            // SEARCH BUTTON
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FlightResultScreen(
                      from: fromLocation ?? "Unknown",
                      to: toLocation ?? "Unknown",
                      passengers: passengers.total,
                    ),
                  ),
                );
              },
              child: const Text("Search"),
            ),
          ],
        ),
      ),
    );
  }

  // Trip Type component
  Widget tripTypeChip(String text, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.grey.shade900,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: TextStyle(color: active ? textColor : Colors.white),
      ),
    );
  }

  // Booking tile reusable component
  Widget bookingTile({
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),

        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: textColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(value, style: TextStyle(fontSize: 16, color: Colors.white)),
                Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white),
              ],
            ),
          ),
        ),

        const SizedBox(height: 18),
      ],
    );
  }
}
