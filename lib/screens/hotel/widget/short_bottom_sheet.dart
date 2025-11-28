import 'package:flutter/material.dart';


class SortBottomSheet extends StatelessWidget {
 final String currentSort;
 final Function(String) onSortSelected;


 const SortBottomSheet({
   super.key,
   required this.currentSort,
   required this.onSortSelected,
 });


 final List<Map<String, dynamic>> sorts = const [
   {'label': 'Highest', 'icon': Icons.trending_up},
   {'label': 'Lowest Price', 'icon': Icons.price_check},
   {'label': 'Highest Price', 'icon': Icons.attach_money},
   {'label': 'Highest Rating', 'icon': Icons.star},
   {'label': 'Near Me', 'icon': Icons.location_on},
 ];


 @override
 Widget build(BuildContext context) {
   return Container(
     decoration: const BoxDecoration(
       color: Colors.white,
       borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
     ),
     child: Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         const SizedBox(height: 12),
         Container(
           width: 40,
           height: 5,
           decoration: BoxDecoration(
             color: Colors.grey[300],
             borderRadius: BorderRadius.circular(10),
           ),
         ),
         const Padding(
           padding: EdgeInsets.all(20),
           child: Text(
             "Sort By",
             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
           ),
         ),


         // List sort
         ...sorts.map((item) {
           final bool isSelected = currentSort == item['label'];
           return ListTile(
             leading: Icon(
               item['icon'],
               color: Colors.black,
               size: 26,
             ),
             title: Text(
               item['label'],
               style: TextStyle(
                 color: Colors.black,
                 fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                 fontSize: 16,
               ),
             ),
             trailing: isSelected
                 ? const Icon(Icons.check, color: Colors.black, size: 28)
                 : null,
             onTap: () {
               onSortSelected(item['label']);
               Navigator.pop(context);
             },
           );
         }).toList(),


         const SizedBox(height: 20),


         // Tombol Cancel & Done
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20),
           child: Row(
             children: [
               Expanded(
                 child: TextButton(
                   onPressed: () => Navigator.pop(context),
                   child: const Text("Cancel", style: TextStyle(color: Colors.black54, fontSize: 16)),
                 ),
               ),
               const SizedBox(width: 12),
               Expanded(
                 child: ElevatedButton(
                   onPressed: () => Navigator.pop(context),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.black,
                     padding: const EdgeInsets.symmetric(vertical: 16),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                   ),
                   child: const Text("Done", style: TextStyle(color: Colors.white, fontSize: 16)),
                 ),
               ),
             ],
           ),
         ),
         const SizedBox(height: 30),
       ],
     ),
   );
 }
}

