// lib/widgets/destination_card.dart (hanya tambah InkWell)
import 'package:flutter/material.dart';


class DestinationCard extends StatelessWidget {
  final String imageAsset;
  final String title;
  final int price;
  final VoidCallback? onTap; // ← tambah ini


  const DestinationCard({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.price,
    this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: InkWell(                     // ← BUNGKUS DENGAN InkWell
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              SizedBox(
                height: 220,
                width: double.infinity,
                child: Image.asset(imageAsset, fit: BoxFit.cover),
              ),
              Container(
                height: 220,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
              Positioned(
                top: 24,
                left: 20,
                child: Text(title, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              Positioned(
                bottom: 20,
                left: 20,
                child: Text("from \$${price}", style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

