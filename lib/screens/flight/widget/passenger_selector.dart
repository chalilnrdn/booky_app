import 'package:booky_app/models/passenger_count.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PassengerSelectorSheet extends StatefulWidget {
  final PassengerCount? initial;

  const PassengerSelectorSheet({super.key, this.initial});

  @override
  State<PassengerSelectorSheet> createState() => _PassengerSelectorSheetState();
}

class _PassengerSelectorSheetState extends State<PassengerSelectorSheet> {
  late PassengerCount count;

  @override
  void initState() {
    super.initState();
    count = widget.initial ?? const PassengerCount();
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

          // Title
          Text(
            'Passengers',
            style: GoogleFonts.inter(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),

          const SizedBox(height: 24),

          // Adults → minimal 1
          _buildCounterRow(
            icon: Icons.person_outline,
            iconColor: Colors.orange[100]!,
            label: "Adults",
            value: count.adults,
            onDecrease: () => setState(() {
              if (count.adults > 1) {
                count = count.copyWith(adults: count.adults - 1);
              }
            }),
            onIncrease: () => setState(
              () => count = count.copyWith(adults: count.adults + 1),
            ),
            minValue: 1, // tambahin parameter ini
          ),

          // Children → minimal 0
          _buildCounterRow(
            icon: Icons.child_care_outlined,
            iconColor: Colors.blue[100]!,
            label: "Children",
            value: count.children,
            onDecrease: () => setState(() {
              if (count.children > 0) {
                count = count.copyWith(children: count.children - 1);
              }
            }),
            onIncrease: () => setState(
              () => count = count.copyWith(children: count.children + 1),
            ),
            minValue: 0,
          ),

          // Infants → minimal 0
          _buildCounterRow(
            icon: Icons.baby_changing_station_outlined,
            iconColor: Colors.green[100]!,
            label: "Infants",
            value: count.infants,
            onDecrease: () => setState(() {
              if (count.infants > 0) {
                count = count.copyWith(infants: count.infants - 1);
              }
            }),
            onIncrease: () => setState(
              () => count = count.copyWith(infants: count.infants + 1),
            ),
            minValue: 0,
          ),
          const SizedBox(height: 32),

          // Buttons
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, count),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text("Done", style: TextStyle(fontSize: 16)),
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
    int minValue = 0,
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
                color: Colors.black87,
                decoration: TextDecoration.none,
              ),
            ),
          ),

          _counterButton(Icons.remove_circle_outline, onDecrease, value == 0),

          const SizedBox(width: 12),

          Text(
            "$value",
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.none,
            ),
          ),

          const SizedBox(width: 12),

          _counterButton(Icons.add_circle_outline, onIncrease, false),
        ],
      ),
    );
  }

  Widget _counterButton(IconData icon, VoidCallback onTap, bool disabled) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
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
