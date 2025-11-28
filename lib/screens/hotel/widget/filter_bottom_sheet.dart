// lib/components/filter_bottom_sheet.dart
import 'package:booky_app/utils/consts.dart';
import 'package:flutter/material.dart';


class FilterBottomSheet extends StatefulWidget {
 final double minPrice;
 final double maxPrice;
 final int selectedRating;
 final Set<String> selectedFacilities;
 final Function(double, double, int, Set<String>) onApply;


 const FilterBottomSheet({
   super.key, required this.minPrice, required this.maxPrice, required this.selectedRating, required this.selectedFacilities, required this.onApply,
 });


 @override
 State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}


class _FilterBottomSheetState extends State<FilterBottomSheet> {
 late double _minPrice;
 late double _maxPrice;
 late int _selectedRating;
 late Set<String> _selectedFacilities;


 @override
 void initState() {
   super.initState();
   _minPrice = widget.minPrice;
   _maxPrice = widget.maxPrice;
   _selectedRating = widget.selectedRating;
   _selectedFacilities = Set.from(widget.selectedFacilities);
 }


 @override
 Widget build(BuildContext context) {
   return Container(
     decoration: const BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
     ),
     padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         const SizedBox(height: 12),
         Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
         const Padding(
           padding: EdgeInsets.all(20),
           child: Text("Filter", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
         ),


         // Budget
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               const Text("Budget", style: TextStyle(fontWeight: FontWeight.w600, color: textColor )),
               const SizedBox(height: 12),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   Text("\$${_minPrice.toInt()}", style: const TextStyle(fontWeight: FontWeight.w600,  color: textColor)),
                   Text("\$${_maxPrice.toInt()}", style: const TextStyle(fontWeight: FontWeight.w600,  color: textColor)),
                 ],
               ),
               RangeSlider(
                 values: RangeValues(_minPrice, _maxPrice),
                 min: 10,
                 max: 1000,
                 divisions: 99,
                 onChanged: (values) => setState(() {
                   _minPrice = values.start;
                   _maxPrice = values.end;
                 }),
               ),
             ],
           ),
         ),


         const SizedBox(height: 24),


         // Rating
         const Padding(
           padding: EdgeInsets.symmetric(horizontal: 20),
           child: Align(alignment: Alignment.centerLeft, child: Text("Rate", style: TextStyle(fontWeight: FontWeight.w600,  color: Colors.black))),
         ),
         const SizedBox(height: 12),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: List.generate(5, (i) {
             return GestureDetector(
               onTap: () => setState(() => _selectedRating = i + 1),
               child: Icon(
                 i < _selectedRating ? Icons.star : Icons.star_border,
                 color: Colors.amber,
                 size: 40,
               ),
             );
           }),
         ),


         const SizedBox(height: 30),


         // Facilities
         const Padding(
           padding: EdgeInsets.symmetric(horizontal: 20),
           child: Align(alignment: Alignment.centerLeft, child: Text("Others", style: TextStyle(fontWeight: FontWeight.w600,  color: textColor))),
          
         ),
         const SizedBox(height: 12),
        
         _facilityTile("Television", Icons.tv),
         _facilityTile("Swimming Pool", Icons.pool),
         _facilityTile("Restaurant", Icons.restaurant),
         _facilityTile("Car Rental", Icons.directions_car),


         const SizedBox(height: 30),


         // Buttons
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20),
           child: Row(
             children: [
               Expanded(
                 child: TextButton(
                   onPressed: () => Navigator.pop(context),
                   child: const Text("Cancel", style: TextStyle(color: textColor, fontSize: 16)),
                 ),
               ),
               const SizedBox(width: 12),
               Expanded(
                 child: ElevatedButton(
                   onPressed: () {
                     widget.onApply(_minPrice, _maxPrice, _selectedRating, _selectedFacilities);
                     Navigator.pop(context);
                   },
                   style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 16)),
                   child: const Text("Done", style: TextStyle(color: Colors.white)),
                 ),
               ),
             ],
           ),
         ),
         const SizedBox(height: 20),
       ],
     ),
   );
 }
Widget _facilityTile(String title, IconData icon) {
 bool selected = _selectedFacilities.contains(title);


 return ListTile(
   onTap: () {
     setState(() {
       if (selected) {
         _selectedFacilities.remove(title);
       } else {
         _selectedFacilities.add(title);
       }
     });
   },
   leading: Icon(icon, color: Colors.black),
   title: Text(
     title,
     style: const TextStyle(color: textColor, fontSize: 16),
   ),
   trailing: SizedBox(
     width: 26,
     height: 26,
     child: Checkbox(
       value: selected,
       activeColor: Colors.transparent,          
       checkColor: Colors.black,                 
       side: const BorderSide(color: Colors.black54, width: 2),
       shape: RoundedRectangleBorder(
         borderRadius: BorderRadius.circular(6),
       ),
       materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
       onChanged: (val) {
         setState(() {
           if (val == true) {
             _selectedFacilities.add(title);
           } else {
             _selectedFacilities.remove(title);
           }
         });
       },
     ),
   ),
 );
}
}

