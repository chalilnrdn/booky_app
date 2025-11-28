import 'package:booky_app/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationSelectorSheet extends StatefulWidget {
  final String title;
  const LocationSelectorSheet({super.key, required this.title});

  @override
  State<LocationSelectorSheet> createState() => _LocationSelectorSheetState();
}

class _LocationSelectorSheetState extends State<LocationSelectorSheet> {
  String query = "";

  final Map<String, List<Map<String, String>>> locationRegions = {
    "Asia": [
      {"name": "Singapore (SIN)", "flag": "🇸🇬"},
      {"name": "Tokyo, Japan (HND)", "flag": "🇯🇵"},
      {"name": "Seoul, South Korea (ICN)", "flag": "🇰🇷"},
      {"name": "Bangkok, Thailand (BKK)", "flag": "🇹🇭"},
      {"name": "Kuala Lumpur, Malaysia (KUL)", "flag": "🇲🇾"},
    ],
    "Europe": [
      {"name": "London, United Kingdom (LHR)", "flag": "🇬🇧"},
      {"name": "Paris, France (CDG)", "flag": "🇫🇷"},
    ],
    "America": [
      {"name": "New York, USA (JFK)", "flag": "🇺🇸"},
      {"name": "Los Angeles, USA (LAX)", "flag": "🇺🇸"},
    ],
    "Middle East": [
      {"name": "Dubai, UAE (DXB)", "flag": "🇦🇪"},
    ],
    "Oceania": [
      {"name": "Sydney, Australia (SYD)", "flag": "🇦🇺"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            // drag handle
            Container(
              width: 50,
              height: 5,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            const SizedBox(height: 16),

            Text(
              widget.title,
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            // 🔎 SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: "Search location...",
                  hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  prefixIcon: Icon(Icons.search, color: textColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() => query = value.toLowerCase());
                },
              ),
            ),

            const SizedBox(height: 15),

            // LIST
            Expanded(
              child: ListView(
                children: [
                  for (var region in locationRegions.keys) ...[
                    // FILTERING REGION
                    if (_filteredList(region).isNotEmpty)
                      Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Text(
                          region,
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),

                    ..._filteredList(region).map((item) => Column(
                          children: [
                            ListTile(
                              leading: Text(
                                item["flag"]!,
                                style: const TextStyle(fontSize: 22),
                              ),
                              title: Text(
                                item["name"]!,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              onTap: () => Navigator.pop(context, item["name"]),
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Divider(
                                  color: Colors.grey.shade300, thickness: 1),
                            ),
                          ],
                        )),
                  ],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // FILTER FUNCTION
  List<Map<String, String>> _filteredList(String region) {
    return locationRegions[region]!
        .where((item) =>
            item["name"]!.toLowerCase().contains(query) ||
            item["flag"]!.contains(query))
        .toList();
  }
}
