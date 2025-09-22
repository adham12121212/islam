import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../data/model/zikr_model.dart';


class ActionButtons extends StatelessWidget {
  final Zikr zikr;
  final VoidCallback onReset;
  final VoidCallback onCount;

  const ActionButtons({
    super.key,
    required this.zikr,
    required this.onReset,
    required this.onCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          // Reset Button
          Expanded(
            child: OutlinedButton(
              onPressed: onReset,
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.refresh, size: 20, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    "Reset",
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Count Button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onCount,
              style: ElevatedButton.styleFrom(
                backgroundColor: zikr.color,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 5,
                shadowColor: zikr.color.withOpacity(0.5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.add, size: 24, color: Colors.white),
                  const SizedBox(width: 8),
                  Text(
                    "Count",
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}