import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/model/zikr_model.dart';

class ZikrCard extends StatelessWidget {
  final Zikr zikr;
  final int currentCount;
  final int previousCount;

  const ZikrCard({
    super.key,
    required this.zikr,
    required this.currentCount,
    required this.previousCount,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (currentCount - previousCount) / zikr.count;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: zikr.color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: zikr.color.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            zikr.text,
            style: GoogleFonts.tajawal(
              fontSize: 32,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white.withOpacity(0.8),
            ),
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            "${currentCount - previousCount}/${zikr.count}",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}